Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C14DC2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 23:45:47 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 29 Apr 2013 07:45:45 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 27743C90068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 09:45:43 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3TDjhgT286832
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 09:45:43 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3TDjhX6018467
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 10:45:43 -0300
Received: from [9.65.14.48] (sig-9-65-14-48.mts.ibm.com [9.65.14.48])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3TDjcp0018231
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 10:45:39 -0300
Message-ID: <517E7980.1030601@linux.vnet.ibm.com>
Date: Mon, 29 Apr 2013 08:45:36 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: correct builds break when CONFIG_SMP not
 defined
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct build failure for powerpc/pseries builds with CONFIG_SMP not defined.

The function cpu_sibling_mask has no meaning (or definition) when CONFIG_SMP
is not defined. Additionally, the updating of NUMA affinity for a CPU in a UP
system doesn't really make sense.

This patch ifdef's out the code making the affinity updates for PRRN events to
fix the following build break.

arch/powerpc/mm/numa.c: In function ‘stage_topology_update’:
arch/powerpc/mm/numa.c:1535: error: implicit declaration of function ‘cpu_sibling_mask’
arch/powerpc/mm/numa.c:1535: warning: passing argument 3 of ‘cpumask_or’ makes pointer from integer without a cast
make[1]: *** [arch/powerpc/mm/numa.o] Error 1

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: ppc-next/arch/powerpc/mm/numa.c
===================================================================
--- ppc-next.orig/arch/powerpc/mm/numa.c	2013-04-29 07:16:00.000000000 -0500
+++ ppc-next/arch/powerpc/mm/numa.c	2013-04-29 07:21:35.000000000 -0500
@@ -1529,6 +1529,8 @@
 	mod_timer(&topology_timer, topology_timer.expires);
 }
 
+#ifdef CONFIG_SMP
+
 static void stage_topology_update(int core_id)
 {
 	cpumask_or(&cpu_associativity_changes_mask,
@@ -1562,6 +1564,8 @@
 	.notifier_call = dt_update_callback,
 };
 
+#endif
+
 /*
  * Start polling for associativity changes.
  */
@@ -1573,7 +1577,9 @@
 		if (!prrn_enabled) {
 			prrn_enabled = 1;
 			vphn_enabled = 0;
+#ifdef CONFIG_SMP
 			rc = of_reconfig_notifier_register(&dt_update_nb);
+#endif
 		}
 	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
 		   get_lppaca()->shared_proc) {
@@ -1598,7 +1604,9 @@
 
 	if (prrn_enabled) {
 		prrn_enabled = 0;
+#ifdef CONFIG_SMP
 		rc = of_reconfig_notifier_unregister(&dt_update_nb);
+#endif
 	} else if (vphn_enabled) {
 		vphn_enabled = 0;
 		rc = del_timer_sync(&topology_timer);
