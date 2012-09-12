Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 7FF5E2C0086
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 21:07:11 +1000 (EST)
Date: Wed, 12 Sep 2012 21:07:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add an xmon command to dump one or all pacas
Message-Id: <20120912210704.54cc517b6f39c8e2f73523af@canb.auug.org.au>
In-Reply-To: <1347436360-29095-1-git-send-email-michael@ellerman.id.au>
References: <1347436360-29095-1-git-send-email-michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__12_Sep_2012_21_07_04_+1000_E11lZL_0D5_RV..U"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Sep_2012_21_07_04_+1000_E11lZL_0D5_RV..U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 12 Sep 2012 17:52:40 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> +#define DUMP(name, format) \
> +	printf(" %-*s =3D %#-*"format"\t(0x%lx)\n", 16, #name, 18, p->name, \
> +		(u64)((void *)&(p->name) - (void *)p));

I must say that I hate macros that reference (assumed) globals and
shouldn't you use offsetof(struct paca_struct, name) (from
linux/stddef.h)?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__12_Sep_2012_21_07_04_+1000_E11lZL_0D5_RV..U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQUGzYAAoJEECxmPOUX5FE+LQQAKnoKZRPVLexuNIZvdR1xre6
HCKc3RoUTgQYPE8zBeX7EyJYVE8kBY8RFhsWDM0ryA6lbThEgXSSb5oh1G0aylUy
VCLnyRh0fAwCxMdaSt6D7dg7Kt8ZQq8WiTvezj8xPzQnlPIDB2MC2MeBZm9QmvDU
2EEggUHTpzDJlY74jJgeydeDmgsVxILhXbDVMBytHQOhZHHWcJscQlhdxQYx7/GW
zO+kTfhRaEvPouc/ItowxKTjZiwb4bhVu6uDK4H/Hl1hnQ341LRScwgMede2AMvb
OLCwtHTo0JKIked9BcfaVAbBGq4gwZD5WGVl+DZqw6cj1Fa3NJf+7frp+LLVuZCG
J+CGE3MmQ9+QALKgcnQk4EIrFRvWVAkCHkX3nKpaxKyNPrXW4mfsDtZJfqZS6Z1k
YFg1V1zQwvAAP4Z+JeiTIunIiALGQ6+J5p/tZfVCHyhYX2AyFFwrQHnsIBLy1Rfu
u7OCKqh1uwOnBoRkkNvRPvKy+KFQt2YOCDlVhTCHATmGsIzKUvStg0ugomfN1tAT
HXsmwnElWALsfCJPPPpbaxcZKt8xwX5KjR+ojH6kEm5IbGsXk1PgyfQmpBWYirqh
9rKTPeCLXVmX+Y/jBZTtLXSZTgK9JnJGkuEbzcsxicJhvOkSo6GnwhCC1fubAqMP
08NUwFinZSHyiYhW5cJy
=gzNH
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Sep_2012_21_07_04_+1000_E11lZL_0D5_RV..U--
