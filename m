Subject: Hardware lockup with freescale i2c-mpc driver/2.4?
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="=-gdZDwibBApxLs+Y9TvMY"
Message-Id: <1089036206.6006.27.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 05 Jul 2004 16:03:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-gdZDwibBApxLs+Y9TvMY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've witnessed some strange behaviour using i2c-mpc.[ch].
It started when I compiled some i2c client drivers into the kernel.

After booting once, the SDA line gets stuck low.
It's probably held by one of the i2c slaves,
because a power-cycle is required to release SDA.
But even the procedure described in the manual under "Generation of SCL
when SDA Low", (which apparently is also what mpc_i2c_reset() does)
causes no change on SCL/SDA when executed with the BDI2000.

The interesting thing is, that the problem went away when I added
a printk() on top of mpc_i2c_reset (seems to be pretty normal for
this function to get called during the bus scan, btw).

So I figured that if it's about the delay introduced by printk(),
the same effect could be gained by simply putting the delay first
in the loop, and this apparently works pretty well (no lockup since).

Now I'm looking for an explanation why ;)


--
Stefan Nickl
Kontron Modular Computers


--=-gdZDwibBApxLs+Y9TvMY
Content-Disposition: attachment; filename=i2c-mpc_resetflip.patch
Content-Type: text/x-patch; name=i2c-mpc_resetflip.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- i2c-mpc.c.old	2004-07-05 15:56:00.000000000 +0200
+++ i2c-mpc.c	2004-07-05 15:45:50.000000000 +0200
@@ -274,9 +274,9 @@
 		 * We only support being the master here, and all
 		 * transactions should be done.  Reset, and hope
 		 * that fixes it */
-		mpc_i2c_reset(priv);
-
 		schedule_timeout(delaytime);
+
+		mpc_i2c_reset(priv);
 	}

 	set_current_state(TASK_RUNNING);

--=-gdZDwibBApxLs+Y9TvMY--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
