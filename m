Date: Mon, 28 Dec 1998 18:01:18 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Cort Dougan <cort@ladron.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: New patches & test kernel
Message-Id: <19981228180118.022846@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All !

I'm uploading a test kernel with new patches to my web page. It contains
all diffs between this morning's vger and some of my latest patches. Not
all or them are functional (wallstreet sleep still doesn't work and uses
an horrible hack I made at the end of irq.c so you can avoid all irq.c
and via-pmu.c patches).

For the rest, it's my adb additions which should work fine (adb.c/.h and
mac_keyb.c) for Trackpad, Turbomouse 5 (I added detection of the beast
(untested) and merged the init code from mousehack but it was not tested
neither; trackpad works with full features, all standard 3-btn mice using
Apple extended protocol on handler 4 should work, older hice on handler 2
too, and this cleans up the init code a little bit).

Here are some details:

 - I suggest you merge adc.c/.h (note the new exported symbols, I also
added one or two missing ones) now.

 - mac_keyb.c should be mergeable soon, I just want some feedback for the
TurboMouse stuff.

 - grackle.h should be fine and will do no harm (a set of macros for
accessing MPC106 config registers). I include it from via-pmu.c (my
horrible sleep hacks) and idle.c (see below)

 - idle.c contains some attemts at configuring grackle for power-saving
too. I didn't enable it by default (see the global) so you should be able
to merge it without impact, I wanted to discuss this with you before:
If we use idle with nap, then the code should be just fine (actually the
second access to disable grackle power management should be useless since
nap will be stopped automatically). If we use doze, then configuring doze
in grackle will make it doze all the time, it will self-reenable. I don't
yet exactly know the impact of running with doze in grackle all the time
ON, so I added the code to turn it back off when we get out of processor
doze but this may be useless to, making the second access to gackle
completely useless.

Finally, all those power-management things should be user-configurable,
but I guess this is the original intent since non-static globals are used
to control it. I didn't look for a place where those are changed (a /proc
entry ?) yet.
 
There are link on my web page (URL below), it's the "Test" kernel.

Please, send me your feedback, especially if you have a weird mouse that
required mousehack before. mousemode 3 4 or 15 4 should be useless too
with this kernel.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
