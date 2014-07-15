Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 697C51A01E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:42 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:41 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B93053578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9PMw99503130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9Pb2o022313
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:38 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 03/13] KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64
 permanently
Date: Tue, 15 Jul 2014 19:25:23 +1000
Message-Id: <1405416333-12477-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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
index d7a16ac6..301fa6b 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -63,6 +63,7 @@ config KVM_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
+	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
-- 
2.0.0
