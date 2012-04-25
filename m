Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06704B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 15:11:54 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Apr 2012 05:07:03 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3P55070450748
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 15:05:00 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3P5BgiK013732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 15:11:42 +1000
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc/pseries: rivet CONFIG_EEH for pSeries platform
Date: Wed, 25 Apr 2012 13:11:22 +0800
Message-Id: <1335330682-27562-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: openspace.wang@gmail.com, nacc@linux.vnet.ibm.com,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently, Ryan Wang tried to compile PPC pSeries platform without
CONFIG_EEH and eventually run into errors. Nishanth Aravamudan
helped to narrow down the root cause. Actually, the pSeries platform
depends on CONFIG_EEH heavily and that won't work properly without
EEH support.

According to Ben's suggestion, the patch make CONFIG_EEH invisible
and keep it as always selected on pSeries platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index aadbe4f..178a5f3 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -30,9 +30,9 @@ config PPC_SPLPAR
 	  two or more partitions.
 
 config EEH
-	bool "PCI Extended Error Handling (EEH)" if EXPERT
+	bool
 	depends on PPC_PSERIES && PCI
-	default y if !EXPERT
+	default y
 
 config PSERIES_MSI
        bool
-- 
1.7.5.4
