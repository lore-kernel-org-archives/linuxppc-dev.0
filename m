Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EB92B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 23:25:22 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: afleming@freescale.com, benh@kernel.crashing.org
Subject: [PATCH] mpc836x: fix failed phy detection for ucc ethernet on MDS
Date: Mon, 27 Feb 2012 07:25:01 -0500
Message-Id: <1330345501-24949-1-git-send-email-paul.gortmaker@windriver.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc836x_mds platform has been broken since the commit
6fe3264945ee63292cdfb27b6e95bc52c603bb09

  "netdev/phy: Use mdiobus_read() so that proper locks are taken"

which caused the fsl_pq_mdio TBI autoprobe to oops.  The oops
was "fixed" in commit 28d8ea2d568534026ccda3e8936f5ea1e04a86a1

  "fsl_pq_mdio: Clean up tbi address configuration"

by simply removing the the autoscan code, and making tbi nodes
mandatory.  Some of the newer reference platforms were updated
to have tbi nodes in 220669495bf8b68130a8218607147c7b74c28d2b

  "powerpc: Add TBI PHY node to first MDIO bus"

but the older mpc836x didn't get one and hence was just failing
with -EBUSY as follows:

 fsl-pq_mdio: probe of e0102120.mdio failed with error -16
   ...
 net eth0: Could not attach to PHY
 eth0: Cannot initialize PHY, aborting.

Add a TBI node and use the 1st free address for it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Andy: There may be other boards that could be having this problem
  git grep -l enet.*ucc arch/powerpc/boot/dts/|xargs grep -L tbi
 shows four possible candidates -- but I've only got the 8360MDS. ]
  

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 45cfa1c5..1de33ce 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -405,6 +405,10 @@
 				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
+			tbi-phy@2 {
+				device_type = "tbi-phy";
+				reg = <0x2>;
+			};
 		};
 
 		qeic: interrupt-controller@80 {
-- 
1.7.9.1
