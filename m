Date: Mon, 19 Jul 2004 09:32:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] make platform_init() weak for 8xx
Message-ID: <20040719163203.GA6813@smtp.west.cox.net>
References: <1090253615.1415.24.camel@shiva.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090253615.1415.24.camel@shiva.saftware.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 19, 2004 at 06:13:35PM +0200, Andreas Oberritter wrote:

> Hi Tom,
>
> this patch renames platform_init to m8xx_init in m8xx_setup.c and adds
> new weak platform_init, which can be overridden by boards to allow them
> to e.g. register platform_devices like redwood5.c does for 40x.

First, I don't see the redwood5 example you're talking about.
Second, this takes us in the direction of 82xx.  Until the 82xx
abstractions get flushed out a bit more, I remain unconvinced that
they're really the right way to go (perhaps hooking the other direction
would work better, e.g. platform_init() calls board_init(), with a weak
version provided, and some functions forced to be provided by board.c,
such as m8xx_map_io).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
