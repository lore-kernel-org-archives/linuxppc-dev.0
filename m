Return-Path: <michael@evidence.eu.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 56684B70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 23:49:02 +1000 (EST)
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by ozlabs.org (Postfix) with ESMTP id 38071DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 23:49:00 +1000 (EST)
Date: Fri, 19 Jun 2009 14:50:02 +0200
From: Michael Trimarchi <michael@evidence.eu.com>
To: jochen@scram.de
Subject: [RFC] Fix stuck on cpm-i2c driver
Message-ID: <20090619125002.GA17067@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bruno@evidence.eu.com, trimarchi@gandalf.sssup.it,
	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a process tries to read/write a disconnected i2c device, it receives a signal (e.g. ctrl-c) and the kernel gets stuck.

BUG: soft lockup - CPU#0 stuck for 61s! [I2CEEpromTest:392]
NIP: c01628f8 LR: c01628f0 CTR: c00177cc
REGS: c39abd70 TRAP: 0901   Not tainted  (2.6.25.7-alcore)
MSR: 00009032 <EE,ME,IR,DR>  CR: 42042048  XER: 20000000
TASK = c3889bd0[392] 'I2CEEpromTest' THREAD: c39aa000
GPR00: 00009000 c39abe20 c3889bd0 c39075c8 c39abe28 00000001 00000000 00000001
GPR08: c3889bd0 c39075c8 00009032 c39abe34 00002437
NIP [c01628f8] cpm_i2c_xfer+0x5fc/0x6d0
LR [c01628f0] cpm_i2c_xfer+0x5f4/0x6d0
Call Trace:
[c39abe20] [c0162924] cpm_i2c_xfer+0x628/0x6d0 (unreliable)
[c39abe90] [c015f6a0] i2c_transfer+0x88/0xb4
[c39abeb0] [c0160164] i2c_master_recv+0x48/0x6c
[c39abed0] [c01618dc] i2cdev_read+0x50/0xe4
[c39abef0] [c0068b24] vfs_read+0xc4/0x108
[c39abf10] [c0068f4c] sys_read+0x4c/0x90
[c39abf40] [c000d348] ret_from_syscall+0x0/0x38
Instruction dump:
3bc00064 92610010 3bf201c8 92810014 3b61

This happen because though the wait_event_interruptible_timeout takes the
signals into account, the driver does not handle them.
We propose to change the wait_event_interruptible_timeout with
wait_event_timeout, leaving the signals to be handled in other points
on the upper layers.

Signed-off-by: Bruno Morelli <bruno@evidence.eu.com>
Signed-off-by: Michael Trimarchi <michael@evidence.eu.com>
---
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index b5db8b8..9c2e100 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -140,7 +140,7 @@ static irqreturn_t cpm_i2c_interrupt(int irq, void *dev_id)

 	dev_dbg(&adap->dev, "Interrupt: %x\n", i);

-	wake_up_interruptible(&cpm->i2c_wait);
+	wake_up(&cpm->i2c_wait);

 	return i ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -364,12 +364,12 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		dev_dbg(&adap->dev, "test ready.\n");
 		pmsg = &msgs[tptr];
 		if (pmsg->flags & I2C_M_RD)
-			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
+			ret = wait_event_timeout(cpm->i2c_wait,
 				(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_NAK) ||
 				!(in_be16(&rbdf[rptr].cbd_sc) & BD_SC_EMPTY),
 				1 * HZ);
 		else
-			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
+			ret = wait_event_timeout(cpm->i2c_wait,
 				!(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_READY),
 				1 * HZ);
 		if (ret == 0) {
