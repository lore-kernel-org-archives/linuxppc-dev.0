Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 8E82267CBE
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 19:42:42 +1100 (EST)
Date: Fri, 3 Nov 2006 09:42:38 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 01/16] remove inclusion of asm/processor.h for powerpc
Message-ID: <20061103084237.GA22478@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125624.134898000@localhost.localdomain>
	<1162506020.10630.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162506020.10630.31.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 03, 2006 at 09:20:20AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2006-11-02 at 13:55 +0100, s.hauer@pengutronix.de wrote:
> > plain text document attachment
> > (drivers-ide-pci-via82xxx-remove-ppc-ifdef.diff)
> > Remove inclusion of asm/processor.h for powerpc. It was used for
> > some ppc specific hook in this file, but the hook is gone
> 
> It's not:
> 
> init_hwif_via82cxxx() contains:
> 
> #if defined(CONFIG_PPC_CHRP) && defined(CONFIG_PPC32)
>         if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
>                 hwif->irq = hwif->channel ? 15 : 14;
>         }
> #endif
> 
> Now you can replace CONFIG_PPC_MULTIPLATFORM with CONFIG_PPC_CHRP
> 

Oops, missed that one. Here is an updated version:

Remove inclusion of asm/processor.h for powerpc. It was used for
some ppc specific hook in this file, but the hook is gone

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: drivers/ide/pci/via82cxxx.c
===================================================================
--- drivers/ide/pci/via82cxxx.c.orig
+++ drivers/ide/pci/via82cxxx.c
@@ -35,7 +35,7 @@
 #include <linux/ide.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#ifdef CONFIG_PPC_CHRP
 #include <asm/processor.h>
 #endif
 
@@ -442,7 +442,7 @@ static void __devinit init_hwif_via82cxx
 	hwif->speedproc = &via_set_drive;
 
 
-#if defined(CONFIG_PPC_CHRP) && defined(CONFIG_PPC32)
+#ifdef CONFIG_PPC_CHRP
 	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
 		hwif->irq = hwif->channel ? 15 : 14;
 	}

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
