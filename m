Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AE7EBDDF33
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 11:06:43 +1100 (EST)
Date: Mon, 23 Feb 2009 16:06:41 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Subject: Re: soc vs localbus for flash in device tree
Message-ID: <20090224000641.GB578@ovro.caltech.edu>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2009 at 10:31:37AM +1100, Dushara Jayasinghe wrote:
> Hi,
> 
> I'm working on the kernel version Linux-2.6.29-rc5 with U-Boot 1.2.0-g88e21e7b-dirty.
> 
> Does the flash node HAVE to be within a localbus node or can it reside within the soc node? I've been basing my work on mpc834x_mds.dts
> And hence haven't defined a localbus node.
> 

I'm also working on a custom board based on MPC8349EMDS, and have based
my dts off of mpc834x_mds.dts. I've added the localbus node with my
chipselects and flash. It works, but there are no guarantees of
correctness.

I've appended the important portion below, just in case it helps.
Ira

	localbus@e0005000 {
		#address-cells = <2>;
		#size-cells = <1>;
		compatible = "fsl,mpc8349-elbc", "fsl,elbc", "simple-bus";
		reg = <0xe0005000 0x1000>;
		interrupts = <77 0x8>;
		interrupt-parent = <&ipic>;

		// CS0 and CS1 -- probably wrong...
		ranges = <0x0 0x0 0xfc000000 0x04000000
			  0x1 0x0 0xf0000000 0x00004000>;

		flash@0,0 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "cfi-flash";
			reg = <0x0 0x0 0x04000000>;
			bank-width = <2>;
			device-width = <1>;

			u-boot@0 {
				reg = <0x0 0x40000>;
			};

			u-boot-env@60000 {
				reg = <0x60000 0x20000>;
			};

			sys-fpga@3de0000 {
				reg = <0x3de0000 0x220000>;
			};
		};
	};
