Message-ID: <3911A489.F4A255F6@embeddededge.com>
Date: Thu, 04 May 2000 12:25:45 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Kim Jørgensen <KIJ@infocom.dk>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem with MPC823 LCD driver
References: <819E3E914E0AD11194DE00805F0D100B0138B852@fbi.infocom.dk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen wrote:

> I got a custom MPC823E board, and I want to use a LCD display with Linux.

Get the logic analyzer on the bus.......

> Can anyone tell me what is wrong, and how to solve this?

I can make a few guesses.  This has nothing to do with Math Emulation,
and everything to do with fetching the proper instructions into the
core.  The LCD controller is a heavy-duty DMA controller that has
priority over everything to ensure it can keep the display updated
from system memory.  Since the controller performs large burst mode
operations, this is a classic example of memory controller or memory
interface problems.  I suspect the memory timing isn't correct and the
instructions are just bad memory cycles that can't be properly
decoded.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
