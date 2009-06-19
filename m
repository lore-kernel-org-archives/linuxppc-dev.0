Return-Path: <lorenz@missinglinkelectronics.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C5CB2B71DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 04:42:54 +1000 (EST)
Received: from smtp.esic-solutions.com (h1371364.stratoserver.net
	[85.214.87.145]) by ozlabs.org (Postfix) with ESMTP id 591C9DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 04:42:54 +1000 (EST)
Message-ID: <4A3BDC19.7060704@missinglinkelectronics.com>
Date: Fri, 19 Jun 2009 20:42:33 +0200
From: Lorenz Kolb <lorenz@missinglinkelectronics.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
References: <1243454441.3489.1@antares>
In-Reply-To: <1243454441.3489.1@antares>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Albrecht Dreﬂ wrote:
> This trivial patch changes memcpy_(to|from)io as to transfer as many 
> 32-bit words as possible in 32-bit accesses (in the current solution, 
> the last 32-bit word was transferred as 4 byte accesses).
> 
> Signed-off-by: Albrecht Dreﬂ <albrecht.dress@arcor.de>
> ---
> 
> diff -urpN -X linux-2.6.29.1.orig/Documentation/dontdiff 
> linux-2.6.29.1.orig/arch/powerpc/kernel/io.c 
> linux-2.6.29.1/arch/powerpc/kernel/io.c
> --- linux-2.6.29.1.orig/arch/powerpc/kernel/io.c    2009-04-02 
> 22:55:27.000000000 +0200
> +++ linux-2.6.29.1/arch/powerpc/kernel/io.c    2009-05-27 
> 11:36:09.000000000 +0200
> @@ -161,7 +161,7 @@ void _memcpy_fromio(void *dest, const vo
>          dest++;
>          n--;
>      }
> -    while(n > 4) {
> +    while(n >= 4) {
>          *((u32 *)dest) = *((volatile u32 *)vsrc);
>          eieio();
>          vsrc += 4;
> @@ -190,7 +190,7 @@ void _memcpy_toio(volatile void __iomem
>          vdest++;
>          n--;
>      }
> -    while(n > 4) {
> +    while(n >= 4) {
>          *((volatile u32 *)vdest) = *((volatile u32 *)src);
>          src += 4;
>          vdest += 4;
> 
> 
> ------------------------------------------------------------------------

Works for me (and some custom hardware I created [quite a while ago, 
when I was young ;-)] that is not very tolerant to Byte-by-Byte-Transfers).

Thus:
Acked
