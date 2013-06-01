Return-Path: <michael@ellerman.id.au>
Date: Sun, 2 Jun 2013 01:13:28 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/pseries: Kill all prefetch streams on context
 switch
Message-ID: <20130601151327.GA27644@concordia>
References: <17925.1369892067@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17925.1369892067@ale.ozlabs.ibm.com>
Cc: anton@samba.org, miltonm@realtime.net,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 30, 2013 at 03:34:27PM +1000, Michael Neuling wrote:
> On context switch, we should have no prefetch streams leak from one
> userspace process to another.  This frees up prefetch resources for the
> next process.
> 
> Based on patch from Milton Miller.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index cea8496..2f1b6c5 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -523,6 +523,17 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
>  #define PPC440EP_ERR42
>  #endif
>  
> +/* The following stops all load and store data streams associated with stream
> + * ID (ie. streams created explicitly).  The embedded and server mnemonics for
> + * dcbt are different so we use machine "power4" here explicitly.
> + */
> +#define DCBT_STOP_ALL_STREAM_IDS(scratch)	\
> +.machine push ;					\
> +.machine "power4" ;				\
> +       lis     scratch,0x60000000@h;		\
> +       dcbt    r0,scratch,0b01010;		\
> +.machine pop

I don't see why we need the macro, ie. just stick this code in
entry_64.S directly.

cheers
