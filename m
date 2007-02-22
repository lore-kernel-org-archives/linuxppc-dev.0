Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Feb 2007 09:57:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070222225707.GB15387@localhost.localdomain>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2007 at 08:47:28AM -0700, Yoder Stuart-B08248 wrote:
>  
> > -----Original Message-----
> > From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org 
> > [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org] 
> > On Behalf Of Segher Boessenkool
> > Sent: Thursday, February 22, 2007 5:06 AM
> > To: David Gibson
> > Cc: linuxppc-dev@ozlabs.org; paulus@samba.org; Yoder Stuart-B08248
> > Subject: Re: [PATCH] powerpc: document new interrupt-array property
> > 
> > >> Not really a hack, this is documented in the interrupt
> > >> binding:
> > >
> > > No, it really is a hack, I'm afraid.  interrupt-map doesn't 
> > in general
> > > make sense for mapping interrupt-children which are not physical
> > > children.  Why?  Because the interrupt map includes unit specifiers,
> > > which means the expected addressing format in the interrupt map must
> > > match that of the reg property in every node mapped through it.
> > 
> > Hrm I guess I misunderstood the way you do things now.
> > Could you give an example?  I'm too lazy to look up
> > the DTS file :-)
> 
> So there seems to be 3 options:
> 
> Option #1 -- Current 'hack' :) looks like this.  This works but is
> ugly.
> 
>   MAL0: mcmal {
>       /* FIXME */
>       device_type = "mcmal-dma";
>       compatible = "ibm,mcmal-440gp", "ibm,mcmal";
>       dcr-reg = <180 62>;
>       num-tx-chans = <4>;
>       num-rx-chans = <4>;
>       interrupt-parent = <&MAL0>;
>       interrupts = <0 1 2 3 4>;
>       #interrupt-cells = <1>;
>       #address-cells = <0>;
>       #size-cells = <0>;
>       interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
>                /*RXEOB*/ 1 &UIC0 b 4
>                /*SERR*/  2 &UIC1 0 4
>                /*TXDE*/  3 &UIC1 1 4
>                /*RXDE*/  4 &UIC1 2 4>;
>       interrupt-map-mask = <ffffffff>;
>   };
> 
> Option #2 -- new interrupt-array property.  MAL would look
> like this:
> 
>   MAL0: mcmal {
>       /* FIXME */
>       device_type = "mcmal-dma";
>       compatible = "ibm,mcmal-440gp", "ibm,mcmal";
>       dcr-reg = <180 62>;
>       num-tx-chans = <4>;
>       num-rx-chans = <4>;
>       interrupt-array = <&UIC0 a 4
>                          &UIC0 b 4
>                          &UIC1 0 4
>                          &UIC1 1 4
>                          &UIC1 2 4>;
>   };
> 
> Option #3 -- define new, logical interrupt nexus to do
> the mapping.   Not sure if I got this right but here is
> my take on what this might look like:
> 
>   MALINT: malint_nexus {
>       #interrupt-cells = <1>;
>       #address-cells = <0>;
>       #size-cells = <0>;
>       interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
>                /*RXEOB*/ 1 &UIC0 b 4
>                /*SERR*/  2 &UIC1 0 4
>                /*TXDE*/  3 &UIC1 1 4
>                /*RXDE*/  4 &UIC1 2 4>;
>       interrupt-map-mask = <ffffffff>;
>   }
> 
>   MAL0: mcmal {
>       /* FIXME */
>       device_type = "mcmal-dma";
>       compatible = "ibm,mcmal-440gp", "ibm,mcmal";
>       dcr-reg = <180 62>;
>       num-tx-chans = <4>;
>       num-rx-chans = <4>;
>       interrupt-parent = <&MALINT>;
>       interrupts = <0 1 2 3 4>;
>   };
> 
> The malint_nexus node is attache to / I guess??  Segher
> is this what you had in mind?
> 
> The question is-- is option #3 clear enough?  Is a new
> property warranted?

There's no point to option 3 as given.  If we're going to use an
interrupt nexus, and rely on the fact that the physical versus
interrupt tree addressing mismatch doesn't matter in this case, then
we might as well put the interrupt nexus into the node itself,
i.e. option 1.  The only point to 3 would be if we make the MAL a
child of its interrupt nexus, thereby ensuring that the address forms
match.

Something like:

malint-nexus {
	#interrupt-cells = <1>;
	ranges;
	interrupt-map = <0 0 0 &UIC0 a 4
		.... >;
	interrupt-map-mask = <ffffffff 0 0>;
	MAL0: mcmal {
		device_type = "mcmal-dma";
		compatible = "ibm,mcmal-440gp", "ibm,mcmal";
		dcr-reg = <180 62>;
		num-tx-chans = <4>;
		num-rx-chans = <4>;
		interrupt-parent = <&MALINT>;
		interrupts = <0 1 2 3 4>;
	};
};

Note the empty ranges property (passthrough).  That's kind of
irrelevant here, since MAL is DCR controlled, but would matter if we
had a similar situation with a device that had MMIO registers (and
therefore a "reg" property).  For MAL, since it has no "reg", we set
the interrupt-map-mask to ignore the unit address.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
