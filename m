Message-ID: <3A35DC82.7250A663@wtal.de>
Date: Tue, 12 Dec 2000 09:06:26 +0100
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sound on an iBook?
References: <3A3490B9.ECA71E0D@wtal.de> <19341105063039.15551@192.168.1.2>
Content-Type: multipart/mixed;
 boundary="------------4FA69D0C1CA6ADA4A2C3CE84"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------4FA69D0C1CA6ADA4A2C3CE84
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

> No you can't. Darwin is using a different licence that is not compatible
> with the GPL. You can "use" the Apple code as a reference to how the
> hardware works, but you can't re-use it "as is".

Ok. Understood. I vaguely remember RMStallman warning of the apple source
license.
Another time to reimplement the wheel.

Here is a port of the unofficial hack to 2.4. It works well for me (booting via
OF without Apple OS).
Volume setting still needs to be resolved. I'll try it via linux' IIC layer.

Christof


--------------4FA69D0C1CA6ADA4A2C3CE84
Content-Type: text/plain; charset=us-ascii;
 name="iBook_Sound_2.4.diff"
Content-Disposition: inline;
 filename="iBook_Sound_2.4.diff"
Content-Transfer-Encoding: 7bit

--- dmasound_awacs.c.orig	Mon Dec 11 22:35:59 2000
+++ dmasound_awacs.c	Mon Dec 11 22:49:24 2000
@@ -1978,7 +1978,7 @@
 		 * with a child called "sound".
 		 */
 		struct device_node *sound;
-		np = find_devices("davbus");
+		np = find_devices("i2s-a");
 		sound = find_devices("sound");
 		if (sound != 0 && sound->parent == np) {
 			unsigned int *prop, l, i;
@@ -2029,8 +2029,9 @@
 		int vol;
 		dmasound.mach = machPMac;

-		awacs = (volatile struct awacs_regs *)
-			ioremap(np->addrs[0].address, 0x80);
+		/* awacs = (volatile struct awacs_regs *)
+			ioremap(np->addrs[0].address, 0x80); */
+		awacs = kmalloc(sizeof(struct awacs_regs),GFP_KERNEL);
 		awacs_txdma = (volatile struct dbdma_regs *)
 			ioremap(np->addrs[1].address, 0x100);
 		awacs_rxdma = (volatile struct dbdma_regs *)

--------------4FA69D0C1CA6ADA4A2C3CE84--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
