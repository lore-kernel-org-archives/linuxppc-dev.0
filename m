Message-ID: <3802E15B.44E53B6A@chpc.utah.edu>
Date: Tue, 12 Oct 1999 01:20:59 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
References: <Pine.LNX.3.96LJ1.1b7.990929192816.20530A-100000@ofey.inetnebr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:

> On Wed, 29 Sep 1999, Benjamin Herrenschmidt wrote:
>
> > . . .
> > I'll look into adding some fixes and include them in the next kernel I
> > post on my page (along with a few other stuffs I'd want to get tested,
> > including your page_alloc() fix which _apparently_ increased the overall
> > perfs on my machine but I didn't do real benchmarks). But I'm wondering
>
> The __get_free_pages() fix is probably not needed for 2.2.13pre, although
> something similar might save a few hundred cycles.  Anyway, much to my
> amazement, there is significant differences in a number of errors ppp link
> report between the kernels with and without the __get_free_pages() patch.
> With a stock 2.2.12 kernel, ppp link used to report 1 to 10% frame errors.
> But, now, it hardly ever reports any error.  Besides, my machine hasn't
> crashed for two days.  I can't remember the last time that my machine
> stayed up so long. . .

I'm running AC's 2.2.13pre15 now and still seeing high error rates (17 out of 472
recieved packets). So if it even might just save a few extra cycles it still seems
worthwhile to add this __get_free_pages() fix, especially if it might have the
chance of getting rid of the high error rates again. I'll try it myself but I
suspect you could get it done much faster if this was enough inclination for you
;-)

Also, any idea why this wouldn't be true on for transmit errors? At least on my
machine, ifconfig ppp0 always reports zero errors and zero overruns on TX packets.
This seems like a good clue I'll have to dig more into :-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
