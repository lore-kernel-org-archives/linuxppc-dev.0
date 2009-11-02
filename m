Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C3C0100810
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 09:02:42 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 27/28] Use hrtimers for the decrementer
Date: Mon,  2 Nov 2009 23:02:31 +0100
Message-Id: <1257199351-2238-3-git-send-email-agraf@suse.de>
In-Reply-To: <1257199351-2238-1-git-send-email-agraf@suse.de>
References: <1257199351-2238-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following S390's good example we should use hrtimers for the decrementer too!
This patch converts the timer from the old mechanism to hrtimers.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v6 -> v7:

  - remove non-hrtimer export
---
 arch/powerpc/include/asm/kvm_host.h |    6 ++++--
 arch/powerpc/kernel/ppc_ksyms.c     |    3 +--
 arch/powerpc/kvm/emulate.c          |   18 +++++++++++-------
 arch/powerpc/kvm/powerpc.c          |   20 ++++++++++++++++++--
 4 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2cff5fe..1201f62 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -21,7 +21,8 @@
 #define __POWERPC_KVM_HOST_H__
 
 #include <linux/mutex.h>
-#include <linux/timer.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/kvm_types.h>
 #include <asm/kvm_asm.h>
@@ -250,7 +251,8 @@ struct kvm_vcpu_arch {
 
 	u32 cpr0_cfgaddr; /* holds the last set cpr0_cfgaddr */
 
-	struct timer_list dec_timer;
+	struct hrtimer dec_timer;
+	struct tasklet_struct tasklet;
 	u64 dec_jiffies;
 	unsigned long pending_exceptions;
 
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index baf778c..c8b27bb 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -163,12 +163,11 @@ EXPORT_SYMBOL(screen_info);
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
+EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(cacheable_memzero);
 #endif
 
-EXPORT_SYMBOL(tb_ticks_per_jiffy);
-
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(switch_mmu_context);
 #endif
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 1ec5e07..4a9ac66 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -18,7 +18,7 @@
  */
 
 #include <linux/jiffies.h>
-#include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kvm_host.h>
@@ -79,12 +79,13 @@ static int kvmppc_dec_enabled(struct kvm_vcpu *vcpu)
 
 void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 {
-	unsigned long nr_jiffies;
+	unsigned long dec_nsec;
 
+	pr_debug("mtDEC: %x\n", vcpu->arch.dec);
 #ifdef CONFIG_PPC64
 	/* POWER4+ triggers a dec interrupt if the value is < 0 */
 	if (vcpu->arch.dec & 0x80000000) {
-		del_timer(&vcpu->arch.dec_timer);
+		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
 		kvmppc_core_queue_dec(vcpu);
 		return;
 	}
@@ -94,12 +95,15 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 		 * that's how we convert the guest DEC value to the number of
 		 * host ticks. */
 
+		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
+		dec_nsec = vcpu->arch.dec;
+		dec_nsec *= 1000;
+		dec_nsec /= tb_ticks_per_usec;
+		hrtimer_start(&vcpu->arch.dec_timer, ktime_set(0, dec_nsec),
+			      HRTIMER_MODE_REL);
 		vcpu->arch.dec_jiffies = get_tb();
-		nr_jiffies = vcpu->arch.dec / tb_ticks_per_jiffy;
-		mod_timer(&vcpu->arch.dec_timer,
-		          get_jiffies_64() + nr_jiffies);
 	} else {
-		del_timer(&vcpu->arch.dec_timer);
+		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
 	}
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 4ae3490..4c582ed 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -23,6 +23,7 @@
 #include <linux/kvm_host.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+#include <linux/hrtimer.h>
 #include <linux/fs.h>
 #include <asm/cputable.h>
 #include <asm/uaccess.h>
@@ -209,10 +210,25 @@ static void kvmppc_decrementer_func(unsigned long data)
 	}
 }
 
+/*
+ * low level hrtimer wake routine. Because this runs in hardirq context
+ * we schedule a tasklet to do the real work.
+ */
+enum hrtimer_restart kvmppc_decrementer_wakeup(struct hrtimer *timer)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = container_of(timer, struct kvm_vcpu, arch.dec_timer);
+	tasklet_schedule(&vcpu->arch.tasklet);
+
+	return HRTIMER_NORESTART;
+}
+
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	setup_timer(&vcpu->arch.dec_timer, kvmppc_decrementer_func,
-	            (unsigned long)vcpu);
+	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	tasklet_init(&vcpu->arch.tasklet, kvmppc_decrementer_func, (ulong)vcpu);
+	vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
 
 	return 0;
 }
-- 
1.6.0.2
