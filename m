Subject: Master receiver issue with freescale i2c-mpc driver/2.4?
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1089036206.6006.27.camel@lucy.pep-kaufbeuren.de>
References: <1089036206.6006.27.camel@lucy.pep-kaufbeuren.de>
Content-Type: multipart/mixed; boundary="=-doRREtzn8e4LDGXYjHh+"
Message-Id: <1089214061.6003.28.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 17:27:41 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-doRREtzn8e4LDGXYjHh+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Found another strangeness with this driver:

If I get I2C right (I might be severely misguided here),
when watching a master receive data from a slave transmitter,
all the incoming data will be ACKed by the master, except
for the last data byte, where SDA is supposed to be high during
the 9th cycle.
What I'm referring to is this part of the ST M4181 RTC manual (p9):

-------------------------------------------------------
The device that acknowledges has to pull down
the SDA line during the acknowledge clock pulse
in such a way that the SDA line is a stable Low during
the High period of the acknowledge related
clock pulse. Of course, setup and hold times must
be taken into account. A master receiver must signal
an end of data to the slave transmitter by not
generating an acknowledge on the last byte that
has been clocked out of the slave. In this case the
transmitter must leave the data line High to enable
the master to generate the STOP condition.
-------------------------------------------------------

But what I saw was a low SDA during *all* the ACK cycles,
until I did what's in the patch.
It's working, plus what I see on the LA looks much better now.

PS: Is Kumar on holiday or am I just getting on his nerves? ;)

PPS: If anyone's interested in drivers for the Microchip
     EEPROMs with 2 byte addressing and that ST RTC, don't
     hesitate to ask.

--
Stefan Nickl
Kontron Modular Computers


--=-doRREtzn8e4LDGXYjHh+
Content-Disposition: attachment; filename=i2c-mpc_resetflip_txak.patch
Content-Type: text/x-patch; name=i2c-mpc_resetflip_txak.patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- i2c-mpc.c.old	2004-07-05 15:56:00.000000000 +0200
+++ i2c-mpc.c	2004-07-07 15:26:43.000000000 +0200
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
@@ -303,6 +303,8 @@

 		/* If there is only one byte, we need to TXAK now */
 		if(len == 1)
+			priv->write(&regs->i2ccr, MPC_I2CCR_TXAK, MPC_I2CCR_TXAK);
+		else
 			priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);

 		/* Do a dummy read, to initiate the first read */
@@ -321,7 +323,7 @@
 			/* If this is the 2nd to last byte, send
 			 * the TXAK signal */
 			if(i == len - 2) {
-				priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);
+				priv->write(&regs->i2ccr, MPC_I2CCR_TXAK, MPC_I2CCR_TXAK);
 			}

 			/* If this is the last byte, send STOP */

--=-doRREtzn8e4LDGXYjHh+--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
