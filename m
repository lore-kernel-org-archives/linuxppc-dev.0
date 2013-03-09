Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74D4B2C037D
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:08:11 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:08:09 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 28D4D1FF003E
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:03:13 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r29486Ma104828
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:06 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r29486pi025951
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:06 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r29484V0025881
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:05 -0700
Message-ID: <513AB5A4.1060202@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:08:04 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/11] Re-enable Virtual Private Home Node capabilities
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
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
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-08 19:57:59.000000000 -0600
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-08 19:58:09.000000000 -0600
@@ -1545,9 +1545,8 @@
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
