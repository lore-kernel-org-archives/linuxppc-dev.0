Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2FF6DB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 02:02:47 +1000 (EST)
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 2A950DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 02:02:46 +1000 (EST)
Date: Thu, 10 Sep 2009 18:02:33 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each core in CAMPmode
	for P2020RDB
Message-ID: <20090910160233.GA24085@iram.es>
References: <1252573031-4157-1-git-send-email-poonam.aggrwal@freescale.com>
	<20090910093307.GA17117@iram.es>
	<1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 10, 2009 at 08:48:38PM +0530, Aggrwal Poonam-B10812 wrote:
>  
> 
> > -----Original Message-----
> > From: Gabriel Paubert [mailto:paubert@iram.es] 
> > Sent: Thursday, September 10, 2009 3:03 PM
> > To: Aggrwal Poonam-B10812
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each 
> > core in CAMPmode for P2020RDB
> > 
> > On Thu, Sep 10, 2009 at 02:27:11PM +0530, Poonam Aggrwal wrote:
> > > This patch creates the dts files for each core and splits 
> > the devices 
> > > between the two cores for P2020RDB.
> > > 
> > > core0 has memory, L2, i2c, spi, dma1, usb, eth0, eth1, crypto, 
> > > global-util, pci0
> > > core1 has L2, dma2, eth0, pci1, msi.
> > 
> > Surely you mean eth1 and eth2 for core0, no?
> Yes you are right , I'll fix this.
> > 
> > At least it's what I gather from the code.
> > 
> > Also both cores have a node called serial0, at different 
> > addresses but with the same interrupt!
> Yes both the UARTS use the same int line in shared mode. 
> > 
> > But in the mpic comment line there is "serial1", and 
> > interrupt 42 is the only number which appears in both lists 
> > of mpic protected interrupts.
> I am not sure how to handle the shared interrupts in AMP scenario,
> although this has been tested and both serials are working one on each
> core.

Ok, I wrongly understood protected interrupts as reserved 
for one core. However, I still dislike two devices having the same
name.

Otherwise it may work if every interrupt is delivered to both
cores although statistically only one core will actually have 
some work to do. Doesn't the kernel complain about unhandled irqs
however? 

	Regards,
	Gabriel

> > > +
> > > +		serial0: serial@4500 {
> > > +			cell-index = <0>;
> > > +			device_type = "serial";
> > > +			compatible = "ns16550";
> > > +			reg = <0x4500 0x100>;
> > > +			clock-frequency = <0>;
> > > +			interrupts = <42 2>;
> > > +			interrupt-parent = <&mpic>;
> > > +		};

> > > +
> > > +		mpic: pic@40000 {
> > > +			interrupt-controller;
> > > +			#address-cells = <0>;
> > > +			#interrupt-cells = <2>;
> > > +			reg = <0x40000 0x40000>;
> > > +			compatible = "chrp,open-pic";
> > > +			device_type = "open-pic";
> > > +			protected-sources = <
> > > +			42 76 77 78 79 /* serial1 , dma2 */
> > > +			29 30 34 26 /* enet0, pci1 */
> > > +			0xe0 0xe1 0xe2 0xe3 /* msi */
> > > +			0xe4 0xe5 0xe6 0xe7
> > > +			>;
> > > +		};
> > > +
> > > +

> > > +		serial0: serial@4600 {
> > > +			cell-index = <1>;
> > > +			device_type = "serial";
> > > +			compatible = "ns16550";
> > > +			reg = <0x4600 0x100>;
> > > +			clock-frequency = <0>;
> > > +			interrupts = <42 2>;
> > > +			interrupt-parent = <&mpic>;
> > > +		};
> > > +
> > > +

> > > +		mpic: pic@40000 {
> > > +			interrupt-controller;
> > > +			#address-cells = <0>;
> > > +			#interrupt-cells = <2>;
> > > +			reg = <0x40000 0x40000>;
> > > +			compatible = "chrp,open-pic";
> > > +			device_type = "open-pic";
> > > +			protected-sources = <
> > > +			17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
> > > +			16 20 21 22 23 28 	/* L2, dma1, USB */
> > > +			03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
> > > +			72 45 58 25 		/* sdhci, crypto , pci */
> > > +			>;
> > > +		};
> > > +
