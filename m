From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: now random kernel panics with aic7xxx driver 6.2.4 in kernel
 2.4.12
Date: Mon, 15 Oct 2001 14:24:20 +0200
Message-Id: <20011015122420.31143@smtp.adsl.oleane.com>
In-Reply-To: <20011014235202.PYHV2701.tomts7-srv.bellnexxia.net@there>
References: <20011014235202.PYHV2701.tomts7-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Justin,
>
>> It would be interesting to know what type of panics you saw prior
>> to 6.2.4.  It might help me track down where this problem began.
>
>This is my first foray into 2.4.X kernels.  I did not have any panics with
>the old aic7xxx driver.  I first used 6.2.1 in kernel 2.4.11.  So you
>pretty much know the whole story.  The reason I moved to your 6.2.4 was
>that at some point I could not even boot 2.4.12 since it came back with:
>
>scsi0:A:1: ahc_intr - referenced scb not valid during seqint 0x71 scb(0)
>...
>Kernel panic: for safety
>In interrupt handler - not syncing
><0>Rebooting in 180 seconds
>
>But the message logs never caught any of the error message since a sync
>was not done.

I've been getting bizqrre problems with aic7xxx since 2.4.11 on my
dual G4 as well. It started with some problems detecting my external
disk, but the problem disappeared by itself using a more recent
kernel (during the .11-pre series).

However when I first compiled .12, the machine locked up during boot
just after printing "SCSI subsystem driver Revision: 1.00". It was
not a hard lockup as the console cursor was still flashing, looks like
one of the CPUs got hung or something around those lines.

I recompiled this kernel with xmon (our small kernel debugger we have
on PPC), the problem went away magically...

Today, I recompiled that same kernel, but with different drivers built-in
(nothing related to SCSI, but that did change the kernel size and boot
timing), I'm getting a  similar error as above (referenced scb not valid)
followed by a panic (using the 6.2.1 driver).

I'll try to do the tests you suggest asap, I hope to have some time
tonight or tomorrow. Note that I used earlier 2.4.x kernels with your
driver on that same box (with the same 2 adaptec cards & disk setup)
without problems.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
