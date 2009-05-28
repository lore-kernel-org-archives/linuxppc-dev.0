Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8B01DDEFA
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 02:13:50 +1000 (EST)
In-Reply-To: <1243454441.3489.1@antares>
References: <1243454441.3489.1@antares>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Message-ID: <OF508468F5.9BFFC168-ONC12575C4.005846FD-C12575C4.00592585@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 28 May 2009 18:13:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>
> This trivial patch changes memcpy_(to|from)io as to transfer as many
> 32-bit words as possible in 32-bit accesses (in the current solution,=

> the last 32-bit word was transferred as 4 byte accesses).
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> ---
>
> diff -urpN -X linux-2.6.29.1.orig/Documentation/dontdiff
> linux-2.6.29.1.orig/arch/powerpc/kernel/io.c
> linux-2.6.29.1/arch/powerpc/kernel/io.c
> --- linux-2.6.29.1.orig/arch/powerpc/kernel/io.c   2009-04-02
> 22:55:27.000000000 +0200
> +++ linux-2.6.29.1/arch/powerpc/kernel/io.c   2009-05-27
> 11:36:09.000000000 +0200
> @@ -161,7 +161,7 @@ void _memcpy_fromio(void *dest, const vo
>         dest++;
>         n--;
>      }
> -   while(n > 4) {
> +   while(n >=3D 4) {
>         *((u32 *)dest) =3D *((volatile u32 *)vsrc);
>         eieio();
>         vsrc +=3D 4;
> @@ -190,7 +190,7 @@ void _memcpy_toio(volatile void __iomem
>         vdest++;
>         n--;
>      }
> -   while(n > 4) {
> +   while(n >=3D 4) {
>         *((volatile u32 *)vdest) =3D *((volatile u32 *)src);
>         src +=3D 4;
>         vdest +=3D 4;

hmm, these do look a bit unoptimal anyway. Any reason not to write
them something like below(written by me for uClibc long time ago). You =
will
have to add eieio()/sync

void *memcpy(void *to, const void *from, size_t n)
/* PPC can do pre increment and load/store, but not post increment and =
load/store.
   Therefore use *++ptr instead of *ptr++. */
{
	unsigned long rem, chunks, tmp1, tmp2;
	unsigned char *tmp_to;
	unsigned char *tmp_from =3D (unsigned char *)from;

	chunks =3D n / 8;
	tmp_from -=3D 4;
	tmp_to =3D to - 4;
	if (!chunks)
		goto lessthan8;
	rem =3D (unsigned long )tmp_to % 4;
	if (rem)
		goto align;
 copy_chunks:
	do {
		/* make gcc to load all data, then store it */
		tmp1 =3D *(unsigned long *)(tmp_from+4);
		tmp_from +=3D 8;
		tmp2 =3D *(unsigned long *)tmp_from;
		*(unsigned long *)(tmp_to+4) =3D tmp1;
		tmp_to +=3D 8;
		*(unsigned long *)tmp_to =3D tmp2;
	} while (--chunks);
 lessthan8:
	n =3D n % 8;
	if (n >=3D 4) {
		*(unsigned long *)(tmp_to+4) =3D *(unsigned long *)(tmp_from+4);
		tmp_from +=3D 4;
		tmp_to +=3D 4;
		n =3D n-4;
	}
	if (!n ) return to;
	tmp_from +=3D 3;
	tmp_to +=3D 3;
	do {
		*++tmp_to =3D *++tmp_from;
	} while (--n);

	return to;
 align:
	rem =3D 4 - rem;
	n =3D n - rem;
	do {
		*(tmp_to+4) =3D *(tmp_from+4);
		++tmp_from;
		++tmp_to;
	} while (--rem);
	chunks =3D n / 8;
	if (chunks)
		goto copy_chunks;
	goto lessthan8;
}=
