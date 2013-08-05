Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 30B052C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 18:42:14 +1000 (EST)
Date: Mon, 5 Aug 2013 18:42:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/3] powerpc: Correctly context switch DSCR on POWER8
Message-Id: <20130805184205.79cafb9ac299313228ec53cc@canb.auug.org.au>
In-Reply-To: <1375687686-5633-3-git-send-email-mikey@neuling.org>
References: <1375687686-5633-1-git-send-email-mikey@neuling.org>
 <1375687686-5633-3-git-send-email-mikey@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__5_Aug_2013_18_42_05_+1000_lg8kfhjqcNG7G2eq"
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__5_Aug_2013_18_42_05_+1000_lg8kfhjqcNG7G2eq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[This time from a good email address :-)]

Hi Mikey,

On Mon,  5 Aug 2013 17:28:06 +1000 Michael Neuling
<mikey@neuling.org> wrote:
>
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1296,43 +1294,56 @@ void vsx_unavailable_exception(struct pt_regs *re=
gs)
>  	die("Unrecoverable VSX Unavailable Exception", regs, SIGABRT);
>  }
> =20
> +#ifdef CONFIG_PPC64
>  void facility_unavailable_exception(struct pt_regs *regs)
>  {
>  	static char *facility_strings[] =3D {
> -		"FPU",
> -		"VMX/VSX",
> -		"DSCR",
> -		"PMU SPRs",
> -		"BHRB",
> -		"TM",
> -		"AT",
> -		"EBB",
> -		"TAR",
> +		[FSCR_FP_LG] =3D "FPU",
> +		[FSCR_VECVSX_LG] =3D "VMX/VSX",
> +		[FSCR_DSCR_LG] =3D "DSCR",
> +		[FSCR_PM_LG] =3D "PMU SPRs",
> +		[FSCR_BHRB_LG] =3D "BHRB",
> +		[FSCR_TM_LG] =3D "TM",
> +		[FSCR_EBB_LG] =3D "EBB",
> +		[FSCR_TAR_LG] =3D "TAR",

I assume that you intentionally dropped "AT".

>  	};
> -	char *facility, *prefix;
> +	char *facility;
>  	u64 value;
> +	u8 status;
> +	bool hv;
> =20
>  	if (regs->trap =3D=3D 0xf60) {
>  		value =3D mfspr(SPRN_FSCR);
> -		prefix =3D "";
> +		hv =3D false;
>  	} else {
>  		value =3D mfspr(SPRN_HFSCR);
> -		prefix =3D "Hypervisor ";
> +		hv =3D true;
>  	}

Maybe:
	hv =3D regs->trap =3D=3D 0xf60;
	if (hv)
		value =3D mfspr(SPRN_HFSCR);
	else
		value =3D mfspr(SPRN_HFSCR);
or
	value =3D mfspr(hv ? SPRN_HFSCR : SPRN_HFSCR);

> -	value =3D value >> 56;
> +	status =3D value >> 56;
> +
> +	if (status < ARRAY_SIZE(facility_strings))
> +		facility =3D facility_strings[status];
> +	else
> +		facility =3D "unknown";

For entries in the array that are not set, this will give facility =3D=3D
NULL.  Is that what you intended?

>  	pr_err("%sFacility '%s' unavailable, exception at 0x%lx, MSR=3D%lx\n",
> -		prefix, facility, regs->nip, regs->msr);
> +	       hv ? "Hypervisor ":"", facility, regs->nip, regs->msr);

... and this may attempt to print a NULL pointer with %s.  Also please
put spaces around the : .

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__5_Aug_2013_18_42_05_+1000_lg8kfhjqcNG7G2eq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR/2ViAAoJEECxmPOUX5FESBsP/2RNjF3LtiOI0fcTX832bTHE
WpDYGG7d3Yv2CaHVRuB/FW4/OKPFX5Nsszc6DMJJSd8+X57AM6b9+qVgDDE8JwAF
SIU1aRSNSFdhwofqUnLef574mFZmozKtWTtmZZgxoKvMVPra8GbiPsLLkaFjG3xC
UAD95gCivBsRp3y3weWz9vwsojZ6tQicYCDMzz8JuN7oM3hrxgmm2yCTlvfnoqBq
SblMR4cIKHM8qu179dYchEdUuBDXQwrMJT8/ihIkoh53dPFnTT2WB0TmG9OmSzwl
9o9fcRCnnTpb6Wh4oBTIbteaK3JAtBkTGrr7/bXdLKq7AhaW2gFCxcWyww26h6yx
Et8dxXGu4CUYqG2sokfRRP+Tykz8grbUk4CK3DlCORGLCqSUxH08VHfkfZjAJBjr
U1Kp5dUnAUnhmtu4lfTY9iosSnGZtyGKca5r0wO6LYnnF2PBaNohvZlQaT0w9OC8
E0VizkJsvBtgd/LST1gBkJ6dV2Q9ayoeDRD8UROQMKAn7RpUXoJF/9Aj2Rhysyqh
XjdIf0m+dZdTym0E7XAZ/b3/qSeYLLzbOn4mI3rTGkFACzxHU3hZ7bPRe5m6V8Me
y49iRIkBCqla/i9nsG3XKhlFH+QUt086UTT5UU2VSeyWdzAnJcexYAretT8LLljO
frRjqsNE0wqWeT/aI+kX
=LchW
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Aug_2013_18_42_05_+1000_lg8kfhjqcNG7G2eq--
