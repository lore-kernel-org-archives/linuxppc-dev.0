Message-ID: <380B821B.F1C79A32@jlc.net>
Date: Mon, 18 Oct 1999 16:24:59 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
References: <19991015033031.18664848C@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
> 
> Dear Embeddees,
> 
> I'm wondering if anyone is working on a driver to provide the /dev/watchdog
> interface to the MPC860's on-chip watchdog?

The difficulty with the on-chip watchdog isn't the driver but
the coordination with the boot roms.  The "auto-reset" features
of the 8xx (watch dog, bus monitor, etc.) are part of a write once
configuration register.  Once disabled, they can't be enabled
again until the processor is reset.

If the boot rom enables these features (especially the watch dog),
you must service this as part of the Linux kernel processing.  You
can't wait around for some application at a later time to determine
it now wants to enable and process the watchdog.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
