Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F57DDE2C3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 20:15:53 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id n0F9Flq7048158
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:15:47 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n0F9Fkam2363494
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:15:46 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n0F9FjNs010678
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:15:46 GMT
Date: Thu, 15 Jan 2009 10:15:44 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] hvc_console: remove tty->low_latency
Message-ID: <20090115091544.GC895@cetus.boeblingen.de.ibm.com>
References: <hvc-console-29-3-1@bga.com>
	<200901131004.22609.borntraeger@de.ibm.com>
	<20090113113545.GB26819@cetus.boeblingen.de.ibm.com>
	<1998eda55e236b70f63c7fb4b956b487@bga.com>
	<1231880644.22571.47.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231880644.22571.47.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Joe Peterson <joe@skyrush.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 14, 2009 at 08:04:04AM +1100, Benjamin Herrenschmidt wrote:
> > So the simplest is to never set it.
> 
> I already applied your previous patch. Please send an incremental fix.
Here is the incremental patch for your powerpc tree along with a summary
as patch description.

Regards,
Hendrik

--
This patch removes the tty->low_latency setting.

For irq based hvc_console backends the tty->low_latency must be set to 0,
because the tty_flip_buffer_push() function must not be called from IRQ context
(see drivers/char/tty_buffer.c).

For polled backends, the low_latency setting causes the bug trace below, because
tty_flip_buffer_push() is called within an atomic context and subsequent calls
might sleep due to mutex_lock.

BUG: sleeping function called from invalid context at /root/cvs/linux-2.6.git/kernel/mutex.c:207
in_atomic(): 1, irqs_disabled(): 0, pid: 748, name: khvcd
1 lock held by khvcd/748:
 #0:  (hvc_structs_lock){--..}, at: [<00000000002ceb50>] khvcd+0x58/0x12c
CPU: 0 Not tainted 2.6.29-rc1git #29
Process khvcd (pid: 748, task: 000000002fb9a480, ksp: 000000002f66bd78)
070000000000000a 000000002f66ba00 0000000000000002 (null) 
       000000002f66baa0 000000002f66ba18 000000002f66ba18 0000000000104f08 
       ffffffffffffc000 000000002f66bd78 (null) (null) 
       000000002f66ba00 000000000000000c 000000002f66ba00 000000002f66ba70 
       0000000000466af8 0000000000104f08 000000002f66ba00 000000002f66ba50 
Call Trace:
([<0000000000104e7c>] show_trace+0x138/0x158)
 [<0000000000104f62>] show_stack+0xc6/0xf8
 [<0000000000105740>] dump_stack+0xb0/0xc0
 [<000000000013144a>] __might_sleep+0x14e/0x17c
 [<000000000045e226>] mutex_lock_nested+0x42/0x3b4
 [<00000000002c443e>] echo_char_raw+0x3a/0x9c
 [<00000000002c688c>] n_tty_receive_buf+0x1154/0x1208
 [<00000000002ca0a2>] flush_to_ldisc+0x152/0x220
 [<00000000002ca1da>] tty_flip_buffer_push+0x6a/0x90
 [<00000000002cea74>] hvc_poll+0x244/0x2c8
 [<00000000002ceb68>] khvcd+0x70/0x12c
 [<000000000015bbd0>] kthread+0x68/0xa0
 [<0000000000109d5a>] kernel_thread_starter+0x6/0xc
 [<0000000000109d54>] kernel_thread_starter+0x0/0xc
1 lock held by khvcd/748:
 #0:  (hvc_structs_lock){--..}, at: [<00000000002ceb50>] khvcd+0x58/0x12c

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -318,8 +318,6 @@ static int hvc_open(struct tty_struct *t
 	} /* else count == 0 */
 
 	tty->driver_data = hp;
-	if (!hp->irq_requested)
-		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
 
 	hp->tty = tty;
 
