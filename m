Date: Mon, 24 Jun 2002 10:59:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>,
	Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
Message-ID: <20020624175926.GE3489@opus.bloom.county>
References: <20020620214551.GI16052@opus.bloom.county> <20020620215844.E66F61030A@denx.denx.de> <20020620221016.GK16052@opus.bloom.county> <3D12F667.30902@bluewin.ch> <20020624170055.GB3489@opus.bloom.county> <3D175BA8.6090206@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D175BA8.6090206@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 24, 2002 at 01:49:28PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> >Ah, which is why you just expanded things the way you did..  Which works
> >for that context but still leaves the larger problem of request_irq()
> >panic()'ing on unknown interrupt numbers.
>
> All you need to do is modify request_irq() to check/map the numbers that
> are OK for you to use on your system.  The problem with request_irq() is
> it is easy to pass a number you think is fine from some legacy perspective,
> but it messes up the SIU due to "numberspace" overlap.  To trap these and
> print out a message saves lots of traffic on this mailing list :-)

First, I'm not so sure that it does save a lot of traffic.  The number
of bad legacy drivers is rather small now, and the ones which _might_
ever be accidently enabled on 8xx are limited to CONFIG_SERIAL I would
think.
Second, if it does become a problem, we should look into grabbing the
ChangeSet from Andi Kleen (and a few others) that masks off legacy
drivers under CONFIG_ISA since they don't work on x86-64 (and probably
ia64).  So the x86 world is finally almost caring about this problem :)
Finally, it's not the 'linux way' to preemptivly shoot users in the head
in case they might do something bad to their machine.  (And the mapping
doesn't always work anyhow, the ne2k PCMCIA card I've got doesn't work
due to some actual driver issue that I'll look into sometime maybe..
:)).

> >Well maybe Dan will get encouraged enough to try and properly fix
> >request_irq() and break some of the legacy PC drivers in 2.5 again. :)
>
> I can't break it until I dredge up some of the stuff we did way back in
> 2.1.xx
> and get it to stick.  Unless we have the underlying mechanism to manage
> an arbitrary, cascaded interrupt controller, all we have are processor and
> platform specific hacks with functions that behave differently.  I guess
> I can do it for PPC only, and then hope this time it gets generally
> integrated entirely.  In this case, there will be a different function name,
> as request_irq() will be left as some macro or simple function for
> legacy compatibility.

Go for it...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
