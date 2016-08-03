Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464G2mWpzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:34 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 12/15] KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64
 permanently
Date: Wed,  3 Aug 2016 18:40:53 +1000
Message-Id: <1470213656-1042-13-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It does not make much sense to have KVM in book3s-64 and
not to have IOMMU bits for PCI pass through support as it costs little
and allows VFIO to function on book3s KVM.

Having IOMMU_API always enabled makes it unnecessary to have a lot of
"#ifdef IOMMU_API" in arch/powerpc/kvm/book3s_64_vio*. With those
ifdef's we could have only user space emulated devices accelerated
(but not VFIO) which do not seem to be very useful.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index b7c494b..63b60a8 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -65,6 +65,7 @@ config KVM_BOOK3S_64
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
 	select KVM_VFIO if VFIO
+	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
-- 
2.5.0.rc3
