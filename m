Date: Fri, 11 Oct 2002 12:08:05 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx - power save modes - PIT
Message-ID: <20021011160805.GA14567@segfault.usine.8d.com>
References: <D73A25AA6E54D511AD74009027B1110F3C035A@ORION>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F3C035A@ORION>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steven,

On Fri, Oct 11, 2002 at 09:15:21AM -0400, Steven Blakeslee wrote:
>
> In the 850 user manual I found the following to describe the SCCR[DNFH].
> "Division factor high frequency. Sets the VCOOUT frequency division factor
> for general system
> clocks to be used in normal mode. In normal mode, the MPC850 automatically
> switches to the
> DFNH frequency. To select the DFNH frequency, load this ?eld with the divide
> value and clear
> CSRC. A loss-of-lock condition does not occur when this ?eld is changed.
> This ?eld is cleared by a power-on or hard reset."
>
> You have the following code.
> imp->im_clkrst.car_plprcr |= 1<<21;		// plprcr[csrc]=1

In fact, that was erronoeus because of the bit ordering stuff
mentioned in a previous mail within this thread. I meant to write:

imp->im_clkrst.car_plprcr |= 0x00000400         // plprcr[csrc]=1

Anyway, i was trying to move to 'normal low mode', which is supposed
to be 100% functionnal, only at a slower pace.

If i either change the dfnh clock divider (ex: sccr[dfnh]=110b) or
move to the normal low mode (plprcr[csrc]=1), i lose my console. :(

Thanks for your support.
Best regards,


Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
