Message-ID: <36A6F4B2.D950794C@wanadoo.fr>
Date: Thu, 21 Jan 1999 10:34:42 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>
Subject: pre8(vger) kills button 3 on 1-button mouse
References: <19990120232032.031426@smtp.calvacom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The latest changes for 2-to-4-button mice on vger in
drivers/macintosh/mac_keyb.c (rev 1.24) break the emulation of button 3
on my 1-button Apple adb mouse.

This happens both in Xpmac, where option_right+click is hard-coded to
button 3, and in XF68_FBDev, where I use a patch by Franz Sirl for the
adb_buttons kernel command to get the same effect.

The reason seems to be that in rev 1.24 option_right gets mapped to
option_left even in raw mode (same for ctrl, BTW). I don't understand
this from the code, which is too complicated for me, anyway, but from
looking at the effect, as witnessed by xev in Xpmac, for example.

For the moment, I went back to rev 1.23 which doesn't have this problem.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
