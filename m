From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910071828.UAA02976@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <19991007182156.030455@mailhost.mipsys.com> from Benjamin Herrenschmidt at "Oct 7, 1999 06:21:56 pm"
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Thu, 7 Oct 1999 20:28:51 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >I'd rather not poll the ADB bus if it can be avoided. How does MacOS detect
> >a new mouse device? But you could always force a bus reset and rescan via 
> >/dev/adb. 
> 
> Be careful that the bus reset will cause an automatic re-probing and
> re-init of the bus and devices by the drivers in mac_keyb.c. (This way,

?? I found the reset (and implicit rescan) in adb.c, is there a hook from
mac_keyb.c? (I meant 'force a reset via /dev/adb, which will in turn cause a
rescan)

> we could make a userland tool that sends the bus reset and have a real
> hot-swap ADB, just reset the bus after the hot swap). This feature is
> mainly used by the sleep code for now.

Yep, that will work as long as all drivers receiving data from ADB get
notified. Might be problematic for user space apps that open /dev/adb and
talk to a specific device directly. In case of ID collosions, we might have
a different device occupy that ID after a reset. As long as handler IDs and
original IDs (better: address) are unique, there should be no problems. 

BTW: opening /dev/adb to read from a specific device is cumbersome, right?
You can send listen and talk requests to the device but there's no way to
get autopoll data to user space. What about using minor 1-16 for that (now
that bus probing is implemented)? 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
