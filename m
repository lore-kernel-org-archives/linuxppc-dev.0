Message-ID: <37DA0CF4.74840414@wanadoo.fr>
Date: Sat, 11 Sep 1999 10:04:04 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "Joshua M. Thompson" <funaho@jurai.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
References: <Pine.LNX.4.10.9909101954130.10100-100000@ifurita.jurai.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry for this, I was too tired when I wrote it. Sometimes the day job
can get in the way of successful Linux hacking :-)

I had seen the typo in drivers/char/Config.in, but forgot to correct it.
And then it seemed more logical to have the selection of ADB_MOUSE next
to ADB_KEYBOARD, but maybe it isn't. 

Anyway, in 'make menuconfig' the mouse selection is buried rather deep
down, on the  'Character devices' page after things like 'Non-standard
serial port support' and 'Unix98 PTY support'. Let's see... OK, this
seems to be a bug in drivers/char/Config.in. There is an 'endmenu'
missing just before 

mainmenu_option next_comment 
comment 'Mice' 

But, if I put an 'endmenu' there, then 'make xconfig' breaks. And 'make
xconfig' got it right before! (Right = Put 'Mice' and 'Video for Linux'
and so on into the main menu and not in the 'Character devices' menu).
Solution (but this is black magic, I don't understand it and better give
up on this):

Put a line with '#endmenu' instead of 'endmenu' there. Now both 'make
menuconfig' and 'make xconfig' are happy and behave in the same way
(well, almost, in 'make xconfig', the 'watchdog timer' selection is
still on the 'Character devices' page, but the 'watchdog card' selection
is in the main menu). Weird stuff.

Here is the patch:

cvs diff -u drivers/char/Config.in
Index: drivers/char/Config.in
===================================================================
RCS file: /cvs/linux/linux/drivers/char/Config.in,v
retrieving revision 1.80
diff -u -r1.80 Config.in
--- drivers/char/Config.in      1999/09/11 03:39:16     1.80
+++ drivers/char/Config.in      1999/09/11 07:02:10
@@ -61,6 +61,7 @@
   fi
   dep_tristate 'Support for user-space parallel port device drivers'
CONFIG_PPDEV $CONFIG_PARPORT
 fi
+#endmenu
 
 mainmenu_option next_comment
 comment 'Mice'

--
Martin
(Not drunk, it's 10am, but feeling slightly seasick after one hour with
the config.in files)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
