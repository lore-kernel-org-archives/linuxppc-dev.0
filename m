Date: Thu, 7 Oct 1999 12:38:32 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB probing
In-Reply-To: <199910071828.UAA02976@simul.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.3.96.991007121814.6540J-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 7 Oct 1999, Michael Schmitz wrote:

> ?? I found the reset (and implicit rescan) in adb.c, is there a hook from
> mac_keyb.c? (I meant 'force a reset via /dev/adb, which will in turn cause a
> rescan)

This is a rather poor way of handling bus probing, IMHO.  See below.


> Yep, that will work as long as all drivers receiving data from ADB get
> notified. Might be problematic for user space apps that open /dev/adb and
> talk to a specific device directly. In case of ID collosions, we might have
> a different device occupy that ID after a reset. As long as handler IDs and
> original IDs (better: address) are unique, there should be no problems.

Danger.  Add a second keyboard.  Bang, you're up in smoke.  If you really
want the code to work, you do _not_ want to do a bus reset.  If I'm
remembering my hardware right, a bus reset blanks the status of the ADB
devices, just like you unplugged everything.  Your mouse acceleration is
reset, your keyboard lights go off, etc.  You'll have to notify every
handler, etc. to save the state, and restore it afterwards.  It's really a
massive pain in the backside.

A reset will also cause all the devices to jump back to their default
positions, complete with ID collisions, etc., and if any device has been
added, odds are your remapping code is going to remap things differently 9
times out of 10.  It's very bad for userland code, as you mention.  It's
also adding unnecessary complication to drivers.  It's one thing for say
the mouse handling code to be told that there's a new mouse for it to
handle at ID 4.  It's another thing entirely to tell it that the mice it
handled have all been remapped in different places, now go find them all.
It's a much bigger performance hit for that reason, and also because the
bus reset isn't exactly fast, IIRC.

There are several possibilities here.  My suggestion would be to take
advantage of the 1 second adb tick.  At each one second tick, move each
device to a free device.  If there's nothing under it, move it back, else
move whatever's under it, then move it back.  Happening once per second
should make this relatively painless performance-wise, so long as you
handle the locking of the adb bus correctly.

The advantages to that method are:

1. there's no long delay while the bus resets.
2. It's completely transparent to the user.
3. devices don't move from the perspective of drivers and userland
   programs

The disadvantages (or at least caveats) to that method are:

1. There is a miniscule delay every 1 second.
2. While the devices are at a temporary location, data may arrive.
   This must be modified to show the correct (permanent) ID number.
3. If a device with the same handler ID happened to appear at the
   same location, it would be hard to determine which one was the
   new one and which one was the old one, I think.  In that case,
   though, odds are you can just notify the handler code to deal
   with one more device.  GPM is one exception, which is a good reason
   to make sure mice always move to a different ID than the default.
   Quick & easy solution.  :-)


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
