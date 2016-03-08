Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32CA41A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:10 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 09/25] powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB
Date: Tue,  8 Mar 2016 14:08:46 +1100
Message-Id: <1457406542-6210-10-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
References: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present KVM on powerpc always reports KVM_CAP_PPC_ALLOC_HTAB as enabled.
However, the ioctl() it advertises (KVM_PPC_ALLOCATE_HTAB) only actually
works on KVM HV.  On KVM PR it will fail with ENOTTY.

qemu already has a workaround for this, so it's not breaking things in
practice, but it would be better to advertise this correctly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/powerpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a3b182d..2f21ab7 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -509,7 +509,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
-	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
 	case KVM_CAP_PPC_ENABLE_HCALL:
@@ -518,6 +517,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #endif
 		r = 1;
 		break;
+
+	case KVM_CAP_PPC_ALLOC_HTAB:
+		r = hv_enabled;
+		break;
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_SMT:
-- 
2.5.0
