Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BADB62C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 05:42:39 +1100 (EST)
Message-ID: <1381948928.17841.38.camel@pasglop>
Subject: Re: Perf not resolving all symbols, showing 0x7ffffxxx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Hicks <mort@bork.org>
Date: Wed, 16 Oct 2013 13:42:08 -0500
In-Reply-To: <CAJUS3Xm6-Mojvu6WkZNT+31oDazcx5HCr3n0asNqv3+uFbO0JQ@mail.gmail.com>
References: <CAJUS3Xn4tHKvDK8tzLw09+zsEAJHEScV2DbZhH9KkYL-5iCmUA@mail.gmail.com>
 <CAJUS3X=LVHDMa+CTFS=O=F=DfU1=0cgcNzn-mEvXGaDXEZ+CBA@mail.gmail.com>
 <1381851009.17841.14.camel@pasglop>
 <CAJUS3XmN2WNJ1cnorb5vfas7mB6tdNLxuupFja=u_wYS=cxmdQ@mail.gmail.com>
 <1381866837.17841.21.camel@pasglop>
 <1381868527.7979.713.camel@snotra.buserror.net>
 <1381869590.17841.23.camel@pasglop>
 <CAJUS3Xm6-Mojvu6WkZNT+31oDazcx5HCr3n0asNqv3+uFbO0JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-16 at 11:05 -0400, Martin Hicks wrote:
> Actually, I was wrong, the mpc8379 is an e300c4.
> 
> So it seems clear to me that we compile in the book3s code because
> this is an 83xx CPU part.  I also see that Kconfig knows that I have
> an core-fsl-emb but we don't actually compile the PMU backend for it
> because there's no support for anything but e500.
> 
> mort@chinook:~/src/s4v2-glibc/linux-mpc$ grep PERF .config
> CONFIG_FSL_EMB_PERFMON=y
> CONFIG_PPC_PERF_CTRS=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> mort@chinook:~/src/s4v2-glibc/linux-mpc$ grep BOOK3S .config
> CONFIG_PPC_BOOK3S_32=y
> CONFIG_PPC_BOOK3S=y
> 
> more below...
> 
> On Tue, Oct 15, 2013 at 4:39 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2013-10-15 at 15:22 -0500, Scott Wood wrote:
> >> On Tue, 2013-10-15 at 14:53 -0500, Benjamin Herrenschmidt wrote:
> >> > On Tue, 2013-10-15 at 14:44 -0400, Martin Hicks wrote:
> >> > > >
> >> > > > This is an e300 core right ? (603...). Do that have an SIAR at all
> >> > > > (Scott ?)
> >> > >
> >> > > Yes, e300c3.
> >> >
> >> > Ok so I have a hard time figuring out how that patch can make a
> >> > difference since for all I can see, there is no perf backend upstream
> >> > for e300 at all :-(
> >> >
> >> > I must certainly be missing something ... Scott, can you have a look ?
> >>
> >> e300c3 has a core-fsl-emb style performance monitor (though Linux
> >> doesn't support it yet).  If a bug was bisected to a change in
> >> core-book3s.c, then it's probably a coincidence due to moving code
> >> around.
> 
> CONFIG_PPC_PERF_CTRS seems to give the mpc8379 some kind of basic
> performance measuring.  Is this through dummy_perf() in
> arch/powerpc/kernel/pmc.c?
> 
> >
> > Mort, can you see if just that change is enough to cause the problem ?
> 
> It is not.  The patch that does get IPs working again in my 3.11 tree
> is this one:
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index eeae308..9a3f572 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -122,10 +122,6 @@ void power_pmu_flush_branch_stack(void) {}
>  static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
>  #endif /* CONFIG_PPC32 */
> 
> -static bool regs_use_siar(struct pt_regs *regs)
> -{
> -       return !!regs->result;
> -}

Can you try instead just chaning regs_use_siar to return false always ?
Do that help ?

Cheers,
Ben.

>  /*
>   * Things that are specific to 64-bit implementations.
> @@ -1802,14 +1798,13 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
>   */
>  unsigned long perf_instruction_pointer(struct pt_regs *regs)
>  {
> -       bool use_siar = regs_use_siar(regs);
> -
> -       if (use_siar && siar_valid(regs))
> -               return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
> -       else if (use_siar)
> -               return 0;               // no valid instruction pointer
> -       else
> +       unsigned long mmcra = regs->dsisr;
> +       if (TRAP(regs) != 0xf00)
> +               return regs->nip;
> +       if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) &&
> +           !(mmcra & MMCRA_SAMPLE_ENABLE))
>                 return regs->nip;
> +       return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
>  }
> 
>  static bool pmc_overflow_power7(unsigned long val)
> 
> 
> mh
> 
