Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <49829.10.0.1.2.1052416673.squirrel@mail.bluepeach.com>
Date: Thu, 8 May 2003 13:57:53 -0400 (EDT)
Subject: Trouble booting linux on EST8260 board
From: "Richard Schmitt" <rschmitt@bluepeach.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Reply-To: rschmitt@bluepeach.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As the subject says, I'm having trouble booting linux (both DENX and Hard
Hat) on our EST8260 board.  The symptoms sound a lot like a problem which
has been discussed on this list before, but I believe my problem is
different.  Let me explain:

I am using u-boot 0.2.0 as my boot loader.  I have verified that the bd_t
structure passed to Linux by u-boot is the same structure that is expected
by Linux.  All the frequency values in the bd_t structure have been
normalized to MHz.  I have verified that the immr address set up by u-boot
is the address that Linux expects.

I have verified that I run through initialization into start_kernel in
main.c.  Further, I have verified that I make it through the call to
init_IRQ.  What appears to happen is that after the routine m8260_init_IRQ
is called, I will start getting timer_interrupts.  It appears that any
forward progress of initialization stops at this point.  Anytime I check,
it seems I am running in the timer interrupt code.  I have tried
everything I can think of with the frequencies specified in the bd_t
structure.  Just to be clear, they are passed in by u-boot as MHz values.
The following are passed in:

    intfreq = 132000000
    busfreq = 33000000


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
