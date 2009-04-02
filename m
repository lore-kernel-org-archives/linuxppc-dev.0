Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2E08DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 15:26:09 +1100 (EST)
Subject: Re: Problem with module_init?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090402000803.087600da@lappy.seanm.ca>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
	<20090331231153.256d1bf4@lappy.seanm.ca>
	<20090401112756.GA14171@yoda.jdub.homelinux.org>
	<1238624683.17330.138.camel@pasglop>
	<20090402000803.087600da@lappy.seanm.ca>
Content-Type: text/plain
Date: Thu, 02 Apr 2009 15:26:02 +1100
Message-Id: <1238646362.17330.186.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-02 at 00:08 -0400, Sean MacLennan wrote:
> On Thu, 02 Apr 2009 09:24:43 +1100
> "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> 
> > I suspect I just screwed up the definition of PAGE_KERNEL_EXEC or
> > something like that.
> 
> Yup, that is exactly what you did ;) You left out _PAGE_HWEXEC. The
> following patch fixes the problem for me.

The proper fix is for PAGE_KERNEL_X to have _PAGE_HWEXEC. I'll fix that.

Cheers,
Ben.

> Cheers,
>    Sean
> 
> diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
> index d9740e8..a84f248 100644
> --- a/arch/powerpc/include/asm/pte-common.h
> +++ b/arch/powerpc/include/asm/pte-common.h
> @@ -167,7 +167,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
>  #endif
>  
>  /* Make modules code happy. We don't set RO yet */
> -#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
> +// #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
> +#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC | _PAGE_HWEXEC)
>  
>  /* Advertise special mapping type for AGP */
>  #define PAGE_AGP		(PAGE_KERNEL_NC)
