Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vfYKF5bpmzDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 14:53:53 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v8 06/10] KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64
 permanently
Date: Fri, 10 Mar 2017 14:53:33 +1100
Message-Id: <20170310035337.22091-7-aik@ozlabs.ru>
In-Reply-To: <20170310035337.22091-1-aik@ozlabs.ru>
References: <20170310035337.22091-1-aik@ozlabs.ru>
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 029be26b5a17..65a471de96de 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -67,6 +67,7 @@ config KVM_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
+	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
-- 
2.11.0
