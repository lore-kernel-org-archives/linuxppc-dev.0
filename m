Date: Fri, 8 Dec 2000 18:42:28 +0100
From: Andi Kleen <ak@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH,workaround] Random device feed for input layer
Message-ID: <20001208184228.B23357@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On machines that use the input layer (like the ibook) the random device was never
refilled.  The following hacky patch fixes it at least for keyboard input. The input layer
maintainer has a more complete fix that also handles other events.


--- linux-pmac-stable/drivers/usb/input.c-o	Mon Oct  2 01:15:38 2000
+++ linux-pmac-stable/drivers/usb/input.c	Wed Feb 10 21:10:07 1904
@@ -89,6 +89,8 @@
 					del_timer(&dev->timer);
 			}

+			add_keyboard_randomness(code | (value & 1));
+
 			break;

 		case EV_ABS:





-Andi


P.S.: Is anybody working on putting the Ibook into suspend mode on Linux ?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
