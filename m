Return-Path: <mpe@ellerman.id.au>
Date: Thu, 21 Nov 2013 22:55:03 +1100
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/9] powerpc: Add TIF_ELF2ABI flag.
Message-ID: <20131121115503.GD15913@concordia>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
 <1384946106-18200-4-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384946106-18200-4-git-send-email-anton@samba.org>
Cc: rusty@rustcorp.com.au, Ulrich.Weigand@de.ibm.com, paulus@samba.org,
 alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 10:15:00PM +1100, Anton Blanchard wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> Little endian ppc64 is getting an exciting new ABI.  This is reflected
> by the bottom two bits of e_flags in the ELF header:
> 
> 	0 == legacy binaries (v1 ABI)
> 	1 == binaries using the old ABI (compiled with a new toolchain)
> 	2 == binaries using the new ABI.

Just to be ridiculously clear for stupid people like me, you refer here
to the "v1 ABI" and "the old ABI" - they are the same thing - right?

> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index ba7b197..05a3030 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -107,6 +107,9 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
>  						for stack store? */
>  #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
> +#if defined(CONFIG_PPC64)
> +#define TIF_ELF2ABI		18	/* function descriptors must die! */
> +#endif

This is the first TIF flag we #ifdef for 32 vs 64, is that just because
we don't want to waste a flag on 32 bit?

cheers
