Message-ID: <37FC8268.E886EB87@tiac.net>
Date: Thu, 07 Oct 1999 07:22:15 -0400
From: Timothy Wall <twall@tiac.net>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB probing
References: <199910070927.LAA02521@simul.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been working on a tablet driver, and doing things essentially on the same
level and providing /dev/adbtablet for application-level stuff.  Are there any
docs or samples on what I can do through /dev/adb?

The tablet driver has an ADB scan loop if you're interested.

T.

Michael Schmitz wrote:

> > I've run into a wierd problem with ADB stuff, and I wonder if anyone has
> > an idea on how to work/fix this.  What I'm trying to do right now is fix
> > up kudzu so it can probe for things on the ADB bus.  Right now it does
> > what all the other old config tools did, and pokes at /dev/adbmouse.  The
> > problem is right now this works if there's any adb device present (one of
>
> That's right - currently /dev/adbmouse can be opened regardless of a mouse
> being present. We'd need a way of checking whether a mouse device is present
> on the ADB bus (look for a handler ID of 1,2 or 4 in the registered ADB
> devices; all information you need is present in the ADB driver). Or use a
> global variable set by the ADB driver when it registers a mouse.
>
> All this will only work if the ADB bus is automatically rescanned when a new
> device is detected (if that's possible; does the ADB driver detect new
> devices?).
>
> > the machines I checked only has an adb kbd, tho adbmouse suport is
> > compiled in).  Also, is there any way to see if the machine has an adb
> > keyboard installed?  Thanks..
>
> Only by poking /dev/adb and sending talk requests and reading the handler
> IDs. That might be the easier way of detecting the mouse, too. Sample code
> from adb.c:
>
>         adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
>                         (i << 4) | 0xf);
>         adb_handler[i].handler_id = req.reply[2];
>
>         Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
