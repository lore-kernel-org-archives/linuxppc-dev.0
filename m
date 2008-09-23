Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id C4692DDF91
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:39:02 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2371476wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 07:39:01 -0700 (PDT)
Date: Tue, 23 Sep 2008 08:38:59 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: gianfranco.casanova@alice.it
Subject: Re: PSC-SPI and MMC-SPI driver on lite5200b EVB. Device
	registration problems.
Message-ID: <20080923143859.GA13593@secretlab.ca>
References: <47602D18F269934AB73B7E550804A1E002137944@FBCMST09V03.fbc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47602D18F269934AB73B7E550804A1E002137944@FBCMST09V03.fbc.local>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 02:43:18PM +0200, gianfranco.casanova@alice.it wrote:
> Hi guys
> 
> I'm using a lite5200b EVB (u-boot 1.2, kernel 2.6.26.3), using the psc-spi driver and the mmc-spi driver.
> 
> I've modified the lite5200b.dts file, I'd have SPI on PSC6 and mmc_spi connected to SPI on PSC6
> 
> and then uncommented
> 
> 		// PSC6 in spi mode example
> 		spi@2c00 {		// PSC6
> 			compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
> 			cell-index = <5>;
> 			reg = <0x2c00 0x100>;
> 			interrupts = <2 4 0>;
> 			interrupt-parent = <&mpc5200_pic>;
> 			mmc_spi@0 {
> 				linux,modalias = "mmc_spi";
> 			};
> 		};
> 
> I've also added a node to spi@2c00 (I'm not sure about last change).
> 
> My question are:
> a) Is this the right way to insert a node in device tree (in this example for mmc-spi) or there are an other way to pass the information to mmc-spi that SPI is on PSC6?

Yes, this is mostly right.  However, you need to add 2 properties to
your PSC6 spi@2c00 node; '#address-cells = <1>;' and '#size-cells = <0>;'
These are needed so that the device tree code knows how to interpret the
address of the child node.

For the mmc_spi@0 node, you need to remove the linux,modalias property.
That method of describing the device is strongly discouraged.  Instead,
add a property 'compatible = "mmc-spi";' and 'reg = <0>;'.  Compatible
is the property used to bind to the device and reg gives the device
address (which is 0 since you only have one device wired to the SPI
bus).

Unfortunately, you'll need to hack around a bit with binding code.
Support for MMC devices described in the device tree has not yet been
merged, so some of this stuff is up in the air.  However, as long as you
get the device tree description correct now you should be insulated from
changes in this area.

Take a look at this thread for more details:
http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg18836.html

> 
> b) Why in /proc/devices I do not see any spi device (mpc5200b-psc-spi) or something like that?
> Adding some printk I have:
> Fun = mpc52xx_psc_spi_init Ret = 0
> Is my of_register_platform_driver was ok.

Poke around in /sys/bus/of_platform/devices/.  See if anything shows up
there.

> 
> c) BTW a Block device mmc in /proc/devices is added (not mmc-spi as I'm waiting), if I try to create a node and then write on device nothing happens.
> 
> Any suggestion?
> 
> Thanks J

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
