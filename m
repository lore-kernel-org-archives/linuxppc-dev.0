From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910070927.LAA02521@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <Pine.LNX.4.10.9910061626290.10804-100000@opus.bloom.county> from Tom Rini at "Oct 6, 1999 04:47:22 pm"
To: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 7 Oct 1999 11:27:51 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've run into a wierd problem with ADB stuff, and I wonder if anyone has
> an idea on how to work/fix this.  What I'm trying to do right now is fix
> up kudzu so it can probe for things on the ADB bus.  Right now it does
> what all the other old config tools did, and pokes at /dev/adbmouse.  The
> problem is right now this works if there's any adb device present (one of

That's right - currently /dev/adbmouse can be opened regardless of a mouse
being present. We'd need a way of checking whether a mouse device is present
on the ADB bus (look for a handler ID of 1,2 or 4 in the registered ADB
devices; all information you need is present in the ADB driver). Or use a
global variable set by the ADB driver when it registers a mouse. 

All this will only work if the ADB bus is automatically rescanned when a new
device is detected (if that's possible; does the ADB driver detect new
devices?). 

> the machines I checked only has an adb kbd, tho adbmouse suport is
> compiled in).  Also, is there any way to see if the machine has an adb
> keyboard installed?  Thanks..

Only by poking /dev/adb and sending talk requests and reading the handler
IDs. That might be the easier way of detecting the mouse, too. Sample code
from adb.c:

	adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
			(i << 4) | 0xf);
	adb_handler[i].handler_id = req.reply[2];


	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
