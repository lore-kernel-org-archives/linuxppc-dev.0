Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03D74DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 05:30:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7MJUodw029406
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 15:30:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7MJUnHi213178
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:30:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7MJUn6n010956
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:30:49 -0600
Date: Wed, 22 Aug 2007 14:30:47 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Message-ID: <20070822143047.6c8a0d4e@weaponx.rchland.ibm.com>
In-Reply-To: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Aug 2007 10:19:21 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> Guys,
> 
> I was wondering if I could get your help with looking at the  
> following lists and determining if we have an issue or not related  
> the following files:
> 
> Getting some classification on these would be good.  Possibly  
> classifications, doesn't build in ARCH=powerpc, remove include, real  
> issue, etc.

Sure.

> ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ocp.h>
> ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ibm4xx.h>

These one depends on IBM_OCP in Kconfig.  We don't select/enable that on
any existing arch/powerpc 4xx stuff so it won't be built anyway.

> ./drivers/mtd/maps/ebony.c:#include <asm/ibm44x.h>

This one depends on !PPC_MERGE in Kconfig.  It can be ignored.

> ./drivers/net/ibm_emac/ibm_emac_core.c:#include <asm/ocp.h>
> ./drivers/net/ibm_emac/ibm_emac_core.h:#include <asm/ocp.h>
> ./drivers/net/ibm_emac/ibm_emac_tah.h:#include <asm/ocp.h>
> ./drivers/net/ibm_emac/ibm_emac_phy.c:#include <asm/ocp.h>
> ./drivers/net/ibm_emac/ibm_emac_mal.c:#include <asm/ocp.h>
> ./drivers/net/ibm_emac/ibm_emac_zmii.h:#include <asm/ocp.h>

These are guarded by !PPC_MERGE in Kconfig, so they won't be built in
arch/powerpc.  And we all know we're waiting for the ibm_newemac driver
to show up for arch/powerpc... ;)

> ./drivers/mtd/maps/walnut.c:#include <asm/ibm4xx.h>
> ./drivers/mtd/maps/ocotea.c:#include <asm/ibm44x.h>
> ./drivers/mtd/nand/ndfc.c:#include <asm/ibm44x.h>

ndfc.c doesn't even need asm/ibm44x.h in arch/ppc.  It could be removed
safely.  However, the build will fail on arch/powerpc because of the
call to ioremap64.  So we should guard it for now, until I get the
flash stuff working on Bamboo and come up with something better.

The patch below fixes these, similar to how drivers/mtd/maps/ebony.c is
guarded.

josh

[POWERPC] Don't build arch/ppc dependent drivers in arch/powerpc

These drivers are specific to 4xx support in arch/ppc at the moment.  Make
sure they don't get built on arch/powerpc.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/mtd/maps/Kconfig |    4 ++--
 drivers/mtd/nand/Kconfig |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.orig/drivers/mtd/maps/Kconfig
+++ linux-2.6/drivers/mtd/maps/Kconfig
@@ -354,7 +354,7 @@ config MTD_CFI_FLAGADM
 
 config MTD_WALNUT
 	tristate "Flash device mapped on IBM 405GP Walnut"
-	depends on MTD_JEDECPROBE && WALNUT
+	depends on MTD_JEDECPROBE && WALNUT && !PPC_MERGE
 	help
 	  This enables access routines for the flash chips on the IBM 405GP
 	  Walnut board. If you have one of these boards and would like to
@@ -370,7 +370,7 @@ config MTD_EBONY
 
 config MTD_OCOTEA
 	tristate "Flash devices mapped on IBM 440GX Ocotea"
-	depends on MTD_CFI && OCOTEA
+	depends on MTD_CFI && OCOTEA && !PPC_MERGE
 	help
 	  This enables access routines for the flash chips on the IBM 440GX
 	  Ocotea board. If you have one of these boards and would like to
--- linux-2.6.orig/drivers/mtd/nand/Kconfig
+++ linux-2.6/drivers/mtd/nand/Kconfig
@@ -134,7 +134,7 @@ config MTD_NAND_S3C2410_HWECC
 
 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
-	depends on 44x
+	depends on 44x && !PPC_MERGE
 	select MTD_NAND_ECC_SMC
 	help
 	 NDFC Nand Flash Controllers are integrated in EP44x SoCs
