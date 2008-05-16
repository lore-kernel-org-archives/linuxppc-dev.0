Return-Path: <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 1/5] powerpc: DTS file for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080516015354.GA27188@yookeroo.seuss>
References: <1210897371.13992.13.camel@pcds-ts102.slac.stanford.edu>
	<20080516015354.GA27188@yookeroo.seuss>
Content-Type: text/plain
Date: Fri, 16 May 2008 10:20:34 -0700
Message-Id: <1210958434.14306.9.camel@pcds-ts102.slac.stanford.edu>
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

Hi David,

Thank you for the comments, I am in the process of changing the C2K dts
file. I have a few questions bellow:

On Fri, 2008-05-16 at 11:53 +1000, David Gibson wrote: 
> On Thu, May 15, 2008 at 05:22:50PM -0700, Remi Machet wrote:
> > Support for the C2K cPCI Single Board Computer from GEFanuc
> > (PowerPC MPC7448 with a Marvell MV64460 chipset)
> > All features of the board are not supported yet, but the board
> > boots, flash works, all Ethernet ports are working and PCI 
> > devices are all found (USB and SATA on PCI1 do not work yet).
> > 
> > Part 1 of 5: DTS file describing the board peripherals. As far as I know
> > all peripherals except the FPGA are listed in there (I did not included
> > the FPGA because a lot of work is needed there).
> > 
> > Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
> > ---
> >  c2k.dts |  353 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 353 insertions(+)
> > 
> > diff --git a/arch/powerpc/boot/dts/c2k.dts b/arch/powerpc/boot/dts/c2k.dts
> > new file mode 100644
> > index 0000000..21281b8
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/c2k.dts
> [snip]
> > +		CUNIT: cunit@f200 {
> > +			reg = <0xf200 0x200>;
> > +		};
> > +
> > +		MPSCROUTING: mpscrouting@b400 {
> > +			reg = <0xb400 0xc>;
> > +		};
> > +
> > +		MPSCINTR: mpscintr@b800 {
> > +			reg = <0xb800 0x100>;
> > +			virtual-reg = <0xd800b800>;
> > +		};
> 
> These devices should really have compatible properties, but that's
> not really your problem, it needs to be addressed by whoever's
> responsible for the mpsc binding.
Those properties don't have a driver but instead are referred to by
MPSC0, so why would they need a compatible field ?

> > +		PCI0: pci@80000000 {
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			#interrupt-cells = <1>;
> > +			device_type = "pci";
> > +			compatible = "marvell,mv64360-pci";
> > +			cell-index = <0>;
> 
> This is a suspicious looking use of cell-index, though again this
> could be a problem in the binding rather than your tree per se.
> cell-index should *only* be present if it's used to index into some
> shared resource register.
This is actually my mistake: I use this property in
arch/powerpc/boot/c2k.c to differentiate the 2 PCI buses. What property
should I use instead ? I could detect the PCI bus # based on the reg
property (memory base can change but not the registers address), what do
you think ?

Remi
