Return-Path: <byron.bbradley@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 122B5B70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 04:44:41 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id C29DCDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 04:44:39 +1000 (EST)
Received: by fxm22 with SMTP id 22so1701031fxm.9
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Jun 2009 11:44:37 -0700 (PDT)
Date: Fri, 5 Jun 2009 19:44:31 +0100 (BST)
From: Byron Bradley <byron.bbradley@gmail.com>
To: Byron Bradley <byron.bbradley@gmail.com>, linuxppc-dev@ozlabs.org,
	galak@kernel.crashing.org, tim.ellis@mac.com,
	Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] [POWERPC] 83xx: Add support for the Thecus N1200 NAS
	device
In-Reply-To: <20090605030850.GF2054@yookeroo.seuss>
Message-ID: <alpine.DEB.2.00.0906051851120.22609@gamma>
References: <alpine.DEB.2.00.0906042152330.7053@gamma>
	<20090605030850.GF2054@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Jun 2009, David Gibson wrote:

> On Thu, Jun 04, 2009 at 09:59:04PM +0100, Byron Bradley wrote:
> > The Thecus N1200 is a NAS device with a single internal SATA disk and
> > an eSATA port based on an MPC8347 SoC.
> 
> Comments on a number of fairly minor device tree nits below:

Hi David, Peter. Thanks for the comments, replies inline below.

> 
> [snip]
> > +	soc8349@e0000000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		device_type = "soc";
> > +		compatible = "simple-bus";
> 
> The compatible value should have something more specific
> (e.g. "fsl,mpc8340-soc") before listing "simple-bus".

Added "fsl,mpc8347-soc" and changed soc8349 to soc8347.

> 
> > +		ranges = <0x0 0xe0000000 0x00100000
> > +			  0xfe000000 0xfe000000 0x0800000>;
> > +		reg = <0xe0000000 0x00000200>;
> > +		bus-frequency = <0>;			// from bootloader
> > +
> > +		physmap-flash@fe000000 {
> 
> Calling this just "flash" would be more normal.

Done.

> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "cfi-flash";
> 
> Ideally this should list the actual model of flash chip, before the
> generic "cfi-flash".

Added "numonyx,28f640j3d"

> > +			reg = <0xfe000000 0x0800000>;
> > +			bank-width = <2>;
> > +			device-width = <1>;
> > +
> > +			u-boot@0 {
> > +				reg = <0x0 0x040000>;
> > +				read-only;
> > +			};
> > +
> > +			u-boot-config@40000 {
> > +				reg = <0x040000 0x040000>;
> > +				label = "u-boot config";
> > +			};
> > +
> > +			user@080000 {
> > +				reg = <0x080000 0x100000>;
> > +			};
> > +
> > +			kernel@180000 {
> > +				reg = <0x180000 0x1a0000>;
> > +			};
> > +
> > +			ramdisk@320000 {
> > +				reg = <0x320000 0x4e0000>;
> > +			};
> > +		};
> > +
> > +		wdt@200 {
> > +			device_type = "watchdog";
> 
> No device_type here.

Removed all device_type entries that you said shouldn't be there.

> > +			fanctrl@32 {
> 
> A less abbreviated name, like "fan-control" would be more usual here.
> 
> > +				compatible = "fintek,f75375";
> > +				reg = <0x2e>;
> > +			};
> > +
> > +			rtc@32 {
> > +				device_type = "rtc";
> > +				compatible = "ricoh,rs5c372a";
> > +				reg = <0x32>;
> > +			};
> > +
> > +			boardctrl@32 {
> 
> Again "board-control" would be preferable.

Both changed.

> > +		ipic: pic@700 {
> > +			interrupt-controller;
> > +			#address-cells = <0>;
> > +			#interrupt-cells = <2>;
> > +			reg = <0x700 0x100>;
> > +			device_type = "ipic";
> 
> This should have a compatible property.  It shouldn't really have
> device_type, but I suspect that's a bug in the ipic binding, rather
> than your tree per-se.

The binding for this seems to be done in the setup file, 
arch/powerpc/platforms/83xx/thecus_n1200.c in my case. At the moment it 
does:
	np = of_find_node_by_type(NULL, "ipic");
	...
	ipic_init(np, 0);
so making it look for something like "fsl,mpc8347-ipic" should be no 
problem if that's how it should be done.

> > +		};
> > +
> > +		gpio1: gpio-controller@c00 {
> > +			#gpio-cells = <2>;
> > +			compatible = "fsl,mpc8347-gpio", "fsl,mpc8349-gpio";
> 
> This actually is an 8349 board, yes?  Generally compatible should be
> listed from most specific to least specific, so the 8349 entry should
> go first.

No, as Peter pointed out this is an 8347. The soc8349 at the top was 
probably a combination of basing this dts on an 8349 one and the fact that 
most of the freescale docs for 8347 just point to 8349 ones. I've made 
sure the only place 8349 is referenced is in compatible fields and it's 
always after the 8347 version.

Cheers,

-- 
Byron Bradley
