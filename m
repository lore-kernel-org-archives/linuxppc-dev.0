Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
Date: Sun, 8 Jun 2008 15:08:33 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linuxppc-dev list" <Linuxppc-dev@ozlabs.org>,
	"Sascha Hauer" <s.hauer@pengutronix.de>,
	"Grant Likely" <grant.likely@secretlab.ca>
Subject: Comments on device tree for pcm030
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why not a compatible field in the top of the tree? Then you wouldn't
need to list the boards in mpc5200_simple.c.
	compatible = "phytec,pcm030","simple-mpc5200";

Device tree has an entry for AC97 on PSC1. I don't think the Phytec
module or carrier board has AC97 hardware.

The RTC chip says pcf8563, phytec doc says it is a pcf8564.

There should be an i2c entry for the eeprom but I don't know the part
number for it.

What about the flash on the local bus?  Could we use something like
this, or the same without the partition data?

	lpb@ff000000 {
		compatible = "fsl,lpb";
		ranges = <0 ff000000 01000000>;
		
		flash@00000000 {
			compatible = "cfi-flash";
			reg = <00000000 01000000>;
			bank-width = <2>;
			#size-cells = <1>;
			#address-cells = <1>;
			partition@0 {
				label = "ubootl";
				reg = <00000000 00040000>;
			};
			partition@40000 {
				label = "kernel";
				reg = <00040000 001c0000>;
			};
			partition@200000 {
				label = "jffs2";
				reg = <00200000 00D00000>;
			};
			partition@f00000 {
				label = "uboot";
				reg = <00f00000 00040000>;
			};
			partition@f40000 {
				label = "oftree";
				reg = <00f40000 00040000>;
			};
			partition@f80000 {
				label = "space";
				reg = <00f80000 00080000>;
			};
		};
	};

-- 
Jon Smirl
jonsmirl@gmail.com
