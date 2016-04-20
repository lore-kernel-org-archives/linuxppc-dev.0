Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqfhS5lTSzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 21:26:00 +1000 (AEST)
Message-ID: <1461151559.2643.65.camel@neuling.org>
Subject: Re: [V2, 68/68] powerpc/mm/radix: Use firmware feature to disable
 radix
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, Stewart Smith <sesmith@au1.ibm.com>,
 oliveroh <oliveroh@au1.ibm.com>
Date: Wed, 20 Apr 2016 21:25:59 +1000
In-Reply-To: <3qqRSV5jq0z9sRB@ozlabs.org>
References: <3qqRSV5jq0z9sRB@ozlabs.org>
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

On Wed, 2016-04-20 at 12:59 +1000, Michael Ellerman wrote:

> On Sat, 2016-09-04 at 06:14:04 UTC, "Aneesh Kumar K.V" wrote:

> > We can depend on ibm,pa-features to enable/disable radix. This gives us
> > a nice way to test p9 hash config, by changing device tree property.
>=20
> I think we might want to be more careful here.
>=20
> You set MMU_FTR_RADIX in the cputable entry. So it's on by default on P9 =
cpus.
>=20
> Then if there is an ibm,pa-features property *and* it is >=3D 41 bytes lo=
ng, the
> below feature entry will hit. In that case the firmware controls whether =
it's on
> or off.
>=20
> I think it would be clearer if we removed RADIX from the cputable, and th=
e below
> became the only way to turn it on. Would that break anything?

I don't think it'll break anything.  FWIW I'm good with this approach.

We'll need to teach firmware about this feature, but I think we should
do that anyway.  skiboot is a bit of a mess WRT to this property with
HDAT vs device tree, but we can clean that up there.

Mikey


>=20

> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index 7030b035905d..a4d1f44364b8 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -165,6 +165,7 @@ static struct ibm_pa_feature {
> >  	 * which is 0 if the kernel doesn't support TM.
> >  	 */
> >  	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
> > +	{0, MMU_FTR_RADIX, 0,		40, 0, 0},
>=20
> So that says bit 0 of byte 40 enables MMU_FTR_RADIX. Where is that docume=
nted?
>=20
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
