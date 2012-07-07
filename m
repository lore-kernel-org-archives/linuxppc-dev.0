Return-Path: <michael@ellerman.id.au>
Message-ID: <1341644121.30371.2.camel@concordia>
Subject: Re: [PATCH] powerpc: put the gpr sabe/restore functions in their
 own section
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 07 Jul 2012 16:55:21 +1000
In-Reply-To: <20120706170940.e3457b04a58ddd18d963c14a@canb.auug.org.au>
References: <20120706170940.e3457b04a58ddd18d963c14a@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-07-06 at 17:09 +1000, Stephen Rothwell wrote:
> This allows the linker to know that calls to them do not need to switch
> TOC and stop errors like the following when linking large configurations:

>  arch/powerpc/lib/crtsavres.S |    5 ++++-

You didn't make any change to the linker script? How does this section
get in there? I don't see a .text* anywhere?

> diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
> index 1c893f0..b2c68ce 100644
> --- a/arch/powerpc/lib/crtsavres.S
> +++ b/arch/powerpc/lib/crtsavres.S
> @@ -41,12 +41,13 @@
>  #include <asm/ppc_asm.h>
>  
>  	.file	"crtsavres.S"
> -	.section ".text"
>  
>  #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  
>  #ifndef CONFIG_PPC64
>  
> +	.section ".text"
> +
>  /* Routines for saving integer registers, called by the compiler.  */
>  /* Called with r11 pointing to the stack header word of the caller of the */
>  /* function, just beyond the end of the integer save area.  */
> @@ -232,6 +233,8 @@ _GLOBAL(_rest32gpr_31_x)
>  
>  #else /* CONFIG_PPC64 */
>  
> +	.section ".text.save.restore","ax",@progbits
> +
>  .globl	_savegpr0_14
>  _savegpr0_14:
>  	std	r14,-144(r1)

Any reason to not put the 32-bit versions in the same section? AFAICS
nothing in that file uses the TOC. 

cheers
