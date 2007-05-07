Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E95B4DDEF6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 03:31:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l47HVPVG015245
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 10:31:25 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l47HVOnr027393
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 12:31:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
Date: Mon, 7 May 2007 10:31:24 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C012AA283@az33exm24.fsl.freescale.net>
In-Reply-To: <1178317526.6353.106.camel@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32><1178187440.20944.12.camel@localhost.localdomain><1178208838.17201.52.camel@ld0161-tx32><1178228208.6353.55.camel@localhost.localdomain><E1HjzWH-0001Wg-Ps@jdl.com>
	<1178317526.6353.106.camel@localhost.localdomain>
From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Jon Loeliger" <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sorry I don't remember the actual patch, must have missed it... I
> suppose we could have generic code in early_init_devtree set=20
> the default
> for this based on cpu_possible_map() containing more than one bit and
> have platforms using one of those broken bridges force the bit in from
> their probe routine.
>=20
> Ben.

Hi Ben,

Yeah, I had no actual intention of retrofitting
This into all the existing boards.  I was more
Wanting to leave them alone and simply un-set the
Bit on the one board where I wanted it done better.

My proposed solution in the _probe() routine was:

        static int __init mpc86xx_hpcn_probe(void)
        {
        	unsigned long root =3D of_get_flat_dt_root();
       =20
        	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
        		/* get number_of_cpus() from somewhere */
        		if (number_of_cpus() =3D=3D 1) {
        			cur_cpu_spec->cpu_features &=3D
~CPU_FTR_NEED_COHERENT;
        		}
        		return 1;	/* Looks good */
        	}
       =20
        	return 0;
        }

Or perhaps:

        static int __init mpc86xx_hpcn_probe(void)
        {
        	unsigned long root =3D of_get_flat_dt_root();
       =20
        	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
	  #ifndef CONFIG_SMP
        		cur_cpu_spec->cpu_features &=3D
~CPU_FTR_NEED_COHERENT;
	  #endif
        		return 1;	/* Looks good */
        	}
       =20
        	return 0;
        }

Specifically, which notion of multi-CPU-ness do
We want to honor here?

Thanks,
Jdl
