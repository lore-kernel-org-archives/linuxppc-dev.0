Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s49yK2YrrzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 21:36:41 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id i5so35869691wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 04:36:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH] powerpc: move hmi.c to arch/powerpc/kvm/
Date: Wed,  3 Aug 2016 13:36:34 +0200
Message-Id: <1470224194-15412-1-git-send-email-pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hmi.c functions are unused unless sibling_subcore_state is nonzero, and
that in turn happens only if KVM is in use.  So move the code to
arch/powerpc/kvm/, putting it under CONFIG_KVM_BOOK3S_64_HANDLER
rather than CONFIG_PPC_BOOK3S_64.  The sibling_subcore_state is also
included in struct paca_struct only if KVM is supported by the kernel.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	It would be nice to have this in 4.8, to minimize any 4.9 conflicts.
	Build-tested only, with and without KVM enabled.

 arch/powerpc/include/asm/hmi.h                     |  2 +-
 arch/powerpc/include/asm/paca.h                    | 10 +++++-----
 arch/powerpc/kernel/Makefile                       |  2 +-
 arch/powerpc/kvm/Makefile                          |  1 +
 arch/powerpc/{kernel/hmi.c => kvm/book3s_hv_hmi.c} |  0
 5 files changed, 8 insertions(+), 7 deletions(-)
 rename arch/powerpc/{kernel/hmi.c => kvm/book3s_hv_hmi.c} (100%)

diff --git a/arch/powerpc/include/asm/hmi.h b/arch/powerpc/include/asm/hmi.h
index 88b4901ac4ee..d3b6ad6e137c 100644
--- a/arch/powerpc/include/asm/hmi.h
+++ b/arch/powerpc/include/asm/hmi.h
@@ -21,7 +21,7 @@
 #ifndef __ASM_PPC64_HMI_H__
 #define __ASM_PPC64_HMI_H__
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 
 #define	CORE_TB_RESYNC_REQ_BIT		63
 #define MAX_SUBCORE_PER_CORE		4
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 148303e7771f..625321e7e581 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -183,11 +183,6 @@ struct paca_struct {
 	 */
 	u16 in_mce;
 	u8 hmi_event_available;		 /* HMI event is available */
-	/*
-	 * Bitmap for sibling subcore status. See kvm/book3s_hv_ras.c for
-	 * more details
-	 */
-	struct sibling_subcore_state *sibling_subcore_state;
 #endif
 
 	/* Stuff for accurate time accounting */
@@ -202,6 +197,11 @@ struct paca_struct {
 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
 #endif
 	struct kvmppc_host_state kvm_hstate;
+	/*
+	 * Bitmap for sibling subcore status. See kvm/book3s_hv_ras.c for
+	 * more details
+	 */
+	struct sibling_subcore_state *sibling_subcore_state;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b2027a5cf508..fe4c075bcf50 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o hmi.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 1f9e5529e692..855d4b95d752 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -78,6 +78,7 @@ kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) := \
 
 ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
+	book3s_hv_hmi.o \
 	book3s_hv_rmhandlers.o \
 	book3s_hv_rm_mmu.o \
 	book3s_hv_ras.o \
diff --git a/arch/powerpc/kernel/hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
similarity index 100%
rename from arch/powerpc/kernel/hmi.c
rename to arch/powerpc/kvm/book3s_hv_hmi.c
-- 
1.8.3.1
