Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGvVd4slZzDqm3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 20:24:24 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matt Brown' <matthew.brown.dev@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Date: Tue, 25 Jul 2017 10:24:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD003FBDF@AcuExch.aculab.com>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-2-matthew.brown.dev@gmail.com>
In-Reply-To: <20170725033320.17893-2-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Linuxppc-dev [mailto:linuxppc-dev-bounces+david.laight=3Daculab.com@l=
ists.ozlabs.org] On Behalf Of
> Matt Brown
> Sent: 25 July 2017 04:33
> To: linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulati=
on
>=20
> This adds emulations for the popcntb, popcntw, and popcntd instructions.
> Tested for correctness against the popcnt{b,w,d} instructions on ppc64le.
>=20
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> v3:
> 	- optimised using the Giles-Miller method of side-ways addition
> v2:
> 	- fixed opcodes
> 	- fixed typecasting
> 	- fixed bitshifting error for both 32 and 64bit arch
> ---
>  arch/powerpc/lib/sstep.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 87d277f..c1f9cdb 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -612,6 +612,32 @@ static nokprobe_inline void do_cmpb(struct pt_regs *=
regs, unsigned long v1,
>  	regs->gpr[rd] =3D out_val;
>  }
>=20
> +/*
> + * The size parameter is used to adjust the equivalent popcnt instructio=
n.
> + * popcntb =3D 8, popcntw =3D 32, popcntd =3D 64
> + */
> +static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned lon=
g v1,
> +				int size, int ra)
> +{
> +	unsigned long long out =3D v1;
> +
> +	out =3D (0x5555555555555555 & out) + (0x5555555555555555 & (out >> 1));
> +	out =3D (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
> +	out =3D (0x0f0f0f0f0f0f0f0f & out) + (0x0f0f0f0f0f0f0f0f & (out >> 4));
> +	if (size =3D=3D 8) {	/* popcntb */
> +		regs->gpr[ra] =3D out;

I'm pretty sure you need to mask the result with 7.

	David
