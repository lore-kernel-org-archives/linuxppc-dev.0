Message-ID: <3D175BA8.6090206@embeddededge.com>
Date: Mon, 24 Jun 2002 13:49:28 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>,
	Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
References: <20020620214551.GI16052@opus.bloom.county> <20020620215844.E66F61030A@denx.denx.de> <20020620221016.GK16052@opus.bloom.county> <3D12F667.30902@bluewin.ch> <20020624170055.GB3489@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Ah, which is why you just expanded things the way you did..  Which works
> for that context but still leaves the larger problem of request_irq()
> panic()'ing on unknown interrupt numbers.

All you need to do is modify request_irq() to check/map the numbers that
are OK for you to use on your system.  The problem with request_irq() is
it is easy to pass a number you think is fine from some legacy perspective,
but it messes up the SIU due to "numberspace" overlap.  To trap these and
print out a message saves lots of traffic on this mailing list :-)


> Well maybe Dan will get encouraged enough to try and properly fix
> request_irq() and break some of the legacy PC drivers in 2.5 again. :)

I can't break it until I dredge up some of the stuff we did way back in 2.1.xx
and get it to stick.  Unless we have the underlying mechanism to manage
an arbitrary, cascaded interrupt controller, all we have are processor and
platform specific hacks with functions that behave differently.  I guess
I can do it for PPC only, and then hope this time it gets generally
integrated entirely.  In this case, there will be a different function name,
as request_irq() will be left as some macro or simple function for
legacy compatibility.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
