From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910080944.LAA03438@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <Pine.LNX.3.96.991007121814.6540J-100000@mvista.com> from "David A. Gatwood" at "Oct 7, 1999 12:38:32 pm"
To: dgatwood@mvista.com (David A. Gatwood)
Date: Fri, 8 Oct 1999 11:44:28 +0200 (CEST)
Cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > ?? I found the reset (and implicit rescan) in adb.c, is there a hook from
> > mac_keyb.c? (I meant 'force a reset via /dev/adb, which will in turn cause a
> > rescan)
> 
> This is a rather poor way of handling bus probing, IMHO.  See below.

True, it's just the easiest way with the current implementation. You could
move around devices via /dev/adb as well but that won't lead to changing the
kernel's view of the registered ADB devices. Plus the complications you
mention with data coming in while the bus is being tweaked. 

> > Yep, that will work as long as all drivers receiving data from ADB get
> > notified. Might be problematic for user space apps that open /dev/adb and
> > talk to a specific device directly. In case of ID collosions, we might have
> > a different device occupy that ID after a reset. As long as handler IDs and
> > original IDs (better: address) are unique, there should be no problems.
> 
> Danger.  Add a second keyboard.  Bang, you're up in smoke.  If you really

Why? As long as all devices with a keyboard type hander feed into the
keyboard input, everything should be fine. 

> want the code to work, you do _not_ want to do a bus reset.  If I'm
> remembering my hardware right, a bus reset blanks the status of the ADB
> devices, just like you unplugged everything.  Your mouse acceleration is
> reset, your keyboard lights go off, etc.  You'll have to notify every
> handler, etc. to save the state, and restore it afterwards.  It's really a
> massive pain in the backside.

The device state is lost, right. It can be restored from the handler
specific inits without prior save, provided the handler keeps track of the 
device state (the LEDs being a good example of this). Everything that had
been set up from kernel space can be restored that way. For anything you
changed via /dev/adb, you will have to repeat it. 
 
> also adding unnecessary complication to drivers.  It's one thing for say
> the mouse handling code to be told that there's a new mouse for it to
> handle at ID 4.  It's another thing entirely to tell it that the mice it
> handled have all been remapped in different places, now go find them all.
> It's a much bigger performance hit for that reason, and also because the
> bus reset isn't exactly fast, IIRC.

This is a consequence of using the ID as the only hint to decide where a
packet should go. If we used the handler ID, which is set up correctly after
a bus scan, I can't see a problem. But I'll reread the code on this. 
 
> There are several possibilities here.  My suggestion would be to take
> advantage of the 1 second adb tick.  At each one second tick, move each
> device to a free device.  If there's nothing under it, move it back, else
> move whatever's under it, then move it back.  Happening once per second
> should make this relatively painless performance-wise, so long as you
> handle the locking of the adb bus correctly.

How do you lock the bus? Sending out the requests won't take long and you
won't sit in a loop sending and reading each byte if you can use interrupts
:-) And if that scheme is too much hassle, just move one device on each
tick.

I really don't like polling, but there probably isn't anything else to
detect new devices (two keyboards both at the default ID, or two mice, did
play together perfectly before the bus scan was implemented IIRC). 

The only other thing I can imagine is to keep the default IDs unoccupied,
and watch for packets from these IDs. 
 
> 2. While the devices are at a temporary location, data may arrive.
>    This must be modified to show the correct (permanent) ID number.

Use the handler ID to route the packet. 

> 3. If a device with the same handler ID happened to appear at the
>    same location, it would be hard to determine which one was the
>    new one and which one was the old one, I think.  In that case,

Impossible unless the handler ID or other data you stored about that device
are different. If you sent a config request to the device and can read that
config back, fine. 

One more reason to leave the default IDs empty.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
