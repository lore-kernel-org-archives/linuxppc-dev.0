Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 779312C0181
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 10:54:59 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id lj1so183538pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 17:54:57 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/10] KVM: PPC: enable IOMMU_API for KVM_BOOK3S_64 permanently
Date: Tue, 16 Jul 2013 10:54:01 +1000
Message-Id: <1373936045-22653-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
References: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It does not make much sense to have KVM in book3s-64bit and
not to have IOMMU bits for PCI pass through support as it costs little
and allows VFIO to function on book3s-kvm.

Having IOMMU_API enabled will make it unnecessary to have a lot of
IOMMU_API enabled, those files only accelerate user space emulated devices
which do not seem to be in use very often.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index c55c538..3b2b761 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -59,6 +59,7 @@ config KVM_BOOK3S_64
 	depends on PPC_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
+	select SPAPR_TCE_IOMMU
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
-- 
1.8.3.2
