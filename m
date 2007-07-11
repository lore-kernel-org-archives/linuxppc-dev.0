Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id F2BC9DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 06:58:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH 3/8] 4xx MMU
Date: Wed, 11 Jul 2007 22:56:38 +0200
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162179.32199.58.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1184162179.32199.58.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707112256.38312.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 July 2007, Josh Boyer wrote:
> +#elif defined(CONFIG_40x)
> +/* 40x-style software loaded TLB */
> +# =A0include <asm/mmu-4xx.h>
> =A0#elif defined(CONFIG_44x)
> =A0/* 44x-style software loaded TLB */
> =A0# =A0include <asm/mmu-44x.h>

If you call it mmu-4xx, shouldn't it be used
for 44x as well? I would think this either
should be

> +#elif defined(CONFIG_4xx)
> +/* 40x-style software loaded TLB */
> +#  include <asm/mmu-4xx.h>
> -#elif defined(CONFIG_44x)
> -/* 44x-style software loaded TLB */
> -#  include <asm/mmu-44x.h>

or=20

> +#elif defined(CONFIG_40x)
> +/* 40x-style software loaded TLB */
> +#  include <asm/mmu-40x.h>
>  #elif defined(CONFIG_44x)
>  /* 44x-style software loaded TLB */
>  #  include <asm/mmu-44x.h>

Is it actually feasible to get to a point where
you can build a kernel that boots on both
40x and 44x, or is it just too different?

	Arnd <><
