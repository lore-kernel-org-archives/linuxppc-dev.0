Message-ID: <49891.10.0.1.2.1052417085.squirrel@mail.bluepeach.com>
Date: Thu, 8 May 2003 14:04:45 -0400 (EDT)
Subject: Re: Trouble booting linux on EST8260 board
From: "Richard Schmitt" <rschmitt@bluepeach.com>
To: <rschmitt@bluepeach.com>
In-Reply-To: <49829.10.0.1.2.1052416673.squirrel@mail.bluepeach.com>
References: <49829.10.0.1.2.1052416673.squirrel@mail.bluepeach.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Reply-To: rschmitt@bluepeach.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


** Sorry, the previous email was sent too soon **

As the subject says, I'm having trouble booting linux (both DENX and
Hard Hat) on our EST8260 board.  The symptoms sound a lot like a problem
which has been discussed on this list before, but I believe my problem
is different.  Let me explain:

I am using u-boot 0.2.0 as my boot loader.  I have verified that the
bd_t structure passed to Linux by u-boot is the same structure that is
expected by Linux.  All the frequency values in the bd_t structure have
been normalized to MHz.  I have verified that the immr address set up by
u-boot is the address that Linux expects.

I have verified that I run through initialization into start_kernel in
main.c.  Further, I have verified that I make it through the call to
init_IRQ.  What appears to happen is that after the routine
m8260_init_IRQ is called, I will start getting timer_interrupts.  It
appears that any forward progress of initialization stops at this point.
 Anytime I check, it seems I am running in the timer interrupt code.  I
have tried
everything I can think of with the frequencies specified in the bd_t
structure.  Just to be clear, they are passed in by u-boot as MHz
values. The following are passed in:

    intfreq = 132000000
    busfreq = 33000000
    cpmfreq 66000000
    brgfreq 33000000
    sccfreq 33000000
    vco 132000000

What's odd is that the timer interrupt is happening before any call to
time_init.  In addition, it appears to be non-maskable.  I have disabled
the MSR EE bit, and the interrupt controller mask registers are all 0 yet
I seem to get stuck in the timer interrupt.

Does anyone have any clue?

Thanks
Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
