Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C07C2B7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 20:07:21 +1000 (EST)
Subject: Re: [PATCH] Re: [405EX] Bad page map in process ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
In-Reply-To: <CE92B8B581B4584FB8CA86B51EDE8AC5243C568B04@wupexchange.riedel.net>
References: <CE92B8B581B4584FB8CA86B51EDE8AC5243C568B04@wupexchange.riedel.net>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 20:07:15 +1000
Message-Id: <1253614035.7103.223.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-22 at 11:29 +0200, Weirich, Bernhard wrote:
> Hello,
> 
> I found the cause of the problem.
> My architecture does not define the _PAGE_SPECIAL macro, thus in pte-common.h line 32, it is defined as 0
> And then in line 180, since _PAGE_SPECIAL is defined, the macro __HAVE_ARCH_PTE_SPECIAL is erroneously defined.
> This makes any ppc architecture to act as if it has a pte special bit!
> I suggest the following simple patch to fix this.

Thank ! That looks indeed like a bug.

Note that with 2.6.32, we should be able to use 0x20 as _PAGE_SPECIAL on
40x which would improve performances in some areas.

Cheers,
Ben.

> Bernhard WEIRICH
> Software Development
> 
> 
> Signed-off-by: Bernhard Weirich <bernhard.weirich@riedel.net>
> --- linux/arch/powerpc/include/asm/pte-common.h	2009-09-16 11:23:44.000000000 +0200
> +++ linux/arch/powerpc/include/asm/pte-common.h	2009-09-22 11:13:08.000000000 +0200
> @@ -176,7 +176,7 @@
>  #define HAVE_PAGE_AGP
>  
>  /* Advertise support for _PAGE_SPECIAL */
> -#ifdef _PAGE_SPECIAL
> +#if _PAGE_SPECIAL != 0
>  #define __HAVE_ARCH_PTE_SPECIAL
>  #endif
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
