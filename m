Date: Fri, 14 May 2004 16:19:08 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Phil Thompson <philt@4bridgeworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC440GX GigE support - Update
Message-ID: <20040514161908.A30155@home.com>
References: <C18BA5DDB58DD511BD0700C0DF0DD45028B2A3@NTSERVER4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD45028B2A3@NTSERVER4>; from philt@4bridgeworks.com on Fri, May 14, 2004 at 09:59:16AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 14, 2004 at 09:59:16AM +0100, Phil Thompson wrote:
>
> With a bit more digging I've come to the conclusion that interrupts are not
> the cause of the problem. It seems more like the time taken by the SCSI
> driver to initialise 2 SCSI buses is triggering the problem.
>
> If I hack the SCSI driver detect code to just delay before returning "not
> found" then things work with an overal delay of 2 seconds, but fail with an
> overall delay of 4 seconds.
>
> This would imply the problem is just within the GigE driver. Matt, comments?

I've been looking at the problem too. I had no problem reproducing it
here.  I've isolated it down to where the EMAC itself is receiving
the bootp reply in its fifos (as evidenced by OCRX incrementing by
the number of octets in a bootp reply). However, the controller is
not getting the data into the MAL buffer from there, which is why
you don't see the RXEOB interrupt asserted.  It could be any number
of things, still looking.

BTW, thanks for pointing out the bug in ppc4xx_pic.c, I'll get that
change in soon.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
