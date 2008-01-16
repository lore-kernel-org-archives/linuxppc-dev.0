Return-Path: <SRS0=9ZSp=SG=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] [POWERPC] 4xx: Add AMCC Haleakala (405EXr) dts
Date: Wed, 16 Jan 2008 06:04:56 +0100
References: <1200380965-10245-1-git-send-email-sr@denx.de>
	<20080116004642.GD4283@localhost.localdomain>
In-Reply-To: <20080116004642.GD4283@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801160604.56766.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 January 2008, David Gibson wrote:
> On Tue, Jan 15, 2008 at 08:09:25AM +0100, Stefan Roese wrote:
> > The patch adds the Haleakala dts. The Haleakala is a stripped down
> > version of the Kilauea (405EX) with only one EMAC and only one PCIe
> > interface.
>
> [snip]
>
> > +			IIC0: i2c@ef600400 {
> > +				device_type = "i2c";
>
> No device_type here.

Ok.

> > +				compatible = "ibm,iic-405exr", "ibm,iic";
> > +				reg = <ef600400 14>;
> > +				interrupt-parent = <&UIC0>;
> > +				interrupts = <2 4>;
> > +			};
> > +
> > +			IIC1: i2c@ef600500 {
> > +				device_type = "i2c";
>
> Or here.

Ok.

> > +				compatible = "ibm,iic-405exr", "ibm,iic";
> > +				reg = <ef600500 14>;
> > +				interrupt-parent = <&UIC0>;
> > +				interrupts = <7 4>;
> > +			};
> > +
> > +
> > +			RGMII0: emac-rgmii@ef600b00 {
> > +				device_type = "rgmii-interface";
>
> And especially not here.

Ok.

Your comments are valid for some of the other 4xx dts files too. Should I 
create a patch that removes these device-types there too?

> > +				compatible = "ibm,rgmii-405exr", "ibm,rgmii";
> > +				reg = <ef600b00 104>;
> > +				has-mdio;
> > +			};
>
> [snip]
>
> > +		PCIE0: pciex@0a0000000 {
> > +			device_type = "pci";
> > +			#interrupt-cells = <1>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			compatible = "ibm,plb-pciex-405exr", "ibm,plb-pciex";
> > +			primary;
> > +			port = <0>; /* port number */
> > +			reg = <a0000000 20000000	/* Config space access */
> > +			       ef000000 00001000>;	/* Registers */
> > +			dcr-reg = <040 020>;
> > +			sdr-base = <400>;
>
> Oh, for crying out loud.  They put dcrs on the bridge as well as MMIO
> registers. *facepalm*

Yep. PCIe on 4xx has DCR, SDR *and* MMIO registers.

Best regards,
Stefan
