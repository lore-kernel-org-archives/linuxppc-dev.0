Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA30C67BDC
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:56:37 +1000 (EST)
Subject: Re: IDE not found on Performa due to interrupt breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060921115030.GA16732@aepfle.de>
References: <20060921115030.GA16732@aepfle.de>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 21:56:21 +1000
Message-Id: <1158839781.26347.106.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-21 at 13:50 +0200, Olaf Hering wrote:
> The IDE controller is not usable on a Performa 6400 with 2.6.18:
> 
> <6>hda: Enabling MultiWord DMA 2
> <4>ide0: Disabled unable to get IRQ 13.
> <6>ide0: failed to initialize IDE interface

 .../...

Looks like a workaround for bogus OF bitrotted... What about this patch:

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2006-07-01 13:51:19.000000000 +1000
+++ linux-work/drivers/ide/ppc/pmac.c	2006-09-21 21:55:31.000000000 +1000
@@ -1326,7 +1326,7 @@
 	if (macio_irq_count(mdev) == 0) {
 		printk(KERN_WARNING "ide%d: no intrs for device %s, using 13\n",
 			i, mdev->ofdev.node->full_name);
-		irq = 13;
+		irq = irq_create_mapping(NULL, 13);
 	} else
 		irq = macio_irq(mdev, 0);
 
