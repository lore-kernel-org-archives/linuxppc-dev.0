Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070613045256.B35E1DDECA@ozlabs.org>
References: <20070613045256.B35E1DDECA@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A02128B3-41EE-47AA-802F-C0E3400411FB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/13] Remove a couple of unused definitions from
	pgtable_32.c
Date: Thu, 14 Jun 2007 16:04:08 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 12, 2007, at 11:52 PM, David Gibson wrote:

> In arch/powerpc/mm/pgtable_32.c, the varialbe io_bat_index and the
> macro is_power_of_4() no longer have any users.  This patch removes
> them.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>
>  arch/powerpc/mm/pgtable_32.c |    4 ----
>  1 file changed, 4 deletions(-)
>
> Index: working-2.6/arch/powerpc/mm/pgtable_32.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2007-05-10  
> 14:13:36.000000000 +1000
> +++ working-2.6/arch/powerpc/mm/pgtable_32.c	2007-05-10  
> 14:13:44.000000000 +1000
> @@ -36,7 +36,6 @@
>  unsigned long ioremap_base;
>  unsigned long ioremap_bot;
>  EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
> -int io_bat_index;
>
>  #if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
>  #define HAVE_BATS	1
> @@ -299,9 +298,6 @@ void __init mapin_ram(void)
>  	}
>  }
>
> -/* is x a power of 4? */
> -#define is_power_of_4(x)	is_power_of_2(x) && (ffs(x) & 1)
> -

is_power_of_4 is used by HAVE_TLBCAM, why are you killing it?

- k
