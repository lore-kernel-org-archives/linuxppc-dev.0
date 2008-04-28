Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with ESMTP id 03E54DE3C4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 05:25:29 +1000 (EST)
Date: Mon, 28 Apr 2008 12:25:14 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080428192514.GA15491@farnsworth.org>
References: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
	<20080428180947.GA2691@farnsworth.org>
	<1209410557.14407.14.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1209410557.14407.14.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH] sysdev,mv64x60: MV64x60 device bus
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 12:22:36PM -0700, Remi Machet wrote:
> On Mon, 2008-04-28 at 11:09 -0700, Dale Farnsworth wrote:
> > On Mon, Apr 28, 2008 at 10:12:09AM -0700, Remi Machet wrote:
> > > Follow up of my email of 4/16/2008 titled "MV64x60 device bus".
> > > For each mv64360 entry in the OpenFirmware database, add the 
> > > registration of an of_bus to take care of devices connected to
> > > the MV64x60 asynchronous devices controller.
> > 
> > I'd like to see your dts file to see exactly how you're using it.
> Here it is, I removed everything that is not related to the subject:
> 
> /dts-v1/;
> 
> / {
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	model = "C2K";
> 	compatible = "GEFanuc,C2K";
> 	coherency-off;
> 
> 	<...>
> 
> 	system-controller@d8000000 { /* Marvell Discovery */
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		model = "mv64460";
> 		compatible = "marvell,mv64360";
> 
> 		<...>
> 
> 		/* Devices attached to the device controller */
> 		devicebus {
> 			device_type = "devicectrl";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			nor_flash {
> 				compatible = "cfi-flash";
> 				reg = <0xf8000000 0x8000000>; /* 128MB */
> 				bank-width = <4>;
> 				device-width = <1>;
> 				#address-cells = <1>;
> 				#size-cells = <1>;
> 				partition@0 {
> 					label = "boot";
> 					reg = <0x00000000 0x00080000>;
> 				};
> 				partition@40000 {
> 					label = "kernel";
> 					reg = <0x00080000 0x00400000>;
> 				};
> 				partition@440000 {
> 					label = "initrd";
> 					reg = <0x00480000 0x00B80000>;
> 				};
> 				partition@1000000 {
> 					label = "rootfs";
> 					reg = <0x01000000 0x06800000>;
> 				};
> 				partition@7800000 {
> 					label = "recovery";
> 					reg = <0x07800000 0x00800000>;
> 					read-only;
> 				};
> 			};
> 		};
> 	};
> 	<...>
> };

Thanks.

> > The only problem I see now is that you have introduced a new device
> > type, "devicectrl".  New device types are frowned upon.  It's better
> > to match based on the compatible field.  Maybe use
> > "marvell,mv64306-devctrl" or similar.
> > 
> Do you mean having the DTS file look like this:

Yes, exactly.

-Dale

> 		<...>
> 		devicebus {
> 			compatible = "marvell,mv64306-devctrl";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			nor_flash {
> 				compatible = "cfi-flash";
> 				reg = <0xf8000000 0x8000000>; 
> 				<...>
> 			};
> 		};
> 
> Remi
