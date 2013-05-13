Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DD742C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 12:00:49 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <agraf@suse.de>, <scottwood@freescale.com>
Subject: [v3][KVM][PATCH 1/1] kvm:ppc: control doorbell exception with
 CONFIG_PPC_DOORBELL
Date: Mon, 13 May 2013 10:00:45 +0800
Message-ID: <1368410445-4969-1-git-send-email-tiejun.chen@windriver.com>
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

We can only use CONFIG_PPC_DOORBELL to control whether
the doorbell exception should be enabled.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
v3:

Just imporve the patch head.

v2: 

Use CONFIG_PPC_DOORBELL to replace CONFIG_KVM_E500MC as that control condition.


 arch/powerpc/kvm/booke.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ac7ab08..2d063c7 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -794,7 +794,7 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
 		kvmppc_fill_pt_regs(&regs);
 		timer_interrupt(&regs);
 		break;
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
+#if defined(CONFIG_PPC_DOORBELL)
 	case BOOKE_INTERRUPT_DOORBELL:
 		kvmppc_fill_pt_regs(&regs);
 		doorbell_exception(&regs);
-- 
1.7.9.5
