Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5142CDDEA3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 18:14:07 +1000 (EST)
Date: Fri, 17 Aug 2007 18:13:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Stop include asm-ppc when building
	ARCH=powerpc for ppc32
Message-Id: <20070817181352.d29117be.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0708170215360.15311@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170215360.15311@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__17_Aug_2007_18_13_52_+1000_BWfAMsWX4OmamWoV"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__17_Aug_2007_18_13_52_+1000_BWfAMsWX4OmamWoV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Aug 2007 02:15:54 -0500 (CDT) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> @@ -172,18 +168,15 @@ install:
>  archclean:
>  	$(Q)$(MAKE) $(clean)=3D$(boot)
>=20
> -archmrproper:
> -	$(Q)rm -rf arch/$(ARCH)/include
> -
>  archprepare: checkbin
>=20
> -ifeq ($(CONFIG_PPC32),y)
> -# Temporary hack until we have migrated to asm-powerpc
> -include/asm: arch/$(ARCH)/include/asm
> -arch/$(ARCH)/include/asm: FORCE
> -	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/includ=
e; fi
> -	$(Q)ln -fsn $(srctree)/include/asm-$(OLDARCH) arch/$(ARCH)/include/asm
> -endif
> +#ifeq ($(CONFIG_PPC32),y)
> +## Temporary hack until we have migrated to asm-powerpc
> +#include/asm: arch/$(ARCH)/include/asm
> +#arch/$(ARCH)/include/asm: FORCE
> +#	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/inclu=
de; fi
> +#	$(Q)ln -fsn $(srctree)/include/asm-$(OLDARCH) arch/$(ARCH)/include/asm
> +#endif

Why not just remove it?  git will preserve it if we find a use for it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Aug_2007_18_13_52_+1000_BWfAMsWX4OmamWoV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxVjFTgG2atn1QN8RAjS4AJ96KH0nasiDoxs0Qb5uKy2QHutkmwCfR+l3
CkDIS5pZW07nUiOItfAkds8=
=VBuv
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Aug_2007_18_13_52_+1000_BWfAMsWX4OmamWoV--
