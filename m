Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36AC2DDFC5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 05:22:23 +1000 (EST)
Subject: Re: [PATCH] sysdev,mv64x60: MV64x60 device bus
From: Remi Machet <rmachet@slac.stanford.edu>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080428180947.GA2691@farnsworth.org>
References: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
	<20080428180947.GA2691@farnsworth.org>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 12:22:36 -0700
Message-Id: <1209410557.14407.14.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-04-28 at 11:09 -0700, Dale Farnsworth wrote:
> On Mon, Apr 28, 2008 at 10:12:09AM -0700, Remi Machet wrote:
> > Follow up of my email of 4/16/2008 titled "MV64x60 device bus".
> > For each mv64360 entry in the OpenFirmware database, add the 
> > registration of an of_bus to take care of devices connected to
> > the MV64x60 asynchronous devices controller.
> 
> I'd like to see your dts file to see exactly how you're using it.
Here it is, I removed everything that is not related to the subject:

/dts-v1/;

/ {
	#address-cells = <1>;
	#size-cells = <1>;
	model = "C2K";
	compatible = "GEFanuc,C2K";
	coherency-off;

	<...>

	system-controller@d8000000 { /* Marvell Discovery */
		#address-cells = <1>;
		#size-cells = <1>;
		model = "mv64460";
		compatible = "marvell,mv64360";

		<...>

		/* Devices attached to the device controller */
		devicebus {
			device_type = "devicectrl";
			#address-cells = <1>;
			#size-cells = <1>;
			nor_flash {
				compatible = "cfi-flash";
				reg = <0xf8000000 0x8000000>; /* 128MB */
				bank-width = <4>;
				device-width = <1>;
				#address-cells = <1>;
				#size-cells = <1>;
				partition@0 {
					label = "boot";
					reg = <0x00000000 0x00080000>;
				};
				partition@40000 {
					label = "kernel";
					reg = <0x00080000 0x00400000>;
				};
				partition@440000 {
					label = "initrd";
					reg = <0x00480000 0x00B80000>;
				};
				partition@1000000 {
					label = "rootfs";
					reg = <0x01000000 0x06800000>;
				};
				partition@7800000 {
					label = "recovery";
					reg = <0x07800000 0x00800000>;
					read-only;
				};
			};
		};
	};
	<...>
};

> 
> The only problem I see now is that you have introduced a new device
> type, "devicectrl".  New device types are frowned upon.  It's better
> to match based on the compatible field.  Maybe use
> "marvell,mv64306-devctrl" or similar.
> 
Do you mean having the DTS file look like this:
		<...>
		devicebus {
			compatible = "marvell,mv64306-devctrl";
			#address-cells = <1>;
			#size-cells = <1>;
			nor_flash {
				compatible = "cfi-flash";
				reg = <0xf8000000 0x8000000>; 
				<...>
			};
		};

Remi
