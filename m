Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 845CF2C025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:46:31 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:46:28 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6A4E6C90052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:46:25 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIkOEa64946328
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:46:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIkOdK013359
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:46:24 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIkNuO013287
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:46:23 -0300
Message-ID: <5175857F.1090407@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:46:23 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 10/12] Re-enable Virtual Private Home Node capabilities
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

The new PRRN firmware feature provides a more convenient and event-driven
interface than VPHN for notifying Linux of changes to the NUMA affinity of
platform resources. However, for practical reasons, it may not be feasible
for some customers to update to the latest firmware. For these customers,
the VPHN feature supported on previous firmware versions may still be the
best option.

The VPHN feature was previously disabled due to races with the load
balancing code when accessing the NUMA cpu maps, but the new stop_machine()
approach protects the NUMA cpu maps from these concurrent accesses. It
should be safe to re-enable this feature now.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-04-22 09:39:02.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-04-22 09:46:13.000000000 -0500
@@ -1572,9 +1572,8 @@
 			vphn_enabled = 0;
 			rc = of_reconfig_notifier_register(&dt_update_nb);
 		}
-	} else if (0 && firmware_has_feature(FW_FEATURE_VPHN) &&
+	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
 		   get_lppaca()->shared_proc) {
-		/* Disabled until races with load balancing are fixed */
 		if (!vphn_enabled) {
 			prrn_enabled = 0;
 			vphn_enabled = 1;
