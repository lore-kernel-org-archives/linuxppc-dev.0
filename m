Message-ID: <3BA8DF9E.FD235CF6@mvista.com>
Date: Wed, 19 Sep 2001 14:10:38 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Sounds like a good idea.  Also, doing inline ... __init is rather silly.
> How's the idea sound Dan?

The idea is OK, but I would prefer a different implementation.  You
are trying to do basically the same thing as all of the boards that
use versions of OpenPIC, EPIC, etc.  Rather than have a fixed size
array, and fill most of it with zero, a generic solution should be
able to work with variable sized arrays......just pass the size
somehow. The sizeof() works pretty well for this :-).  The boards
initialize the array to whatever they need, and don't have to worry
about others.

> Well, do you forsee the need to put in board-specific defines?

This isn't the right way.  If you notice the way the ports work,
everything 4xx (or 8xx, or 6xx, or whatever), include the single
header file, in this case ppc4xx.h.  This include file will select
the proper board specific file.  The board specific file, contains,
well, the stuff specific to a board.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
