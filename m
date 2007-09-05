Return-Path: <robert.wood@gefanuc.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4ECDBDDFEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 06:00:12 +1000 (EST)
Received: from int-nj2ut-1.online-age.net (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id l85K09lw010774
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Sep 2007 16:00:09 -0400
Received: from cinmlef06.e2k.ad.ge.com (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by int-nj2ut-1.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l85K089w007743
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Sep 2007 16:00:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx FX60
Date: Wed, 5 Sep 2007 16:00:08 -0400
Message-ID: <0F3B2CB6574F1A488E62523706BF8A770226B07E@LOUMLVEM03.e2k.ad.ge.com>
In-Reply-To: <1189020639.6185.51.camel@PisteOff>
References: <1189017748.6185.49.camel@PisteOff>
	<0F3B2CB6574F1A488E62523706BF8A770226B07D@LOUMLVEM03.e2k.ad.ge.com>
	<1189020639.6185.51.camel@PisteOff>
From: "Wood, Robert (GE Indust, GE Fanuc)" <robert.wood@gefanuc.com>
To: "Robert Woodworth" <rwoodworth@securics.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In the UCF we tightened up the spec for the core clock by around 15%
rather than 10%.

The resets were given a max delay constraint and physical location.

Some examples taken from our UCF file.

NET EC_FPGA_RESET_N TIG;


NET "RSTC405RESETSYS" TPTHRU =3D RST_GRP;
NET "RSTC405RESETCHIP" TPTHRU =3D RST_GRP;
NET "RSTC405RESETCORE" TPTHRU =3D RST_GRP;
NET "C405RSTSYSRESETREQ" TPTHRU =3D RST_GRP;
NET "C405RSTCHIPRESETREQ" TPTHRU =3D RST_GRP;
NET "C405RSTCORERESETREQ" TPTHRU =3D RST_GRP;
TIMESPEC "TS_RST1" =3D FROM CPUS THRU RST_GRP TO FFS TIG;=20

# Constrain Placement on PPC:
INST "ppc405_0/ppc405_0/PPC405_i" LOC =3D PPC405_X1Y0;

# Constrain the Xilinx IP reset block close to the PPC:
INST reset_block* AREA_GROUP=3D"RESET_BLOCK_GRP";
AREA_GROUP "RESET_BLOCK_GRP" RANGE=3DSLICE_X94Y81:SLICE_X109Y72;

INST "reset_block/reset_block/Rstc405resetcore" TNM =3D
"reset_block/reset_block/Rstc405resetcore";
INST "reset_block/reset_block/Rstc405resetsys"  TNM =3D
"reset_block/reset_block/Rstc405resetsys";
INST "reset_block/reset_block/Rstc405resetchip" TNM =3D
"reset_block/reset_block/Rstc405resetchip";
INST "ppc405_0/ppc405_0/PPC405_i" TNM =3D "ppc405_0/ppc405_0/PPC405_i";
TIMESPEC "TS_reset_core" =3D FROM
"reset_block/reset_block/Rstc405resetcore" TO
"ppc405_0/ppc405_0/PPC405_i" 2.0 ns;
TIMESPEC "TS_reset_sys"  =3D FROM
"reset_block/reset_block/Rstc405resetsys"  TO
"ppc405_0/ppc405_0/PPC405_i" 2.0 ns;
TIMESPEC "TS_reset_chip" =3D FROM
"reset_block/reset_block/Rstc405resetchip" TO
"ppc405_0/ppc405_0/PPC405_i" 2.0 ns;

Robert Wood
GEFanuc Sensor Processing
5430 Canotek Road
Ottawa, Ontario
Canada K1J 9G2
613-749-9241 x270
=20
-----Original Message-----
From: Robert Woodworth [mailto:rwoodworth@securics.com]=20
Sent: Wednesday, September 05, 2007 3:31 PM
To: Wood, Robert (GE Indust, GE Fanuc)
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx FX60

On Wed, 2007-09-05 at 14:56 -0400, Wood, Robert (GE Indust, GE Fanuc)
wrote:
> We've been using Virtex 2 PRO with dual cores. We found it necessary
to
> very tightly constrain clocks and resets. Also, constrain the reset
> block to adjacent to the ports on the PPC.

What constraints did you tighten?? EDK or ISE?


> Another lightly documented feature is that the core clock must be an
> integer multiple of the PLB clock, say 300MHz/100MHz.
>=20
> Robert Wood
> GEFanuc Sensor Processing
> 5430 Canotek Road
> Ottawa, Ontario
> Canada K1J 9G2
> 613-749-9241 x270
> =20
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+rwood=3Dics-ltd.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+rwood=3Dics-ltd.com@ozlabs.org] On
> Behalf Of Robert Woodworth
> Sent: Wednesday, September 05, 2007 2:42 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Xilinx FX60
>=20
> After achieving complete success with my Linux kernel on the ML403,
I've
> now started to build a kernel for my real target board with a
> Virtex4-FX60 (dual PPC cores)
>=20
> Has anyone built a kernel for a dual core PPC Virtex?  I have found
very
> little docs on how to architect software for the dual-core PPC's. =20
> Will SMP Linux work on this platform?  What would the bus setup be?
>=20
>=20
>=20
> My kernel is partially booting, some of the time... I'm mystified by
the
> situation.  One time, I get all the happy boot messages through the
> UARTLite port, then the next reboot it stops at "Now booting the
kernel"
> I'm only getting about 10% successful boots......
>=20
>=20
> My EDK setup is as follows;  I've disconnected the second PPC from the
> PLB to have a single PPC system, 32MB DDR on PLB, TEMAC on PLB,
UARTLite
> on OPB.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
