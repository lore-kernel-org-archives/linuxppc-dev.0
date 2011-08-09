Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14500B732D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:32:00 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 10/10] KVM: PPC: Enable the PAPR CAP for Book3S
Date: Tue,  9 Aug 2011 18:31:48 +0200
Message-Id: <1312907508-14599-11-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that Book3S PV mode can also run PAPR guests, we can add a PAPR cap and
enable it for all Book3S targets. Enabling that CAP switches KVM into PAPR
mode.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/powerpc.c |    5 +++++
 include/linux/kvm.h        |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 17a5c83..13bc798 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -189,6 +189,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 #else
 	case KVM_CAP_PPC_SEGSTATE:
 	case KVM_CAP_PPC_HIOR:
+	case KVM_CAP_PPC_PAPR:
 #endif
 	case KVM_CAP_PPC_UNSET_IRQ:
 	case KVM_CAP_PPC_IRQ_LEVEL:
@@ -572,6 +573,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		r = 0;
 		vcpu->arch.osi_enabled = true;
 		break;
+	case KVM_CAP_PPC_PAPR:
+		r = 0;
+		vcpu->arch.papr_enabled = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 4d33f78..2d7161c 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -555,6 +555,7 @@ struct kvm_ppc_pvinfo {
 #define KVM_CAP_PPC_RMA	65
 #define KVM_CAP_MAX_VCPUS 66       /* returns max vcpus per vm */
 #define KVM_CAP_PPC_HIOR 67
+#define KVM_CAP_PPC_PAPR 68
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.6.0.2
