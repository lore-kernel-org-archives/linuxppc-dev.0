Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E74B02C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 12:54:02 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <agraf@suse.de>
Subject: [v1][KVM][PATCH 1/1] kvm:ppc: enable doorbell exception with E500MC
Date: Mon, 6 May 2013 10:53:56 +0800
Message-ID: <1367808836-28635-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Actually E500MC also support doorbell exception, and CONFIG_PPC_E500MC
can cover BOOK3E/BOOK3E_64 as well.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kvm/booke.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 1020119..dc1f590 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -795,7 +795,7 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
 		kvmppc_fill_pt_regs(&regs);
 		timer_interrupt(&regs);
 		break;
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
+#if defined(CONFIG_PPC_E500MC)
 	case BOOKE_INTERRUPT_DOORBELL:
 		kvmppc_fill_pt_regs(&regs);
 		doorbell_exception(&regs);
-- 
1.7.9.5
