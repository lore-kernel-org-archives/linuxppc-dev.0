Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 29 Mar 2007 15:18:59 -0700
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070329221858.GA22134@xyzzy.farnsworth.org>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2007 at 09:43:16AM -0700, Yoder Stuart-B08248 wrote:
> 
> Biggest concern is that I see a lot of undocumented device
> types and properties...
> 
> Device types that I do not recognize include:
> +			device_type = "brg";
> +			device_type = "mv64x60-cunit";
> +			device_type = "mpscrouting";
> +			device_type = "mpscintr";
> +			device_type = "mv64x60-pic";
> +			device_type = "mv64x60-mpp";
> +			device_type = "mv64x60-gpp";
> +			device_type = "mv64x60-cpu-error";
> +			device_type = "mv64x60-sram-error";
> +			device_type = "mv64x60-pci-error";
> +			device_type = "mv64x60-memctrl";
> 
> These should ideally be documented with required properties
> and what they mean.
> 
> I think a document similar to Grant Likely's
> Documentation/mpc52xx-device-tree-bindings.txt would be
> very helpful here.  People using this DTS as a starting
> point are going to have a lot of questions.

Great suggestion.  I'll begin and submit such a document.

> comments inline below-- 
> [snip]
> 
> > +
> > +	mv64x60@f1000000 { /* Marvell Discovery */
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		#interrupt-cells = <1>;
> > +		device_type = "mv64360";
> > +		compatible = "mv64x60";
> > +		clock-frequency = <7f28155>;		/* 
> > 133.333333 Mhz */
> > +		reg = <f1000000 00010000>;
> > +		virtual-reg = <f1000000>;
> 
> What is virtual-reg for?  I gather it is related to the bootwrapper
> needed virtual addresses for devices reg blocks.  But, I counted
> 12 instances of the property in this file.  Are all needed by the
> bootwrapper??
> 
> Does anyone where this property came from historically?  If it's
> specifically for a Linux bootwrapper the name should reflect 
> that-- linux,bootwrapper-reg-vaddr -- or something...
> 
> I also wonder if there is a better place to put this information.
> The device nodes strictly speaking should be describing the devices
> _physical_ characteristics.
> 
> It also needs to be documented in booting-without-of.txt.

I'll let Mark comment on this since he has been doing the bootwrapper
code.  He has family visiting this week and is showing them the
Arizona sights.  He should be back next week.

> [snip]
> > +			reg = <2000 2000>;
> > +			virtual-reg = <f1002000>;
> > +			eth0 {
> > +				device_type = "network";
> > +				compatible = "mv64x60-eth";
> > +				block-index = <0>;
> > +				interrupts = <20>;
> > +				interrupt-parent = <&/mv64x60/pic>;
> > +				phy = <&/mv64x60/mdio/ethernet-phy@1>;
> > +				local-mac-address = [ 00 00 00 
> > 00 00 00 ];
> > +			};
> > +			eth1 {
> > +				device_type = "network";
> > +				compatible = "mv64x60-eth";
> > +				block-index = <1>;
> > +				interrupts = <21>;
> > +				interrupt-parent = <&/mv64x60/pic>;
> > +				phy = <&/mv64x60/mdio/ethernet-phy@3>;
> > +				local-mac-address = [ 00 00 00 
> > 00 00 00 ];
> > +			};
> > +		};
> 
> Based on some offline dicussions I think I know what block-index
> is, but I'd like to see this property documented in
> booting-without-of.txt.
> 
> [snip]
> > +		i2c@c000 {
> > +			device_type = "i2c";
> > +			compatible = "mv64x60-i2c";
> > +			reg = <c000 20>;
> > +			virtual-reg = <f100c000>;
> > +			freq_m = <8>;
> > +			freq_n = <3>;
> > +			timeout = <3e8>;		/* 1000 
> 
> If freq_m and freq_n are Marvell specific should have
> a "Marvel," prepended to them?

Great suggestion.  These are baud clock divisors.  We'll do that
for now.  I also have a separate patch that, instead, puts the desired
baud in the dts and lets the I2C driver calculate the divisors.

> [snip]
> > +		pci@80000000 {
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			#interrupt-cells = <1>;
> > +			device_type = "pci";
> > +			compatible = "mv64x60-pci";
> > +			reg = <0cf8 8>;
> > +			ranges = <01000000 0        0 88000000 
> > 0 01000000
> > +				  02000000 0 80000000 80000000 
> > 0 08000000>;
> > +			bus-range = <0 ff>;
> > +			clock-frequency = <3EF1480>;
> > +			interrupt-pci-iack = <0c34>;
> 
> I don't think interrupt-pci-iack is standard.  If it's generally
> applicable add it to booting-without-of.txt.  If its MV specific 
> prepend with "Marvel,".

interrupt-pci-iack is unused.  I think we can remove it altogether.

> Regards,
> Stuart Yoder

Thanks,
-Dale Farnsworth
