Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Mar 2008 15:52:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080305045208.GI8399@localhost.localdomain>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304091059.GD18829@netgate.macqel>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 10:10:59AM +0100, Philippe De Muyter wrote:
> Hi Ben,
> 
> On Tue, Mar 04, 2008 at 07:22:19PM +1100, Benjamin Herrenschmidt wrote:

These comments aren't relevant to the problems you're seeing, but
they're a good idea for writing device trees in general.

First, you may want to consider moving to the version 1 dts format
which uses C-style integer values throughout, instead of hex by
default.

[snip]
> 		i2c@3000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			device_type = "i2c";

device_type shouldn't be included here.

> 			compatible = "fsl-i2c";
> 			reg = <3000 100>;
> 			interrupts = <2b 2>;
> 			interrupt-parent = <&mpic>;
> 			dfsrr;
> 
> 			rtc@68 {
> 				compatible = "stm,m41t81";
> 				reg = <68>;
> 			};
> 		};
> 
> 		mdio@24520 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			device_type = "mdio";
> 			compatible = "gianfar";
[snip]
> 		ethernet@24000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			device_type = "network";
> 			model = "TSEC";
> 			compatible = "gianfar";

The binding for gianfar mdio and ethernet devices has been updated to
better fit conventions for use of device_type and compatible
properties.  Check booting-without-of.txt for the details.

Can someone from freescale please go though and update the existing
device trees, so that people stop copying the old crap.

[snip]
> 		ethernet@24000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			device_type = "network";
> 			model = "TSEC";
> 			compatible = "gianfar";
> 			reg = <24000 1000>;
> 			/*
> 			 * address is deprecated and will be removed
> 			 * in 2.6.25.  Only recent versions of
> 			 * U-Boot support local-mac-address, however.
> 			 */
> 			address = [ 00 00 00 00 00 00 ];

And since this is a new port, you ought to be able to use a recent
u-boot and drop this backwards compatibility property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
