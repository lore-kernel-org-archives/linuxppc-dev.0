Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
To: dan@penguin.netx4.com (Dan Malek)
Date: Tue, 19 Oct 1999 18:56:03 +1000 (EST)
Cc: greyham@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <380B6A1B.E5D02094@netx4.com> from "Dan Malek" at Oct 18, 99 02:42:35 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991019085603.D1026B23A@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> Graham Stoney wrote:
> > 
> > Dear Embeddees,
> > 
> > I'm wondering if anyone is working on a driver to provide the /dev/watchdog
> > interface to the MPC860's on-chip watchdog?
> 
> The difficulty with the on-chip watchdog isn't the driver but
> the coordination with boot roms.  The "auto-reset" features
> of the 8xx (watch dog, bus monitor, etc.) are part of a write once
> configuration register.  Once disabled, they can't be enabled
> again until the processor is reset.
> 
> If the boot rom enables these features (especially the watch dog),
> you must service this as part of the Linux kernel processing.  You
> can't wait around for some application at a later time to determine
> it now wants to enable and process the watchdog.

A couple of people mailed me off the list about my query, and as always, Dan's
right -- it's nowhere near as simple as I first imagined. The watchdog can't
be disabled/reenabled, and its maximum period is only a couple of seconds; 
there's no guarantee that the kernel will have booted and loaded the
application by then, so the watchdog is likely to go off during the boot
process. I think this probably puts my plans to use it on hold for now...

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
