Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id ED2B72C013B
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Aug 2013 15:06:20 +1000 (EST)
Date: Tue, 13 Aug 2013 15:06:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Avoid link stack corruption for MMU on exceptions
Message-Id: <20130813150617.dba639d38dad2ea41668c4d4@canb.auug.org.au>
In-Reply-To: <18522.1376360422@ale.ozlabs.ibm.com>
References: <18522.1376360422@ale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__13_Aug_2013_15_06_17_+1000_vLnwKyf=o.E4tvT0"
Cc: Paul Mackerras <paulus@samba.org>, anton@samba.org,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__13_Aug_2013_15_06_17_+1000_vLnwKyf=o.E4tvT0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mikey,

On Tue, 13 Aug 2013 12:20:22 +1000 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> @@ -101,14 +102,14 @@
>   * kernel, we need to use LR to get to the 2nd level handler.  So, save/=
restore
                             ^^
CTR

>   * it when required.
>   */
> -#define SAVE_LR(reg, area)	mflr	reg ; 	std	reg,area+EX_LR(r13)
> -#define GET_LR(reg, area) 			ld	reg,area+EX_LR(r13)
> -#define RESTORE_LR(reg, area)	ld	reg,area+EX_LR(r13) ; mtlr reg
> +#define SAVE_CTR(reg, area)	mfctr	reg ; 	std	reg,area+EX_CTR(r13)
> +#define GET_CTR(reg, area) 			ld	reg,area+EX_CTR(r13)
> +#define RESTORE_CTR(reg, area)	ld	reg,area+EX_CTR(r13) ; mtctr reg
>  #else
>  /* ...else LR is unused and in register. */
              ^^
and again

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__13_Aug_2013_15_06_17_+1000_vLnwKyf=o.E4tvT0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSCb7JAAoJEECxmPOUX5FEsckQAInhP/F61cUSY04OgrFIipqc
uF/AWwod9KRi1nH4c4gfVL0Ff+b/lOnJp4DIvdmz9R0xQ6mlyANvwQSUFaiVkLNk
wB0Wi1ZerL27uwUBFNMWkoihyliYIjL1t8kZPXZ/f798YbrL9Kb56rzABpprz8AO
L9mN8eddIdD1//QdtS2QhG/c9ZBFg6pNxRlLhF99HEq8RXlNnAIGuVbCmLC/uD4P
B2eAB9ivxIgnwc54kXwi9IfCcwCGlqgMGdapxtE+Z1g6tm63RO3OLG3igOkedRrb
61oyrB7a4Q9ILG+SN/a1XH1itmc0KkrOjh4Abne3LKO5tM98wUOgUEzfD1L9sryb
6XpZFk9H3kSFg0Zbu7oawa8V2rewl6BRFkwB02OKel+wo2AkEG2cGaPku6K09mOW
PRqRKBLVS5sCm0uoVCPLKfZ7SUF4m9DUZ/zyf6o7+I+VhkmD0rlYdIY0N6PLBiff
c9E5weJic8bl5gO+0bmdx8PjdHybatmw4FHznTJQ3XL41qf6VJgalauDzm4P3aJu
dbnQ3YdpiCXPNxZT2iZ65d5oPdi4R21i9oFFLpmq9wBHNBLm9mcjn2SNGPPrTdsr
OdlNwEfR+XsZw0MTU5LmHWRN+cMzFdq+h/YLCNnetkqOHCzARpV0/rpge4Ts/uF/
4Yh837BIFC8TI8Vc/88P
=RDpi
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Aug_2013_15_06_17_+1000_vLnwKyf=o.E4tvT0--
