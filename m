Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17996.13115.456275.413478@cargo.ozlabs.ibm.com>
Date: Thu, 17 May 2007 20:49:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
In-Reply-To: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
References: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> diff --git a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/htashtable.S
> index e756942..fc30b6f 100644
> --- a/arch/ppc/mm/hashtable.S
> +++ b/arch/ppc/mm/hashtable.S

> @@ -461,9 +465,15 @@ found_slot:
>  	sync		/* make sure pte updates get to memory */
>  	blr
> 
> -	.comm	next_slot,4
> -	.comm	primary_pteg_full,4
> -	.comm	htab_hash_searches,4
> +	.section .bss
> +	.align	2
> +next_slot:
> +	.space	4
> +primary_pteg_full:
> +	.space	4
> +htab_hash_searches:
> +	.space	4
> +	.previous

I get this on an ARCH=ppc prep build:

arch/ppc/kernel/built-in.o: In function `__main':
arch/ppc/kernel/entry.S:(.text+0x2eda): undefined reference to `htab_hash_searches'
arch/ppc/kernel/entry.S:(.text+0x2ede): undefined reference to `htab_hash_searches'
arch/ppc/kernel/entry.S:(.text+0x2ee2): undefined reference to `primary_pteg_full'
arch/ppc/kernel/entry.S:(.text+0x2ee6): undefined reference to
`primary_pteg_full'

(The references are actually in arch/ppc/kernel/ppc_htab.c.)

I guess I'll cherry-pick the other commits from your tree, since I'm
making a string for Linus, unless you have a better suggestion.

Paul.
