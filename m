Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjmrp60F4zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 10:44:10 +1000 (AEST)
Message-ID: <1496882650.31524.14.camel@neuling.org>
Subject: Re: [PATCH] powernv: Properly mask POWER9 DD1 PVR for different
 chip types
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Date: Thu, 08 Jun 2017 10:44:10 +1000
In-Reply-To: <87efuwp8ef.fsf@concordia.ellerman.id.au>
References: <20170607041145.3581-1-mikey@neuling.org>
 <87efuwp8ef.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-07 at 17:24 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
>=20
> > Bits 48:51 in the PVR for POWER9 represent different chip types (scale
> > up vs out and 12 vs 24 core). Current chips have 0 here, but could be
> > non-zero in the future.
> >=20
> > This changes the POWER9 DD1 mask to correctly ignore these bits 48:51.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > =C2=A0arch/powerpc/kernel/cputable.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Presumably we should backport this?

Actually, we need to scrap this patch.

Looks like the scale up version will be marked as DD1, but it won't need th=
ese
workarounds. So we need it to match on the other POWER9 entry.

Mikey

>=20
> cheers
>=20
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputa=
ble.c
> > index 9b3e88b1a9..89dcd94237 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -526,8 +526,8 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
> > =C2=A0		.machine_check_early	=3D
> > __machine_check_early_realmode_p8,
> > =C2=A0		.platform		=3D "power8",
> > =C2=A0	},
> > -	{	/* Power9 DD1*/
> > -		.pvr_mask		=3D 0xffffff00,
> > +	{	/* Power9 DD1. Bits 48:51 represent chip type so mask
> > these */
> > +		.pvr_mask		=3D 0xffff0f00,
> > =C2=A0		.pvr_value		=3D 0x004e0100,
> > =C2=A0		.cpu_name		=3D "POWER9 (raw)",
> > =C2=A0		.cpu_features		=3D CPU_FTRS_POWER9_DD1,
> > --=C2=A0
> > 2.11.0
>=20
>=20
