Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22n3VjdzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:17 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 05/17] powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB
Date: Mon, 21 Mar 2016 14:53:12 +1100
Message-Id: <1458532404-21258-6-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
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
index 19aa59b..1803c96 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -521,7 +521,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_SPAPR_TCE_64:
-	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
 	case KVM_CAP_PPC_ENABLE_HCALL:
@@ -530,6 +529,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
