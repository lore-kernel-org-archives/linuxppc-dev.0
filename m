Date: Thu, 11 Feb 1999 16:33:18 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: PowerBook G3 Series kbd patch
Message-Id: <19990211163318.028314@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here's a quick patch that remaps the "Fn" key of the Powerbook G3 Series
keyboard to an unused keycode (actually 0x7e). I'll post clean
vger-related patches later (when vger is back), this one is relative to
Paul's rsync tree. (Paul:You may want to include it now, I don't think it
breaks anything).
The original keycode of this key is 63, and conflicts with the buttons
emulation of Xpmac.


--- linux.orig/drivers/macintosh/mac_keyb.c	Tue Jan 26 00:18:30 1999
+++ linux.dev/drivers/macintosh/mac_keyb.c	Tue Feb  9 22:39:18 1999
@@ -322,6 +322,9 @@
 	/* on the powerbook 3400, the power key gives code 0x7e */
 	if (keycode == 0x7e)
 		keycode = 0x7f;
+	/* remap the "Fn" key of the PowerBook G3 Series to 0x7e */
+	if (keycode == 0x3f)
+		keycode = 0x7e;
 
 #ifdef CONFIG_ADBMOUSE
 	/*


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
