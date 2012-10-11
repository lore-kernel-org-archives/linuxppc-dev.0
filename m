Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 07B462C03C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:27 +1100 (EST)
Received: from mail200-ch1 (localhost [127.0.0.1])	by
 mail200-ch1-R.bigfish.com (Postfix) with ESMTP id F26D21601AE	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:22 +0000 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail200-ch1.bigfish.com (Postfix) with ESMTP id
 200F240006E	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:21
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBif028141	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:17 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 12/12] KVM: PPC: booke: Get/set guest EPCR register using
 ONE_REG interface
Date: Thu, 11 Oct 2012 19:13:29 +0300
Message-ID: <1349972009-23027-13-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement ONE_REG interface for EPCR register adding KVM_REG_PPC_EPCR to
the list of ONE_REG PPC supported registers.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 Documentation/virtual/kvm/api.txt |    1 +
 arch/powerpc/include/asm/kvm.h    |    2 ++
 arch/powerpc/kvm/booke.c          |   16 ++++++++++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index e726d76..c78dff4 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1773,6 +1773,7 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_VPA_ADDR  | 64
   PPC   | KVM_REG_PPC_VPA_SLB   | 128
   PPC   | KVM_REG_PPC_VPA_DTL   | 128
+  PPC   | KVM_REG_PPC_EPCR	| 32
 
 4.69 KVM_GET_ONE_REG
 
diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index b89ae4d..beb6b20 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -386,4 +386,6 @@ struct kvm_book3e_206_tlb_params {
 #define KVM_REG_PPC_VPA_SLB	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x83)
 #define KVM_REG_PPC_VPA_DTL	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x84)
 
+#define KVM_REG_PPC_EPCR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x85)
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index d396374..60b8237 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1395,6 +1395,12 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 				 &vcpu->arch.dbg_reg.dac[dac], sizeof(u64));
 		break;
 	}
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+	case KVM_REG_PPC_EPCR:
+		r = copy_to_user((u32 __user *)(long)reg->addr,
+				 &vcpu->arch.epcr, sizeof(u32));
+		break;
+#endif
 	default:
 		break;
 	}
@@ -1422,6 +1428,16 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 			     (u64 __user *)(long)reg->addr, sizeof(u64));
 		break;
 	}
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+	case KVM_REG_PPC_EPCR: {
+		u32 new_epcr;
+		r = copy_from_user(&new_epcr,
+			     (u32 __user *)(long)reg->addr, sizeof(u32));
+		if (r == 0)
+			kvmppc_set_epcr(vcpu, new_epcr);
+		break;
+	}
+#endif
 	default:
 		break;
 	}
-- 
1.7.4.1
