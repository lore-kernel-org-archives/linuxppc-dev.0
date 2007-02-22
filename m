Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22948DDDCF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 04:09:50 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net><A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org><20070222011811.GA18364@localhost.localdomain><45b623f395654fc4f4920b9553794def@kernel.crashing.org><20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Thu, 22 Feb 2007 18:09:40 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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

I'd rather write it like

>       interrupts        = < a 4   b 4   0 4   1 4   2 4 >
>       interrupt-parents = <&UIC0 &UIC0 &UIC1 &UIC1 &UIC1>

to stay closer to the existing binding, but yes.

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

I'd put it as a child node of the mcmal node, like this:

   MAL0: mcmal {
       /* FIXME */
       device_type = "mcmal-dma";
       compatible = "ibm,mcmal-440gp", "ibm,mcmal";
       dcr-reg = <180 62>;
       num-tx-chans = <4>;
       num-rx-chans = <4>;
       interrupt-parent = <&MALINT>;
       interrupts = <0 1 2 3 4>;

       MALINT: mal-nexus {
           device_type = "interrupt-nexus"
           #interrupt-cells = <1>;
           interrupt-map = </*TXEOB*/  0   &UIC0   a 4
                            /*RXEOB*/  1   &UIC0   b 4
                            /*SERR*/   2   &UIC1   0 4
                            /*TXDE*/   3   &UIC1   1 4
                            /*RXDE*/   4   &UIC1   2 4>;
           interrupt-map-mask = <ff>;
       }
   }

> The question is-- is option #3 clear enough?

I think so.  A separate nexus pseudo-node needs hardly
any properties (no "#address-cells", no "reg", no nothing)
and nicely expresses the whole thing, within the existing
framework.

> Is a new property warranted?

The proposed "interrupt-array" property, apart from being
a horrible name, only handles one very specific manifestation
of a much more general problem: random weirdness in the
interrupt routing that doesn't conform to the "normal" device
tree.  The existing interrupt mapping binding can handle the
generic case just fine, with a very simple but extremely
flexible framework.  The fact that you sometimes need an
extra "pseudo" device node is actually very natural: it
represent an interrupt "bus".  There is no really good place
for such a node though; depending on the situation, it seems
best to hang it either from the node that represents the
origin of the interrupts (in case this is routing from one
device only), or the node that represents their destination
(typically, an interrupt controller).


Segher
