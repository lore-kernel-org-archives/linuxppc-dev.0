Date: Wed, 29 Sep 1999 19:46:03 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <19990929111338.022344@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990929192816.20530A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Sep 1999, Benjamin Herrenschmidt wrote:

> This doesn't look like the only problem. For example, in rs_close, we
> call tty_wait_until_sent with interrupt disabled. Can't this cause a
> deadlock ? There may be other cases like this.
> 
> I'll look into adding some fixes and include them in the next kernel I
> post on my page (along with a few other stuffs I'd want to get tested,
> including your page_alloc() fix which _apparently_ increased the overall
> perfs on my machine but I didn't do real benchmarks). But I'm wondering

The __get_free_pages() fix is probably not needed for 2.2.13pre, although
something similar might save a few hundred cycles.  Anyway, much to my
amazement, there is significant differences in a number of errors ppp link
report between the kernels with and without the __get_free_pages() patch.
With a stock 2.2.12 kernel, ppp link used to report 1 to 10% frame errors.
But, now, it hardly ever reports any error.  Besides, my machine hasn't
crashed for two days.  I can't remember the last time that my machine
stayed up so long.

> if we shouldn't include your DMA driver right now and make sure it works
> fine instead of doing yet another bunch of patches to the current
> macserial. I didn't try the DMA driver yet, are there known problems with it ?

I don't know of any major flaw, but the DMA code can use some testings.
I've only tested it on Power Mac 7600 with baud rate of upto 115200 bps.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
