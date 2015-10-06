Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5AD1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 17:26:20 +1100 (AEDT)
Message-ID: <1444112779.16578.4.camel@ellerman.id.au>
Subject: Re: [PATCH 4/5] kernel/cpu.c: eliminate cpu_*_mask
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Oct 2015 17:26:19 +1100
In-Reply-To: <87612k9ak2.fsf@rasmusvillemoes.dk>
References: <1443205347-13634-5-git-send-email-linux@rasmusvillemoes.dk>
 <201509281303.5hjLVTJZ%fengguang.wu@intel.com>
 <87oagnf3ok.fsf@rasmusvillemoes.dk> <87612k9ak2.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-06 at 01:10 +0200, Rasmus Villemoes wrote:
> Hi PPC maintainers
> 
> Can I get you to ack or nak this? It's a prerequisite for a minor
> patch series for kernel/cpu.c and include/linux/cpumask.h of mine.

Yeah fine by me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> On Mon, Sep 28 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > Gah, I didn't check for struct members called cpu_online_mask :(
> >
> > PPC people: The issue is that I changed cpu_online_mask (and friends)
> > from being "const struct cpumask *const" exported variables to macros
> > with the same type and value (after exporting what they pointed to). But
> > that conflicts with that identifier used in struct
> > fadump_crash_info_header. Would you be ok with renaming that member to
> > just "online_mask"? I think it would be
> >
> > Subject: [PATCH] ppc: rename cpu_online_mask member of struct
> >  fadump_crash_info_header
> >
> > As preparation for eliminating the indirect access to the various
> > global cpu_xyz_bits bitmaps via the pointer variables cpu_xyz_mask,
> > rename the cpu_online_mask of struct fadump_crash_info_header to
> > simply online_mask, to allow cpu_online_mask to become a macro.
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  arch/powerpc/include/asm/fadump.h | 2 +-
> >  arch/powerpc/kernel/fadump.c      | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> > index 493e72f64b35..b4407d0add27 100644
> > --- a/arch/powerpc/include/asm/fadump.h
> > +++ b/arch/powerpc/include/asm/fadump.h
> > @@ -191,7 +191,7 @@ struct fadump_crash_info_header {
> >  	u64		elfcorehdr_addr;
> >  	u32		crashing_cpu;
> >  	struct pt_regs	regs;
> > -	struct cpumask	cpu_online_mask;
> > +	struct cpumask	online_mask;
> >  };
> >  
> >  /* Crash memory ranges */
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> > index 26d091a1a54c..3cb3b02a13dd 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -415,7 +415,7 @@ void crash_fadump(struct pt_regs *regs, const char *str)
> >  	else
> >  		ppc_save_regs(&fdh->regs);
> >  
> > -	fdh->cpu_online_mask = *cpu_online_mask;
> > +	fdh->online_mask = *cpu_online_mask;
> >  
> >  	/* Call ibm,os-term rtas call to trigger firmware assisted dump */
> >  	rtas_os_term((char *)str);
> > @@ -646,7 +646,7 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
> >  		}
> >  		/* Lower 4 bytes of reg_value contains logical cpu id */
> >  		cpu = be64_to_cpu(reg_entry->reg_value) & FADUMP_CPU_ID_MASK;
> > -		if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_online_mask)) {
> > +		if (fdh && !cpumask_test_cpu(cpu, &fdh->online_mask)) {
> >  			SKIP_TO_NEXT_CPU(reg_entry);
> >  			continue;
> >  		}
> 
