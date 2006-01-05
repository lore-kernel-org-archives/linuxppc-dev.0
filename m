Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id A95256898B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 02:05:51 +1100 (EST)
Date: Thu, 5 Jan 2006 08:05:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Janzen <pcj@linux.sez.to>
Message-ID: <20060105150548.GC27215@smtp.west.cox.net>
References: <oqbqyrp6zj.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <oqbqyrp6zj.fsf@merlin.sez.to>
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] boot/common/util.S: Put flush_{instruction,
	data}_cache back in .relocate_code section
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2006 at 09:40:48PM -0800, Paul Janzen wrote:

> In 2.6.14, we had the following definition of _GLOBAL() in
> include/asm-ppc/processor.h:
> 
> #define _GLOBAL(n)\
>         .stabs __stringify(n:F-1),N_FUN,0,0,n;\
>         .globl n;\
> n:
> 
> In 2.6.15, as part of the great powerpc merge, we moved this definition to
> include/asm-powerpc/ppc_asm.h, where it appears (to 32-bit code) as: 
> 
> #define _GLOBAL(n)      \
>         .text;          \
>         .stabs __stringify(n:F-1),N_FUN,0,0,n;\
>         .globl n;       \
> n:
> 
> Mostly, this is fine.  However, we also have the following, in
> arch/ppc/boot/common/util.S:
> 
>         .section ".relocate_code","xa"
> [...]
> _GLOBAL(flush_instruction_cache)
> [...]
> _GLOBAL(flush_data_cache)
> [...]
> 
> The addition of the .text section definition in the definition of
> _GLOBAL overrides the .relocate_code section definition.  As a result,
> these two functions don't end up in .relocate_code, so they don't get
> relocated correctly, and the boot fails.
> 
> There's another suspicious-looking usage at kernel/swsusp.S:37 that
> someone should look into.  I did not exhaustively search the source
> tree, though.
> 
> The following is the minimal patch that fixes the immediate problem.
> I could easily be convinced that the _GLOBAL definition should be
> modified to remove the ".text;" line either instead of, or in addition
> to, this fix.
> 
> Signed-off-by: Paul Janzen <pcj@linux.sez.to>

Thanks for tracking this one down.  Paul, can you please make sure this
gets to Linus and the stable team?  Thanks.

Acked-by: Tom Rini <trini@kernel.crashing.org>

> --- arch/ppc/boot/common/util.S~	2005-12-24 15:47:48.000000000 -0800
> +++ arch/ppc/boot/common/util.S 	2006-01-04 14:07:12.000000000 -0800
> @@ -234,7 +234,8 @@ udelay:
>   * First, flush the data cache in case it was enabled and may be
>   * holding instructions for copy back.
>   */
> -_GLOBAL(flush_instruction_cache)
> +        .globl flush_instruction_cache
> +flush_instruction_cache:        
>  	mflr	r6
>  	bl	flush_data_cache
>  
> @@ -279,7 +280,8 @@ _GLOBAL(flush_instruction_cache)
>   * Flush data cache
>   * Do this by just reading lots of stuff into the cache.
>   */
> -_GLOBAL(flush_data_cache)
> +        .globl flush_data_cache
> +flush_data_cache:       
>  	lis	r3,cache_flush_buffer@h
>  	ori	r3,r3,cache_flush_buffer@l
>  	li	r4,NUM_CACHE_LINES
> 
> -- Paul

-- 
Tom Rini
http://gate.crashing.org/~trini/
