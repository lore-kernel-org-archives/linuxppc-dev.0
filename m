Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5FA8267A71
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 10:40:29 +1100 (EST)
Date: Thu, 3 Mar 2005 15:40:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <20050303154013.4790be3b.akpm@osdl.org>
In-Reply-To: <16935.14471.919379.826792@alkaid.it.uu.se>
References: <16935.14471.919379.826792@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: geert@linux-m68k.org, linux-m68k@vger.kernel.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][2.6.11] gcc4 fix for <asm-m68k/setup.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikael Pettersson <mikpe@user.it.uu.se> wrote:
>
> gcc4 generates compile errors when it sees declarations
> of arrays of incomplete element types. <asm-m68k/setup.h>
> has one such declaration, which unfortunately breaks ppc32
> since <asm-ppc/setup.h> #includes <asm-m68k/setup.h>.
> 
> The fix in this case is to simply move the array declaration
> to after the corresponding element type declaration.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

Thanks, I'll merge that up.

> diff -rupN linux-2.6.11/include/asm-m68k/setup.h linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h
> --- linux-2.6.11/include/asm-m68k/setup.h	2004-12-25 12:16:22.000000000 +0100
> +++ linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h	2005-03-02 19:36:26.000000000 +0100
> @@ -362,12 +362,13 @@ extern int m68k_is040or060;
>  #ifndef __ASSEMBLY__
>  extern int m68k_num_memory;		/* # of memory blocks found (and used) */
>  extern int m68k_realnum_memory;		/* real # of memory blocks found */
> -extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
>  
>  struct mem_info {
>  	unsigned long addr;		/* physical address of memory chunk */
>  	unsigned long size;		/* length of memory chunk (in bytes) */
>  };
> +
> +extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
>  #endif
>  
>  #endif /* __KERNEL__ */
