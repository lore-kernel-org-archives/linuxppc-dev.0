Date: Thu, 15 Feb 2001 16:33:56 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: frowand@mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: calling giveup_altivec on machine with no altivec!?
Message-ID: <20010215163356.Q26702@altus.drgw.net>
References: <20010215160658.P26702@altus.drgw.net> <3A8C5613.662D35DA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A8C5613.662D35DA@mvista.com>; from frank_rowand@mvista.com on Thu, Feb 15, 2001 at 02:20:03PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 15, 2001 at 02:20:03PM -0800, Frank Rowand wrote:
> Troy Benjegerdes wrote:
> >
> > My Motorola MTX just crashed after the following code in _swithc_to
> > executed:
> >
> >         if ((prev->thread.regs && (prev->thread.regs->msr & MSR_VEC)))
> >                 giveup_altivec(prev);
> >
> > Somehow prev->thread.regs->msr & MSR_VEC turned out true. I'm suspecting
> > something got overwritten somewhere..
> >
> > This is an SMP machine so I'm wondering if there wasn't a race condition
> > on something with task structs..
>
> Is it possible that the MSR had the MSR_VEC bit set at some point?  One
> IBM processor user's manual says "the reserved fields should be written
> as 0 and read as __undefined__.  This is, when writing to a register with
> a reserved field, write a 0 to the reserved field.  When reading from a
> register with a reserved field, ignore that bit."

Possible, but I doubt it, since I believe the _switch_to code has been
like that for quite awhile. (I was running on a 604ev.. anyone know ofhand
if that bit is defined for something on the 604ev?)

In either case, if that's what the IBM manuals say, then the code is
incorrect and should probably be re-done to check that it's actually
running on a kernel with an altivec unit. Any suggestions on the best way
to fix it?

--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
