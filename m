Date: Tue, 11 Feb 2003 12:16:08 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <3E47F4D4.5070202@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>,
	Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIECLFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan Malek
> Murray Jensen wrote:
>
>  > ...a quick perusal of the code will convince you
> > of this.
>
> No it won't.  Find the case where this happens and then I'll be convinced :-)

Correct, it won't fail since the first instance is redundant. The info ptr is
set to &consinfo and consinfo has "good" values for tx_va_base and tx_bd_base.

However if my_console_write is called BEFORE consinfo has been setup(in
serial_console_setup) then both is needed. Will KGDB/XMON write this early and/or
is KGDB/XMON guaranteed not to write a LF? It sure seems fragile.

> For example, was someone supposed to blindly accept Jocke's patch to make
> the serial port fifos so much larger?  I had to take the time (over and over) :-)
> to explain why this wasn't a bug.  It would be nice if some of you went through
> the learning curve to understand how things are supposed to work before you
> just declare bugs and submit patches.

Well, the patch itself did not contain the FIFO part, but the mail contained
a request to make them bigger. I would had included the FIFO part in the patch
if I had been sure it was the right thing to do. Still think it's a good
idea to expand the # of TX BD and the FIFO length, but possibly one should
keep the lower length during early access to keep the usage of DPRAM low.

> As a final example, Jocke keeps bugging me about his ethernet updates.  I
> explained (yet again, it was in the archives) that this had been attempted
> in the past, and it caused problems with packet routing/forwarding.  Why
> do I have to take the time to set up the testing environment and once again
> prove this is still a problem?  I hoped to find someone with a test
> environment to prove this (as they mentioned the bug in the first place),
> but they are also busy with their own projects.  Someday I may have time
> to set this up, make some changes to the patch so it works better, and
> do some testing to ensure the upstream alignment changes are done properly.
> If someone else can take the time to ensure it works (or make it work)
> in this condition where it was known to fail in the past, I would be more
> likely to check it in without taking the time to do the testing myself.

Come on, the last constructive mail I got from you regarding my Ethernet patch
was http://lists.linuxppc.org/linuxppc-embedded/200211/msg00123.html
where you told me you were looking at the patch and would integrate
"something that hopefully works". You had some concerns about L1 cache alignment
and I explained that I carefully checked that the buffer were L1 cache aligned.

The buffer is kmalloc'ed and kmalloc always returns L1 cache aligned buffers.
Then  __dev_alloc_skb()/dev_alloc_skb() reserves 16 bytes in the beginning of the
buffer and since the L1 cache line is 16 bytes it is still L1 cache aligned.

If this is your only concern, I can make a new patch that allocates 2*L1_CACHE_BYTES
extra space and place the data buffer in between.

Since then you told me that you had sent the patch to some guys that would
be able to trigger the problem you are worried about and I have waited several
months to get the results(and sent reminder to you) and this the first I
hear from you about the outcome.

You reefer to the archives and I have tried to find it, but I didn't find anything.
Please supply search keys or a link when you reefer to the archives since
the search function does not work very well(you must known this already since you could
not locate the mail from Murray Jensen).

>
> It's easy to hack up code, throw it over the fence, and complain when
> someone else won't take care of it.  Make that job easier for those of
> us trying to maintain the source trees, it would be appreciated.

You think I just hacked this up and throwed it over the fence? I beg to differ, I have
been monitoring the success/failure of this patch all along, posted updates and answered
questions. The patch so far has been a success and I think it's more than ready to go in.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
