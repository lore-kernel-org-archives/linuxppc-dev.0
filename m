Date: Thu, 19 Dec 2002 08:15:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>,
	Todd Poynor <tpoynor@mvista.com>
Subject: Re: 405LP RTC reset
Message-ID: <20021218211556.GA8947@zax.zax>
References: <1040150612.10740.111.camel@granite.austin.ibm.com> <20021218005542.GC3666@zax.zax> <1040225939.29647.11.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1040225939.29647.11.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 18, 2002 at 09:38:53AM -0600, Hollis Blanchard wrote:
>
> On Tue, 2002-12-17 at 18:55, David Gibson wrote:
> >
> > On Tue, Dec 17, 2002 at 12:43:32PM -0600, Hollis Blanchard wrote:
> > > Here's the updated 405LP RTC reset diff (after David's move of the RTC
> > > functions to ibm405lp.c). This patch
> > > a) does a full RTC reset as specified in the docs
> > > b) sets the RTC clock speed in RTC "Register A" DV bits, i.e. it does
> > > not assume the firmware has done this correctly.
> >
> > One query though (I didn't think of this earlier) - is it such a great
> > idea to go setting the reference clock frequency?  Unlike most other
> > drivers, we can't just take over the RTC and do what we like with it
> > once the kernel boots, because it has to keep running at the same rate
> > even when the device is rebooting or (mostly) off.
>
> The only issue I can think of here is the firmware setting it
> incorrectly or not at all. In that case, a few seconds will be expanded
> or compressed, but that's better than time running too fast or slow
> forever, right?

That's true.  Still, I think it might be worth testing what the rate
is set to when we come in, and printing a warning if it's not what we
expect before we adjust it.  If it just silently corrects it I could
imagine it being pretty nasty to track down why the device is
losing/gaining time each boot.

> Of course the rate settings must be battery-backed along with the time,
> so you only need to set it once per RTC power loss. That includes
> rebooting time and power off time.
>
> -Hollis

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
