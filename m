Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 21 Oct 1999 13:49:41 +1000 (EST)
In-Reply-To: <003e01bf1a9e$59f44980$0201a8c0@home> from "Jeff Millar" at Oct 19, 99 09:56:38 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991021034941.C067A659@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: Dan Malek <dan@netx4.com>
> To: Graham Stoney <greyham@research.canon.com.au>
> Cc: Dan Malek <dan@penguin.netx4.com>;
> <linuxppc-embedded@lists.linuxppc.org>
> Sent: Tuesday, October 19, 1999 3:51 PM
> Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
> 
> > Graham Stoney wrote:
> > > .... The watchdog can't
> > > be disabled/reenabled, and its maximum period is only a couple of
> seconds;
> > > there's no guarantee that the kernel will have booted and loaded the
> > > application by then, so the watchdog is likely to go off during the boot
> > > process. I think this probably puts my plans to use it on hold for
> now...
> >
> > Maybe not.  I was thinking about this (when I should have been doing
> > other things :-) earlier today.  What we could do when the internal
> > watchdog is configured is to service it during the Linux timer
> > interrupt when an application doesn't have it "enabled".  This
> > doesn't provide a watchdog service, just ensures it doesn't
> > unexpectedly expire.  When an application decides it wants the
> > watchdog, we don't service it in the timer ISR.
> >
> > We would have to litter the boot code with some service calls,
> > like when you wait at the Linux boot prompt, and make sure
> > you can uncompress and enable timer interrupts before the next
> > expiration.  Beyond that, we wouldn't have to look for any
> > watchdog service points in the kernel.

Our email & file server died big time yesterday, so I only saw this this
morning, and co-incidentally had exactly the same idea. To the user app,
/dev/watchdog still looks much like the interface in watchdog.txt.

Sounds pretty good to me!

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
