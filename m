In-Reply-To: <v04011700b2a7ddd993aa@[209.86.155.175]>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Sat, 26 Dec 1998 18:46:04 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [PATCH] Trackpad support for PowerBook
Message-Id: <19981226184604.028121@smtp.calvacom.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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


--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="trackpad.patch.gz"; x-mac-creator="477a6970"; x-mac-type="477a6970"
Message-Id: <19981226184615.005677>
Date: Sat, 26 Dec 1998 18:46:15 +0100
Content-Transfer-Encoding: base64

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
l/4BO5JcPDcXAAA=

--==_Boundary-1_==--


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
