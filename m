Return-Path: <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 1/5 v3] powerpc: DTS file for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080520011304.GG22279@yookeroo.seuss>
References: <1211241624.19212.29.camel@pcds-ts102.slac.stanford.edu>
	<20080520011304.GG22279@yookeroo.seuss>
Content-Type: text/plain
Date: Tue, 20 May 2008 09:38:08 -0700
Message-Id: <1211301489.19212.32.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-05-20 at 11:13 +1000, David Gibson wrote:
> On Mon, May 19, 2008 at 05:00:23PM -0700, Remi Machet wrote:
> > Support for the C2K cPCI Single Board Computer from GEFanuc
> > (PowerPC MPC7448 with a Marvell MV64460 chipset)
> > All features of the board are not supported yet, but the board
> > boots, flash works, all Ethernet ports are working and PCI 
> > devices are all found (USB and SATA on PCI1 do not work yet).
> > 
> > Part 1 of 5: DTS file describing the board peripherals. As far as I know
> > all peripherals except the FPGA are listed in there (I did not included
> > the FPGA because a lot of work is needed there).
> 
> [snip]
> > +		ethernet-group@2000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "marvell,mv64360-eth-group";
> > +			reg = <0x2000 0x2000>;
> > +			PHY0: ethernet-phy@0 {
> > +				device_type = "ethernet-phy";
> > +				interrupts = <76>;	/* GPP 12 */
> > +				interrupt-parent = <&PIC>;
> > +				reg = <0>;
> > +			};
> > +			ethernet@0 {
> > +				device_type = "network";
> > +				compatible = "marvell,mv64360-eth";
> > +				reg = <0>;
> > +				interrupts = <32>;
> > +				interrupt-parent = <&PIC>;
> > +				phy = <&PHY0>;
> > +				local-mac-address = [ 00 00 00 00 00 00 ];
> > +			};
> 
> Not sure if this is new, or I just didn't notice it before.  Also not
> sure if this is your mistake, or a mistake in the binding for the
> marvell device here.
> 
> The address in "reg" should be unique within the bus the device
> appears on.  So having both the PHY and the MAC devices with the same
> "reg" and same unit address here is bad.
> 
> Having both the PHYs and the MACs as children of the ethernet-group
> node is possible, but the addresses must be encoded to distinguish
> them (e.g. MACs are 0x0, 0x1, 0x2, PHYS are 0x1000 0x1001 0x1002).
> 
It was an attempt at getting rid of the mdio group since the PHY is
effectively managed by the Ethernet hardware. The problem is that the
reg field must contain those values ... if I change this, I must change
the driver and other boards DTS files that depend on it which I would
rather not do at the same time I am pushing this patch through.

I will put back the mdio group and add a reg field to it as you
suggested previously.

Remi
