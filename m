Message-ID: <38754508.976B932F@ctam.com.au>
Date: Fri, 07 Jan 2000 12:44:41 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        glibc-linux <glibc-linux@ricardo.ecn.wfu.edu>
Subject: Re: MPC860 patches for glibc
References: <20000105233607.0D48DED@elph.research.canon.com.au> <otg0wb8hk8.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Would the changes suggested below, to the cache line size (mpc8xx = 16 bytes, others = 32 bytes) make any difference
if my Instruction Cache and Data Cache was disabled.  My current linux kernel has them all disabled for now.

Brendan Simon.



Jesper Skov wrote:

> >>>>> "Graham" == Graham Stoney <greyham@research.canon.com.au> writes:
>
> Graham> Brendan J Simon writes:
> >> I didn't realise there were 860 patches for glibc.  Where can I get
> >> these patches from ?
>
> Graham> The magic mailing list archive, of course (-:
>
> Graham> http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html
>
> >> What do they do ?
>
> Graham> Fix the cache line size for dynamic loading, and rearrange the
> Graham> FPU stuff so it doesn't get included when you build.
>
> I think the below patch for dl-machine.c would be better. It incurs no
> loop overhead on the 32-byte cache line CPUs - and I think the double
> flush of the same line should be harmless (and cheaper than the loop
> overhead).
>
> There is one small potential for error; if the macro is called with a
> (32-byte aligned pointer)+16/17/18...31 in which case the first 16
> bytes (of the 32-byte aligned address) would not be flushed on a 8xx,
> while they would be on a bigger CPU. (did that make any sense at all ;)
>
> Comments? Is it as safe/sensible as I think it is?
>
> Thanks,
> Jesper
>
> --- powerpc/dl-machine.c~       Fri Mar  5 00:26:43 1999
> +++ powerpc/dl-machine.c        Thu Jan  6 14:09:34 2000
> @@ -63,10 +63,17 @@
>  #define OPCODE_SLWI(ra,rs,sh) OPCODE_RLWINM(ra,rs,sh,0,31-sh)
>
>
> -#define PPC_DCBST(where) asm ("dcbst 0,%0" : : "r"(where) : "memory")
> +/* The macros dealing with cache lines affect both (where) and
> +   (where+16).  This is in order to support the 8xx CPUs which have
> +   16-byte cache lines.  On the CPUs with 32-byte cache lines this
> +   should have no noticable effect as the first store instruction
> +   would effectively make the second instruction a NOP (since the line
> +   would no longer be dirty). */
> +#define PPC_DCBST(where) asm ("dcbst 0,%0;dcbst 0,%1" : : "r"(where), "r"((unsigned long)(where)+16) : "memory")
> +#define PPC_ICBI(where) asm ("icbi 0,%0;icbi 0,%1" : : "r"(where), "r"((unsigned long)(where)+16) : "memory")
> +
>  #define PPC_SYNC asm ("sync" : : : "memory")
>  #define PPC_ISYNC asm volatile ("sync; isync" : : : "memory")
> -#define PPC_ICBI(where) asm ("icbi 0,%0" : : "r"(where) : "memory")
>  #define PPC_DIE asm volatile ("tweq 0,0")
>
>  /* Use this when you've modified some code, but it won't be in the


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
