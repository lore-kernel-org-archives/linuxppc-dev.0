Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CA31B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:24 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 37/38] KVM: PPC: booke: Reinject performance monitor interrupts
Date: Wed, 29 Feb 2012 01:10:05 +0100
Message-Id: <1330474206-14794-38-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we get a performance monitor interrupt, we need to make sure that
the host receives it. So reinject it like we reinject the other host
destined interrupts.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v2 -> v3:

  - call regs sync directly
---
 arch/powerpc/include/asm/hw_irq.h |    1 +
 arch/powerpc/kvm/booke.c          |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index bb712c9..904e66c 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 
 extern void timer_interrupt(struct pt_regs *);
+extern void performance_monitor_exception(struct pt_regs *regs);
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 488936b..8e8aa4c 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -634,6 +634,10 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
 	case BOOKE_INTERRUPT_MACHINE_CHECK:
 		/* FIXME */
 		break;
+	case BOOKE_INTERRUPT_PERFORMANCE_MONITOR:
+		kvmppc_fill_pt_regs(&regs);
+		performance_monitor_exception(&regs);
+		break;
 	}
 }
 
-- 
1.6.0.2
