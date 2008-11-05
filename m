Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E852DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 07:32:38 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Wed, 5 Nov 2008 21:32:31 +0100
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811041217.04961.matthias.fuchs@esd-electronics.com>
	<1225834184.8004.268.camel@pasglop>
In-Reply-To: <1225834184.8004.268.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811052132.31542.matthias.fuchs@esd-electronics.com>
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,=20

we build some 4xx based PMC modules in the past. These boards can
run as host ("processor PMC" or so called "monarch" mode) or as PCI endpoint
("non-monarch" mode). I would like to use the same DT (and kernel) in both=
=20
modes.
Currently I set the "status" property of the PCI node to "disabled" to prev=
ent=20
the kernel to do the host bride stuff (not good as I learned). But we need=
=20
some info from the PCI node even in endpoint mode. So disable is not the be=
st=20
idea.=20

In endpoint mode the current PCI node has many properties that
make no sense and others are missing. So one could think of a pci _and_=20
pci-endpoint node. The one that is not needed can be disabled, e.g. by=20
U-Boot (if you are using U-Boot :-).

I could live with a mode or empty endpoint property, but I am not sure how
to keep the endpoint interrupt properties side-by-side with the host
interrupt mapping. I do not want to patch multiple properties by the=20
bootloader to switch between host and endpoint. No can we have=20
interrupt-parent + interrupts property in the same node with=20
interrupt-map-mask + interrupt-map?

                PCI0: pci@1ec000000 {
                        device_type =3D "pci";
			endpoint; /* Ben's suggestion */

			/* makes only sense for endpoints */
                        interrupt-parent =3D <&UIC0>;
                        interrupts =3D <0x5 0x4 /* PCI command write */
                                      0x6 0x4>; /* PCI power management */

                        #interrupt-cells =3D <1>;
                        #size-cells =3D <2>;
                        #address-cells =3D <3>;
                        compatible =3D "ibm,plb440epx-pci", "ibm,plb-pci";
                        primary;
                        reg =3D <0x00000001 0xeec00000 0x00000008
                               0x00000001 0xeed00000 0x00000004
                               0x00000001 0xeed00000 0x00000004
                               0x00000001 0xef400000 0x00000040>;

			/* makes some sense for endpoints=20
			Values might differ between host and endpoints */
                        ranges =3D <...>;

                        /* makes some sense for endpoints */
                        dma-ranges =3D <...>;

                        interrupt-map-mask =3D <...>;
                        interrupt-map =3D <...>;
                };
        };

Matthias

On Tuesday 04 November 2008 22:29:44 Benjamin Herrenschmidt wrote:
> On Tue, 2008-11-04 at 12:17 +0100, Matthias Fuchs wrote:
> > I must admit that I am not sure what you mean by (pci-endpoint)
> > _name_.
> > Do you mean something like this:
> >
> >         PCI: pci@abc {
> >                 endpoint =3D "pci-endpoint";
> >                 ...
> >
> > To many "endpoint" appearances for my taste:-)
>
> No, by name I meant
>
> 	PCI: pci-endpoint@xxxx {
> 	}
>
> But if we want to have the same device node easily convert between
> endpoint and host, maybe simply a property would be enough. Either just
> an empty "endoint" property or a "mode" property containing "endpoint"
>  vs. "host".
>
> I tend to prefer changing the name if we aren't going to be a host
> bridge though.
>
> Ben.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev



=2D-=20
=2D------------------------------------------------------------------------
Dipl.-Ing. Matthias Fuchs
Head of System Design

esd electronic system design gmbh
Vahrenwalder Str. 207 - 30165 Hannover - GERMANY
Phone: +49-511-37298-0 - Fax: +49-511-37298-68
Please visit our homepage http://www.esd.eu
Quality Products - Made in Germany
=2D------------------------------------------------------------------------
Gesch=E4ftsf=FChrer: Klaus Detering, Dr. Werner Schulze
Amtsgericht Hannover HRB 51373 - VAT-ID DE 115672832
=2D------------------------------------------------------------------------
