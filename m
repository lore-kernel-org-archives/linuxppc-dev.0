Date: Sat, 26 Dec 1998 19:04:13 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [PATCH] Trackpad support for PowerBook
Message-Id: <19981226190413.010977@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Enclosed is a patch to drivers/macintosh/mac_keyb.c which does the following:

 - All mouse handlers IDs are changed to 4 or 2 if possible to enable
full features of most mice. Keyboards are changed to 3 or 5 (I think
those are the good handler IDs for extended keyboards but this could be
double checked)
 
 - The PowerBook trackpad is detected and initialized to full features
(clicking, dragging and drag lock). I'll make a command line tool for
changing it's settings later via /dev/adb.

 - Button 2 of the trackpad is "hacked" to be button 1 so that tapping
(button 2) and pressing the real button (button 1) do the same thing,
like MacOS. This behaviour could be improved to something configurable by
the user (maybe using tapping for button 1 and real button for button 2
?) but I don't know what is the best way to add a runtime-configurable
setting to mac_keyb.c... Maybe some special ioctls to adbmouse.c, but we
would have to export the configuration globals (or accessor functions)
from mac_keyb.c.

 - Adds a placeholder function for the front-panel buttons of the
powerbook G3 series.

I think the patch can be included "as is" (after some testings of
course). The improvements can always be added later.




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
