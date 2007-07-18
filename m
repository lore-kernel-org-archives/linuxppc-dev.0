Return-Path: <dgibson@ozlabs.org>
Date: Wed, 18 Jul 2007 11:31:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Message-ID: <20070718013110.GA18251@localhost.localdomain>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 28, 2007 at 10:59:35AM +0200, Segher Boessenkool wrote:
> > Here is an implementation to allow PReP systems to boot under the
> > arch/powerpc codebase, one of the few remaining platforms supported in
> > arch/ppc but not so far in arch/powerpc.
> 
> > Too big for the list, the patch is at:
> > 	http://ozlabs.org/~dgibson/home/prep-support
> 
> Too lazy to split the patch into bite-size chunks, you mean ;-)

Well... much as I like small patches, I don't really like having a big
string of patches, each of which does basically nothing on its own,
i.e. split up just for the sake of making smaller, rather than into
separate logically separate changes.

> Anyway, here goes the DTS bits:
> 
> +/*
> + * PReP skeleton device tree
> + *
> + * Paul Mackerras <paulus@samba.org>
> + */
> +
> +/ {
> +	device_type = "prep";
> +	model = "IBM,PReP";
> 
> Not specific enough, leave it out or fill it in in the bootwrapper.

Yeah, I should fill that in with the string from the residual data.
Haven't gotten around to it.

> +	compatible = "prep";
> 
> Maybe fill this in, too.
> 
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> 
> Do all (supported) PReP boards have one CPU only?

Well, depends what you mean by "supported", really.  My arch/powerpc
port only support UP boards so far...  I realise this will need to
change at some point.

> 
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <0>; // filled in by bootwrapper
> +			bus-frequency = <0>; // filled in by bootwrapper
> +			timebase-frequency = <0>; // filled in by bootwrapper
> +			i-cache-line-size = <0>; // filled in by bootwrapper
> +			d-cache-line-size = <0>; // filled in by bootwrapper
> +			d-cache-size = <0>; // filled in by bootwrapper
> +			i-cache-size = <0>; // filled in by bootwrapper
> +			external-control;
> 
> Really?

No idea, just copied that from earlier work of Paulus'.  Don't even
know what the property means.

> +			graphics;
> +			performance-monitor;
> +
> +			l2-cache {
> +				device_type = "cache";
> +				i-cache-size = <00100000>;
> +				d-cache-size = <00100000>;
> +				i-cache-sets = <00008000>;
> +				d-cache-sets = <00008000>;
> +				i-cache-line-size = <00000020>;
> +				d-cache-line-size = <00000020>;
> 
> Drop the leading zeroes, they make my head spin :-)
> 
> +				cache-unified;
> +			};
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		// dummy range here, zImage wrapper will fill in the actual
> +		// amount of memory from the residual data
> +		reg = <00000000 00000000>;
> +	};
> +
> +	pci@80000000 {
> +		device_type = "pci";
> +		compatible = "prep";
> 
> Is that specific enough?

Well, AFAICT, the prep PCI code doesn't need any more info.

> +		clock-frequency = <01fca055>;
> +		reg = <80000000 7effffff>;
> +		8259-interrupt-acknowledge = <bffffff0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges=<01000000 00000000 00000000 80000000 00000000 00800000
> +			01000000 00000000 00800000 81000000 00000000 3e800000
> +			02000000 00000000 00000000 c0000000 00000000 01000000
> +			02000000 00000000 01000000 c1000000 00000000 3e000000>;
> +		interrupt-map-mask = <f800 0 0 7>;
> +		interrupt-map = <6000 0 0 1	&MPIC 6 0
> +				 8000 0 0 1	&MPIC 7 0
> +				 9000 0 0 1	&MPIC 2 0
> +				 b000 0 0 1	&MPIC 1 0>;
> 
> I can't believe this "ranges" and interrupt mapping will
> work on all PReP systems...

Probably not, but it should work on a chunk of them.  Like I say,
there's still a good deal more that needs to be filled in from
residual data or wherever.

> +		isa {
> +			device_type = "isa";
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <2>;
> +			ranges = <00000001 00000000
> +				  01005800 00000000 00000000  00010000
> +				  00000000 00000000
> +				  02005800 00000000 00000000  01000000>;
> +
> +			parallel {
> +				device_type = "parallel";
> +				compatible = "ecp", "pnpPNP,400";
> 
> "pnpPNP,401", "pnpPNP,400"
> 
> +				reg =  <00000001 000003bc  00000008
> +					00000001 000007bc  00000006>;
> +				interrupts = <00000007 00000003>;
> +				interrupt-parent = <&PIC8259>;
> +			};
> +
> +			serial@3f8 {
> +				device_type = "serial";
> +				compatible = "pnpPNP,501";
> 
> "pnpPNP,501", "pnpPNP,500" I'd say.  Many/some device
> tree users will only care it is _some_ 8250 family thing.
> 
> +				clock-frequency = <001c2000>;
> +				reg =  <00000001 000003f8  00000008>;
> +				interrupts = <00000004 00000003>;
> +				interrupt-parent = <&PIC8259>;
> +			};
> +			serial@2f8 {
> +				device_type = "serial";
> +				compatible = "pnpPNP,501";
> +				clock-frequency = <001c2000>;
> +				reg =  <00000001 000002f8  00000008>;
> +				interrupts = <00000003 00000003>;
> +				interrupt-parent = <&PIC8259>;
> +			};
> +			PIC8259: interrupt-controller {
> +				device_type = "i8259";
> 
> device_type = "interrupt-controller".
> 
> +				compatible = "prep,iic";
> +				reg = <	00000001 00000020  00000002
> +					00000001 000000a0  00000002
> +					00000001 000004d0  00000002>;
> +				interrupts = <00000000 00000003
> +					      00000002 00000003>;
> +				interrupt-parent = <&MPIC>;
> +			};
> +		};
> +
> +		MPIC: interrupt-controller@d {
> +			device_type = "open-pic";
> 
> device_type = "interrupt-controller".
> 
> +			compatible = "mpic";
> +			reg = <	00006800 00000000 00000000  00000000 00000000
> +				02006810 00000000 00000000  00000000 00040000>;
> +			assigned-addresses = <
> +				82006810 00000000 3afc0000  00000000 00040000>;
> +		};
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/pci/isa/serial@3f8";
> +	};
> +};
> 
> What is the plan here -- have the bootwrapper build the
> device tree / fill in the details from the residual data?

Not sure at this stage if it will be best for the bootwrapper to build
a complete tree from residual, or to have a dts skeleton with
substantial chunks filled in by bootwrapper from residual.  I was
intending to merge libfdt into the kernel for more flexible device
tree manipulation before investigating that further.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
