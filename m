From: Benjamin Herrenschmidt <bh40@calva.net>
To: Cort Dougan <cort@fsmlabs.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI rework & CHRP question
Date: Mon, 25 Sep 2000 09:16:14 +0200
Message-Id: <19340820004758.23364@192.168.1.10>
In-Reply-To: <20000924200005.E20496@hq.fsmlabs.com>
References: <20000924200005.E20496@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Good!  Thanks, those bastards have needed to die for a while.
>
>I still do want to be able to mix-and-match PCI controllers and not have
>any board<->chipset association except in the direction board->chipset but
>not chipset implies board.   This helps people with custom hardware get
>their boards going and helps us with new ports.

There should be no problem. You can have your board code create a
controller for any chipset, the chipset code is not dependant on the
board. We already have both PReP and CHRP boards use indirect PCI, we
have some CHRP and pmac use Grackle, etc...

The PCI config access methods are stuffed in the PCI controller structure
(removes a bit from ppc_md. which can't be a bad thing, and makes the
overall thing more readable). But the board specific stuffs are still
there and it's the board support code who decide which chipset to
"instanciate".

On Pmac, I even have a cases where you have 3 hosts bridges with
different access methods (2xbandits and 1xchaos, chaos beeing buggy, it
has special access methods, currently empty, but soon to be filled with
code that returns a fake config space built from OF tree).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
