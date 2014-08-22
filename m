Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E1F01A0128
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 01:29:48 +1000 (EST)
Date: Sat, 23 Aug 2014 01:29:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/4] powerpc: Move htab_remove_mapping function
 prototype into header file
Message-ID: <20140823012940.303e3ebc@canb.auug.org.au>
In-Reply-To: <1408488921-19187-4-git-send-email-anton@samba.org>
References: <1408488921-19187-1-git-send-email-anton@samba.org>
 <1408488921-19187-4-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CfQ_GlLeKUiSj91Mojnk+54"; protocol="application/pgp-signature"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/CfQ_GlLeKUiSj91Mojnk+54
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 20 Aug 2014 08:55:21 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> A recent patch added a function prototype for htab_remove_mapping in
> c code. Fix it.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h | 2 ++
>  arch/powerpc/mm/init_64.c             | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include=
/asm/mmu-hash64.h
> index d765144..92bc3a6 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -342,6 +342,8 @@ extern void hash_failure_debug(unsigned long ea, unsi=
gned long access,
>  extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
>  			     unsigned long pstart, unsigned long prot,
>  			     int psize, int ssize);
> +int htab_remove_mapping(unsigned long vstart, unsigned long vend,
> +			int psize, int ssize);

Please be consistent about "extern" use (unless this file is already
inconsistent, I guess).  (I know that the current trend is to remove
"extern" in header files - I just happen to disagree with that
trend. :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/CfQ_GlLeKUiSj91Mojnk+54
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJT92HpAAoJEMDTa8Ir7ZwVfZQP+wSjsAgZQO5B4xUdkjOUFIka
CP0YJGhZ+p221WfEWXtOGOaRC3b8KHreKwkylzpfrBwmf0JWntpIiZcqIzvnbmzQ
3uICy7nc1NSrsJ6EGjHAfMPPqOXusZ6iyKTgQ/FtIPl4Hgl1pdiLhsXezMLoJIyD
yXVr5VrSTm5pV1AG7tTlWFRQr7yvaoszL9X7oScWnqsMHjd3NHymrzfeCDZO0gLT
+mK2nE6bTIWNnf6/aGxHrgmfBdmeSgNcMDg0JU3u6kD/0/W3M168wESRAKU99dFz
8qZ61cFoTsKhGZ4g88fE43wnQeN1WXca2sxmLjbelO8/LgZHvPoqFs0BREPH+nfe
HVn0Kilpr8D3fQJXOVI9/JfRsvDRa90EGMmrnxDXbeiKNVGkTI5Wcs/wK6lsx7h9
1eetvv05cQvx0dvPmFheN3voaAmZO0kV3JiPngO7lhKuZojE3gdtUrnlSuJ8T/Lg
7nVfSTfA7iPycTV2v5Su+AL5iFnl9gSgB/5inXaQxgGoZ7c4HdUGUxIQ3jJDNKe6
sM1X2KEw1sUJBXzK7WYzqYKZ3s7fESQhUOMyBPP0Ov06Xisvwhx8n+mWpZt3AgJH
GetOQ9p/ajIc9j9FVeUfzgXUzZltxtYZz7LBYfmu2IlKpjyY9O4S2FLOIlsMEGxt
7sFVgH7h3Bf9g+vzpHX1
=G+Vr
-----END PGP SIGNATURE-----

--Sig_/CfQ_GlLeKUiSj91Mojnk+54--
