Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8970B67AB0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 20:38:52 +1100 (EST)
Date: Wed, 23 Feb 2005 01:38:50 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050223093849.GB6670@gate.ebshome.net>
References: <c3d0340b050222190712ee7dff@mail.gmail.com>
	<20050223042234.GA31255@gate.ebshome.net>
	<c3d0340b050223000217714e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050223000217714e92@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Ethernet doesn't work in linux for PPC440GP?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2005 at 12:02:04AM -0800, Shawn Jin wrote:
> > > zmii0: input 0 in SMII mode
> > > eth0: IBM emac, MAC 00:04:ac:e3:1b:bb
> > > eth0: Found Generic MII PHY (0x08)
> > > zmii0: input 1 in RMII mode
> > > eth1: IBM emac, MAC FF:FF:FF:FF:FF:FF
> > > eth1: Found Generic MII PHY (0x09)
> > 
> > I already told you that this is wrong, why are you asking again?
> > Please, if you asking questions, spend some time reading answers
> > given to you, before asking again.
> 
> Well, don't be mad at me first. The question may bring out another
> round of arguments whether it's a bug related to uboot or linux EMAC
> driver. Wolfgang makes it very clear that this is a bug in linux
> ethernet driver. And I agree with him. This argument happened before
> and I just forgot what specific ethernet driver was in the argument.

This is really irrelevant.

> 
> > Ebony uses RMII, so SMII is obviously wrong. Most probably your
> > firmware doesn't set correct mode and autodetection in the EMAC driver
> > fails.
> 
> So the EMAC driver does expect a boot loader (the firmware you
> mentioned here) to set something for it. Then I think I need to fix it
> in this driver instead of in uboot.

Current EMAC driver uses autodetection logic if PHY mode wasn't 
specified by the board support code. It works for Ebony + OpenBIOS. 
You can try the following patch (untested) to set PHY mode explicitly:

===== arch/ppc/platforms/4xx/ebony.c 1.10 vs edited =====
--- 1.10/arch/ppc/platforms/4xx/ebony.c	2005-02-03 06:42:41 -08:00
+++ edited/arch/ppc/platforms/4xx/ebony.c	2005-02-23 01:28:04 -08:00
@@ -52,6 +52,13 @@
 
 #include <syslib/gen550.h>
 
+/*
+ * This is a horrible kludge, we eventually need to abstract this
+ * generic PHY stuff, so the  standard phy mode defines can be
+ * easily used from arch code.
+ */
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
 static struct ibm44x_clocks clocks __initdata;
 
 /*
@@ -267,9 +274,11 @@
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
 	emacdata = def->additions;
 	memcpy(emacdata->mac_addr, EBONY_NA0_ADDR(vpd_base), 6);
+	emacdata->phy_mode = PHY_MODE_RMII;
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
 	emacdata = def->additions;
 	memcpy(emacdata->mac_addr, EBONY_NA1_ADDR(vpd_base), 6);
+	emacdata->phy_mode = PHY_MODE_RMII;
 	iounmap(vpd_base);
 
 	/*


--
Eugene
