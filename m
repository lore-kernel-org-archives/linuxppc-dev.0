Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1980B67B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 15:45:48 +1000 (EST)
Subject: [PATCH] powerpc: make MAL use the new DCR methods
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 15:45:39 +1000
Message-Id: <1160545539.6177.56.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a test patch to validate the new DCR method code for the
"native" case. It will ultimately be the first of a pile porting the
EMAC driver to ARCH=powerpc and non-native DCRs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_mal.h	2006-10-11 13:01:59.000000000 +1000
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h	2006-10-11 14:35:28.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 
 #include <asm/io.h>
+#include <asm/dcr.h>
 
 /*
  * These MAL "versions" probably aren't the real versions IBM uses for these 
@@ -191,6 +192,7 @@ struct mal_commac {
 
 struct ibm_ocp_mal {
 	int			dcrbase;
+	dcr_host_t		dcrhost;
 
 	struct list_head	poll_list;
 	struct net_device	poll_dev;
@@ -207,12 +209,12 @@ struct ibm_ocp_mal {
 
 static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
 {
-	return mfdcr(mal->dcrbase + reg);
+	return dcr_read(mal->dcrhost, mal->dcrbase + reg);
 }
 
 static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
 {
-	mtdcr(mal->dcrbase + reg, val);
+	dcr_write(mal->dcrhost, mal->dcrbase + reg, val);
 }
 
 /* Register MAL devices */
