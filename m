Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2D1AFDDDCF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 02:47:33 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1MFlTTC014643
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 08:47:30 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1MFlTKr021860
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 09:47:29 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: document new interrupt-array property
Date: Thu, 22 Feb 2007 08:47:28 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
In-Reply-To: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net><A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org><20070222011811.GA18364@localhost.localdomain><45b623f395654fc4f4920b9553794def@kernel.crashing.org><20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Segher Boessenkool
> Sent: Thursday, February 22, 2007 5:06 AM
> To: David Gibson
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org; Yoder Stuart-B08248
> Subject: Re: [PATCH] powerpc: document new interrupt-array property
>=20
> >> Not really a hack, this is documented in the interrupt
> >> binding:
> >
> > No, it really is a hack, I'm afraid.  interrupt-map doesn't=20
> in general
> > make sense for mapping interrupt-children which are not physical
> > children.  Why?  Because the interrupt map includes unit specifiers,
> > which means the expected addressing format in the interrupt map must
> > match that of the reg property in every node mapped through it.
>=20
> Hrm I guess I misunderstood the way you do things now.
> Could you give an example?  I'm too lazy to look up
> the DTS file :-)

So there seems to be 3 options:

Option #1 -- Current 'hack' :) looks like this.  This works but is
ugly.

  MAL0: mcmal {
      /* FIXME */
      device_type =3D "mcmal-dma";
      compatible =3D "ibm,mcmal-440gp", "ibm,mcmal";
      dcr-reg =3D <180 62>;
      num-tx-chans =3D <4>;
      num-rx-chans =3D <4>;
      interrupt-parent =3D <&MAL0>;
      interrupts =3D <0 1 2 3 4>;
      #interrupt-cells =3D <1>;
      #address-cells =3D <0>;
      #size-cells =3D <0>;
      interrupt-map =3D </*TXEOB*/ 0 &UIC0 a 4
               /*RXEOB*/ 1 &UIC0 b 4
               /*SERR*/  2 &UIC1 0 4
               /*TXDE*/  3 &UIC1 1 4
               /*RXDE*/  4 &UIC1 2 4>;
      interrupt-map-mask =3D <ffffffff>;
  };

Option #2 -- new interrupt-array property.  MAL would look
like this:

  MAL0: mcmal {
      /* FIXME */
      device_type =3D "mcmal-dma";
      compatible =3D "ibm,mcmal-440gp", "ibm,mcmal";
      dcr-reg =3D <180 62>;
      num-tx-chans =3D <4>;
      num-rx-chans =3D <4>;
      interrupt-array =3D <&UIC0 a 4
                         &UIC0 b 4
                         &UIC1 0 4
                         &UIC1 1 4
                         &UIC1 2 4>;
  };

Option #3 -- define new, logical interrupt nexus to do
the mapping.   Not sure if I got this right but here is
my take on what this might look like:

  MALINT: malint_nexus {
      #interrupt-cells =3D <1>;
      #address-cells =3D <0>;
      #size-cells =3D <0>;
      interrupt-map =3D </*TXEOB*/ 0 &UIC0 a 4
               /*RXEOB*/ 1 &UIC0 b 4
               /*SERR*/  2 &UIC1 0 4
               /*TXDE*/  3 &UIC1 1 4
               /*RXDE*/  4 &UIC1 2 4>;
      interrupt-map-mask =3D <ffffffff>;
  }

  MAL0: mcmal {
      /* FIXME */
      device_type =3D "mcmal-dma";
      compatible =3D "ibm,mcmal-440gp", "ibm,mcmal";
      dcr-reg =3D <180 62>;
      num-tx-chans =3D <4>;
      num-rx-chans =3D <4>;
      interrupt-parent =3D <&MALINT>;
      interrupts =3D <0 1 2 3 4>;
  };

The malint_nexus node is attache to / I guess??  Segher
is this what you had in mind?

The question is-- is option #3 clear enough?  Is a new
property warranted?

Stuart=20
