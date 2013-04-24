Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A6992C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 02:05:51 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 12:05:48 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6631E38C8080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 12:05:42 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OG5eVe284136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 12:05:40 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OG5YCg028702
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:05:34 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OG5W8w028386
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:05:33 -0600
Message-ID: <517802C2.8060908@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:05:22 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 11/13] RE-enable Virtual Processor Home Node updating
References: <5177FB74.2050709@linux.vnet.ibm.com>
In-Reply-To: <5177FB74.2050709@linux.vnet.ibm.com>
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
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-04-23 15:28:21.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-04-23 15:29:39.000000000 -0500
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
