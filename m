Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0227DB6F84
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 03:04:27 +1100 (EST)
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111125163557.5a464006@kryten>
Date: Mon, 28 Nov 2011 10:04:18 -0600
Message-Id: <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
References: <20111125163557.5a464006@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 24, 2011, at 11:35 PM, Anton Blanchard wrote:

>=20
> On a 64bit book3s machine I have an oops from a system reset that
> claims the book3e CE bit was set:
>=20
> MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 24004082  XER: 00000010
>=20
> On a book3s machine system reset sets IBM bit 46 and 47 depending on
> the power saving mode. Separate the definitions by type and for
> completeness add the rest of the bits in.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> Index: linux-build/arch/powerpc/kernel/process.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-build.orig/arch/powerpc/kernel/process.c	2011-11-25 =
13:22:24.294919094 +1100
> +++ linux-build/arch/powerpc/kernel/process.c	2011-11-25 =
13:36:23.213834524 +1100
> @@ -584,16 +584,32 @@ static struct regbit {
> 	unsigned long bit;
> 	const char *name;
> } msr_bits[] =3D {
> +#if defined(CONFIG_PPC64) && !defined(CONFIG_BOOKE)
> +	{MSR_SF,	"SF"},
> +	{MSR_HV,	"HV"},
> +#endif
> +	{MSR_VEC,	"VEC"},
> +	{MSR_VSX,	"VSX"},
> +#ifdef CONFIG_BOOKE
> +	{MSR_CE,	"CE"},
> +#endif
> 	{MSR_EE,	"EE"},
> 	{MSR_PR,	"PR"},
> 	{MSR_FP,	"FP"},
> -	{MSR_VEC,	"VEC"},
> -	{MSR_VSX,	"VSX"},
> 	{MSR_ME,	"ME"},
> -	{MSR_CE,	"CE"},
> +#ifdef CONFIG_BOOKE
> 	{MSR_DE,	"DE"},
> +#else
> +	{MSR_SE,	"SE"},
> +	{MSR_BE,	"BE"},
> +#endif
> 	{MSR_IR,	"IR"},
> 	{MSR_DR,	"DR"},
> +	{MSR_PMM,	"PMM"},
> +#ifndef CONFIG_BOOKE
> +	{MSR_RI,	"RI"},

We have 'RI' on some BOOKE so lets allow for it to be decoded

> +	{MSR_LE,	"LE"},
> +#endif
> 	{0,		NULL}
> };

Since you're fixing this can you add the following for CONFIG_BOOKE:

MSR_GS, MSR_UCLE, MSR_PMM, MSR_CM

- k=
