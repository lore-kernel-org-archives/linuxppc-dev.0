Message-ID: <3C5B264B.4884586B@mvista.com>
Date: Fri, 01 Feb 2002 16:35:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 ethernet
References: <20020201134723.G30787@boardwalk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Val Henson wrote:

> We have a board with the Galileo GT64260 chip and we'd like to use the
> gt64260 ethernet driver.  At the moment, its config option is in
> arch/ppc/config.in and is controlled by the CONFIG_GT64260 option
> (which is not turned on for our boards, CONFIG_GEMINI is).  I'd think
> that the preferred way to fix this is to put the CONFIG_GT64260_ETH
> option in drivers/net/config.in.  The alternative is to have
>
> if [ "$CONFIG_GT64260" = "y" -o "$CONFIG_GEMINI" = "y" ]; then

This may not be the best place for it but right now, that stuff is in
arch/ppc/config.in.  When you turn on CONFIG_GT64260 (presumably as a
result of selecting your platform--see CONFIG_EV64260), there will be an
additional submenu show up under "Platform support" called "Galileo
GT64260 Options".  Go in there and select the enet drivers you want and
pick a MAC addr if you don't like the default.

I guess that should migrate to the drivers/net Config.in...

The driver worked once but has been broken by the latest checkin (at
least for me).  I have a version that works for me.  I will push it out
sometime next week but if you need it now, let me know and I'll email it
to you.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
