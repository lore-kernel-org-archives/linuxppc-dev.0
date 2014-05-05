Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3211140180
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:56 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7CDF03578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516aQP1310998
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451Rpa4000960
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 01/22] powerpc: Introduce CONFIG_KVM_EEH
Date: Mon,  5 May 2014 11:27:50 +1000
Message-Id: <1399253291-3975-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces kernel configuration option KVM_EEH, which
depends on KVM_BOOK3S_64, VFIO_IOMMU_SPAPR_TCE and EEH. The option
is to enable emulating EEH RTAS services that required by EEH
module in pSeries-based guest.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 141b202..743d2d9 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -189,6 +189,14 @@ config KVM_XICS
 	  Specification) interrupt controller architecture used on
 	  IBM POWER (pSeries) servers.
 
+config KVM_EEH
+	bool "KVM in-kernel EEH RTAS emulation"
+	depends on PPC_POWERNV && KVM_BOOK3S_64 && EEH && VFIO_IOMMU_SPAPR_TCE
+	default y
+	---help---
+	  Enable support for emulating EEH RTAS services used on IBM
+	  POWER (pSeries) servers.
+
 source drivers/vhost/Kconfig
 
 endif # VIRTUALIZATION
-- 
1.8.3.2
