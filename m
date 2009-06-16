Return-Path: <Kari.Davidsson@marel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D848BB7138
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 20:41:06 +1000 (EST)
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 18C3DDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 20:41:05 +1000 (EST)
Message-ID: <4A3776BE.6010601@marel.com>
Date: Tue, 16 Jun 2009 10:41:02 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
References: <fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
	<4A3678A3.1050802@marel.com>
	<fa686aa40906151031p74636557oc1ab173236d0a81b@mail.gmail.com>
In-Reply-To: <fa686aa40906151031p74636557oc1ab173236d0a81b@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------000503080209020903030901"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------000503080209020903030901
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit

Now my driver gets probed.

This "modalias" error was due to wrong "compatible" attribute of
my of node.

But I still need to have the call to of_register_spi_devices().

The attached patch shows what I mean.

rg
kd

Grant Likely wrote:
> On Mon, Jun 15, 2009 at 10:36 AM, Kári
> Davíðsson<kari.davidsson@marel.com> wrote:
>> Is this true?
>>
>> Grant Likely wrote:
>>> Yes, this is right.  The psc_spi driver automatically registers all
>>> spi children that it finds in the device tree onto the SPI bus.
>>> Therefore registering an spi_driver() is the right thing to do.
>> I am writing an SPI protocol driver and I find that my driver
>> is never probed.
>>
>> I tried to add and call to of_register_spi_devices() in the
>> drivers/spi/mpc52xx_psc_spi.c::mpc52xx_psc_spi_of_probe() function,
>> without much effect besided that the DTS node is parsed but the driver probe
>> is not called, actually it complains about a modalias for my node is
>> missing.
> 
> What do you see when you look in /sys/bus/spi/devices?  You should see
> a directory for your device.  What do you see in /sys/bus/spi/drivers?
>  In here you should see your driver.  If they are both there, then you
> just have a problem matching your driver name to the device name.
> 
> g.
> 

--------------000503080209020903030901
Content-Type: text/plain; name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch"

Index: drivers/spi/mpc52xx_psc_spi.c
===================================================================
--- drivers/spi/mpc52xx_psc_spi.c	(revision 548)
+++ drivers/spi/mpc52xx_psc_spi.c	(working copy)
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_spi.h>
 
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
@@ -371,7 +372,7 @@
 
 /* bus_num is used only for the case dev->platform_data == NULL */
 static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
-				u32 size, unsigned int irq, s16 bus_num)
+				u32 size, unsigned int irq, s16 bus_num, struct spi_master ** pmaster)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
 	struct mpc52xx_psc_spi *mps;
@@ -439,6 +440,10 @@
 	if (ret < 0)
 		goto unreg_master;
 
+    dev_info(dev, "Activated\n");
+
+    *pmaster = master;
+
 	return ret;
 
 unreg_master:
@@ -474,6 +479,8 @@
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
 	s16 id = -1;
+    int res;
+    struct spi_master * master = NULL;;
 
 	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
 	if (!regaddr_p) {
@@ -495,8 +502,16 @@
 		id = *psc_nump + 1;
 	}
 
-	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
-					irq_of_parse_and_map(op->node, 0), id);
+	res = mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
+					irq_of_parse_and_map(op->node, 0), id, &master);
+
+    if( master != NULL )
+    {
+        /* Add any subnodes on the SPI bus */
+        of_register_spi_devices( master, op->node);
+    }
+
+    return res;
 }
 
 static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)

--------------000503080209020903030901--
