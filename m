Message-ID: <37F25597.63CED114@chpc.utah.edu>
Date: Wed, 29 Sep 1999 12:08:23 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
References: <19990929190222.023648@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> On Wed, Sep 29, 1999, Lou Langholtz <ldl@chpc.utah.edu> wrote:
>
> >This is pretty much the kernel I'm running now. I haven't had the "FB.
> >overflow" message yet nor system-freeze but I've experienced the TCP slowdown
> already.
> >Evidence that we've got other problems as well (IMO). It's only been 20 hours
> >or so with new kernel so not enough time for me to feel confident though about
>
> >these results.
>
> I've added another fix to the kernel on my test page
> (http://calvaweb.calvacom.fr/bh40/test.html). It may fix the hang on
> close. I don't think it will fix anything related to a slowdown however.

It's interesting to note that you chose to move save_flags(flags) in
rs_write() to just before the cli()'s. What was your reasoning? I'm asking so
I can get a better understanding of all the implications of this. Most code that
I've perused so far now does what you've basically done --- keeps the
save_flags() right before the cli()'s. When I chose to just to remove that last
restore_flags() I was basing my descision not to move the originall
save_flags() on the rs_write() code in drivers/char/serial.c. In the serial.c
file they call save_flags() outside of the while loop like the original
rs_write() in macserial.c. This would save time by not being constantly
re-invoked within the loop of course but then this only works if the flags saved
stay valid. That's the part I'm having the most trouble with --- what kind of
calls could invalidate the flags that have been saved.

As to the hang-on-close problem, I've never experienced that before nor heard of
it. Is it something that you've seen or heard of? Your change makes sense anyway.
I'm just being curious in case this might be effecting me in ways I didn't even
realize.

Cheers! :-)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
