Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjfHd3NwCzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:47:25 +1000 (AEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjfHc2nszz9sCY
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:47:24 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] powerpc/kernel: Clean up some sparse warnings
Date: Mon, 04 Jul 2016 09:50:23 +0200
Message-ID: <5516741.DExtAhFdTo@wuerfel>
In-Reply-To: <1467616182-30886-4-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
 <1467616182-30886-4-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, July 4, 2016 5:09:40 PM CEST Daniel Axtens wrote:
> diff --git a/arch/powerpc/kernel/io.c b/arch/powerpc/kernel/io.c
> index 2a2b4aeab80f..3f70b7dccee8 100644
> --- a/arch/powerpc/kernel/io.c
> +++ b/arch/powerpc/kernel/io.c
> @@ -37,7 +37,7 @@ void _insb(const volatile u8 __iomem *port, void *buf, long count)
>  		return;
>  	asm volatile("sync");
>  	do {
> -		tmp = *port;
> +		tmp = *(u8 __force *)port;
>  		eieio();
>  		*tbuf++ = tmp;
>  	} while (--count != 0);

Here the "volatile" is actually meaningful, you should keep it and
just add "__force" in addition.

> @@ -47,13 +47,13 @@ EXPORT_SYMBOL(_insb);
>  
>  void _outsb(volatile u8 __iomem *port, const void *buf, long count)
>  {
> -	const u8 *tbuf = buf;
> +	const u8 __force *tbuf = buf;
>  
>  	if (unlikely(count <= 0))
>  		return;
>  	asm volatile("sync");
>  	do {
> -		*port = *tbuf++;
> +		*(volatile u8 __force *)port = *tbuf++;
>  	} while (--count != 0);
>  	asm volatile("sync");
>  }

like you correctly do here.

> @@ -68,7 +68,7 @@ void _insw_ns(const volatile u16 __iomem *port, void *buf, long count)
>  		return;
>  	asm volatile("sync");
>  	do {
> -		tmp = *port;
> +		tmp = *(u16 __force *)port;
>  		eieio();
>  		*tbuf++ = tmp;
>  	} while (--count != 0);

+volatile

> @@ -99,7 +99,7 @@ void _insl_ns(const volatile u32 __iomem *port, void *buf, long count)
>  		return;
>  	asm volatile("sync");
>  	do {
> -		tmp = *port;
> +		tmp = *(u32 __force *)port;
>  		eieio();
>  		*tbuf++ = tmp;
>  	} while (--count != 0);

+volatile


	Arnd
