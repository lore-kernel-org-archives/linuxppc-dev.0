Date: Fri, 23 Nov 2001 20:24:30 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: David Given <dg@tao-group.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Strange FPU/threads problem
In-Reply-To: <01112317084703.18383@pearl>
Message-ID: <Pine.LNX.4.33.0111232017500.16079-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 23 Nov 2001, David Given wrote:

>
> On Tuesday 20 November 2001 18:16, David Given wrote:
> [...]
> > However, if I compile it so that it *does* use threads, it bails with a
> > SIGFPE the first time in encounters a floating point instruction. And I
> > don't know why.
> [...]
>
> I've done some more research. The thing that's causing the exception is
> arch/ppc/kernel/traps.c+291 (for Linux version 2.4.15), claiming an IEEE FP
> exception. The relevant code is:
>
>         if (regs->msr & 0x100000) {
>                 /* IEEE FP exception */
>                 _exception(SIGFPE, regs);
>         }
>
> Now, my copy of the 601 manual claims that only bits 27 to 16 of the MSR are
> defined, which translates to bits 5 to 15 in the real world, because the 601
> manual numbers the bits the wrong way round throughout[1]. Which means that
> bit 20, above, is undefined. MSR turns out to be:
>
> 	00010F930
>

Besides disagreeing with your notion of bit order, I'd recommend you to
look at the section on exceptions, more precisely the table 5-16 "Program
Exceptions-Register settings" on page 5-33 if you have the same 601 doc as
me. SRR1 not only has a copy of the MSR, it also has a few bits whih
indicate the cause of the exception, unsurprisingly it says:

Bit 11: Set for a floating-point enabed program exception; otherwise
cleared.

I believe it is the same for all PPC processors and Power3/Power4.
This said, there have been recent patches wrt FPU handling in the kernel,
most notably clearing the FPSCR in some occasions.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
