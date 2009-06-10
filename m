Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 76817B7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 03:43:36 +1000 (EST)
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>
Date: Wed, 10 Jun 2009 23:13:23 +0530
Message-Id: <20090610174323.28045.70169.sendpatchset@subratamodak.linux.ibm.com>
Subject: [PATCH] Re:[BUILD FAILURE 04/04] Next June 04:PPC64 randconfig
	[drivers/net/ucc_geth.o]
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ling,

>On Thu, 2009-06-04 at 19:02 +0530, Subrata Modak wrote:
>CC [M]  drivers/net/ucc_geth.o
> drivers/net/ucc_geth.c: In function bucc_geth_probeb:
> drivers/net/ucc_geth.c:3822: error: 'ph' undeclared (first use in this function)
> drivers/net/ucc_geth.c:3822: error: (Each undeclared identifier is reported only once
> drivers/net/ucc_geth.c:3822: error: for each function it appears in.)
> drivers/net/ucc_geth.c:3832: error: 'mdio' undeclared (first use in this function)
> make[2]: *** [drivers/net/ucc_geth.o] Error 1

With the above build error reported on 4th June linux next tree, i am proposing
the following patch. Can you please let me know if you would like to merge it.

Reference: http://lkml.org/lkml/2009/6/4/241,
Fix the following build error:

drivers/net/ucc_geth.c: In function bucc_geth_probeb:
drivers/net/ucc_geth.c:3822: error: 'ph' undeclared (first use in this function)
drivers/net/ucc_geth.c:3822: error: (Each undeclared identifier is reported only once
drivers/net/ucc_geth.c:3822: error: for each function it appears in.)
drivers/net/ucc_geth.c:3832: error: 'mdio' undeclared (first use in this function)
make[2]: *** [drivers/net/ucc_geth.o] Error 1

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- linux-2.6.30-rc8/drivers/net/ucc_geth.c.orig	2009-06-10 11:58:39.000000000 -0500
+++ linux-2.6.30-rc8/drivers/net/ucc_geth.c	2009-06-10 12:37:15.000000000 -0500
@@ -3595,6 +3595,8 @@ static const struct net_device_ops ucc_g
 
 static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *match)
 {
+	struct device_node *mdio;
+	phandle *ph;
 	struct device *device = &ofdev->dev;
 	struct device_node *np = ofdev->node;
 	struct net_device *dev = NULL;
@@ -3819,7 +3821,7 @@ static int ucc_geth_probe(struct of_devi
 	ugeth->node = np;
 
 	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
-	ph = of_get_property(np, "tbi-handle", NULL);
+	ph = (phandle *)of_get_property(np, "tbi-handle", NULL);
 	if (ph) {
 		struct device_node *tbi = of_find_node_by_phandle(*ph);
 		struct of_device *ofdev;

---
Regards--
Subrata
