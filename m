Message-ID: <3A6CE872.F89B0B25@mvista.com>
Date: Mon, 22 Jan 2001 18:12:02 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: frowand@mvista.com, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <3A6CDA97.A9C3FFE2@mvista.com> <3A6CDC43.A18641DC@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Frank Rowand wrote:
>
> > ....The only "context_overflow" I
> > find is mmu_context_overflow() in arch/ppc/mm/init.c.  You obviously
> > aren't talking about the 8xx version of this function.
>
> That's the one.  As part of the 4xx merge I made the 8xx work as
> well, so there is now only this one function for all PowerPC ports.
>
> > This is the code we are talking about, correct?  The reason I'm
> > confused is that I was being literal in my reading of "current->mm"
> > as opposed to "tsk->mm".
>
> The code you posted looks pretty old.  This function has more guts
> to it now, including a 'set_context' of 'current->mm', the source
> of the bug we are discussing.
>
>         -- Dan

Thanks!  I'm back on the right page now...

The code I posted was from a pull of linuxppc_2_5 as of last night.  I
was just a little confused because I didn't see any "if (current->mm != NULL)"
in it.  The problem was that it was gone already.

However, as of last night there is still an 8xx version (paraphrasing quite
a bit):


#ifndef CONFIG_PPC_CPU_PPC_8xx
local_flush_tlb_all()
{
}
local_flush_tlb_mm()
{
}
local_flush_tlb_page()
{
}
local_flush_tlb_range()
{
}
mmu_context_overflow()
{
}

#else /* CONFIG_PPC_CPU_PPC_8xx */
void
mmu_context_overflow(void)
{
        atomic_set(&next_mmu_context, -1);
}
#endif /* CONFIG_PPC_CPU_PPC_8xx */


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
