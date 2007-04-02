Return-Path: <mgreer@mvista.com>
Date: Mon, 2 Apr 2007 11:06:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070402180659.GG2132@mag.az.mvista.com>
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

Yep.

> comments inline below-- 

Several of your other comments have already been talked about in other
emails so I'll add on to them and not here.  I'll answer the ones that
I didn't see a response to below.

<snip>

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

Well, 'mv64x60' means Marvell mv64x60 hostbridge.  If that ctlr exists
on non-bridge Marvell parts then it should probably be renamed Marvell
or something like that.

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
> applicable add it to booting-without-of.txt.

It can go.

Mark
