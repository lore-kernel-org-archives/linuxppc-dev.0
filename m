Return-Path: <sha@pengutronix.de>
Date: Mon, 9 Jun 2008 11:13:35 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Comments on device tree for pcm030
Message-ID: <20080609091335.GC13036@pengutronix.de>
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sun, Jun 08, 2008 at 03:08:33PM -0400, Jon Smirl wrote:
> Why not a compatible field in the top of the tree? Then you wouldn't
> need to list the boards in mpc5200_simple.c.
> 	compatible = "phytec,pcm030","simple-mpc5200";
> 
> Device tree has an entry for AC97 on PSC1. I don't think the Phytec
> module or carrier board has AC97 hardware.
> 
> The RTC chip says pcf8563, phytec doc says it is a pcf8564.
> 
> There should be an i2c entry for the eeprom but I don't know the part
> number for it.
> 
> What about the flash on the local bus?  Could we use something like
> this, or the same without the partition data?
> 
> 	lpb@ff000000 {
> 		compatible = "fsl,lpb";
> 		ranges = <0 ff000000 01000000>;
> 		
> 		flash@00000000 {
> 			compatible = "cfi-flash";
> 			reg = <00000000 01000000>;
> 			bank-width = <2>;

The board comes with different flash sizes with different bank widths.
That's why I decided to no put the flash entries into the tree.
We used to detect the flash size/bankwidth using the bootcs config
register (which was previously set by U-Boot). We could change U-Boot to
adjust the device tree accordingly, but we haven't done this so far,
sorry.

> 			#size-cells = <1>;
> 			#address-cells = <1>;
> 			partition@0 {
> 				label = "ubootl";
> 				reg = <00000000 00040000>;
> 			};
> 			partition@40000 {
> 				label = "kernel";
> 				reg = <00040000 001c0000>;
> 			};
> 			partition@200000 {
> 				label = "jffs2";
> 				reg = <00200000 00D00000>;
> 			};
> 			partition@f00000 {
> 				label = "uboot";
> 				reg = <00f00000 00040000>;
> 			};
> 			partition@f40000 {
> 				label = "oftree";
> 				reg = <00f40000 00040000>;
> 			};
> 			partition@f80000 {
> 				label = "space";
> 				reg = <00f80000 00080000>;
> 			};

I think partitions shouldn't go into the default device tree, as people
may have different partitioning.

Sascha

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
