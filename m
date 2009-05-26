Return-Path: <fredrik.arnerup@edgeware.tv>
Received: from mail.edgeware.tv (mail.edgeware.tv [82.99.7.138])
	by ozlabs.org (Postfix) with ESMTP id 55232DDFEE
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 18:28:47 +1000 (EST)
Received: from edgeware48 (unknown [192.168.99.245])
	by mail.edgeware.tv (Postfix) with ESMTPSA id 1AC4851B609B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 10:18:34 +0200 (CEST)
From: "Fredrik Arnerup" <fredrik.arnerup@edgeware.tv>
To: <linuxppc-dev@ozlabs.org>
Subject: MPC85xx erratum "I2C1 - I2C controller is unable to generate clocks
	when SDA is low coming out of reset"
Date: Tue, 26 May 2009 10:22:21 +0200
Message-ID: <738D541FBC1741A18DB4F3CB466DF78A@edgeware.tv>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We've had some trouble with I2C not working after a soft reboot,
which we think is due to the the erratum "I2C1" which is present in
at least the mpc8540 and the mpc8560. Since there is no good workaround,
the only choice seems to be to avoid resetting the CPU while the I2C bus is
busy.

The problem seems to be that the i2c-mpc driver leaves I2C in a busy state
when
it receives a signal (e.g. upon shutdown).
The code below is not meant as a patch, just me thinking aloud.
Thoughts?

/Fredrik Arnerup
fredrik.arnerup@edgeware.tv

Index: drivers/i2c/busses/i2c-mpc.c
===================================================================
--- drivers/i2c/busses/i2c-mpc.c        (revision 6933)
+++ drivers/i2c/busses/i2c-mpc.c        (working copy)
@@ -262,12 +262,14 @@
        /* Allow bus up to 1s to become not busy */
        while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
                if (signal_pending(current)) {
-                       pr_debug("I2C: Interrupted\n");
-                       writeccr(i2c, 0);
+                       printk(KERN_WARNING "I2C: Interrupted\n");
+                       if (readb(i2c->base + MPC_I2C_SR) ==
+                           (CSR_MCF | CSR_MBB | CSR_RXAK))
+                               mpc_i2c_fixup(i2c);
                        return -EINTR;
                }
                if (time_after(jiffies, orig_jiffies + HZ)) {
-                       pr_debug("I2C: timeout\n");
+                       printk(KERN_WARNING "I2C: mpc_xfer() timeout\n");
                        if (readb(i2c->base + MPC_I2C_SR) ==
                            (CSR_MCF | CSR_MBB | CSR_RXAK))
                                mpc_i2c_fixup(i2c);
