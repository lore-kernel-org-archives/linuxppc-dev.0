Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id C3300DDDDF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 03:24:52 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Erratic MPC8248 CPM2 I2C behaviour
Date: Fri, 28 Nov 2008 17:24:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811281724.49620.laurentp@cse-semaphore.com>
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

I've been struggling with a weird CPM2 I2C behaviour for the past few days 
without much success.

Some background first. The platform is an MPC8248 (HiP7 Rev 14, Mask 1.0 
1K50M) system with an I2C bus on which two peripherals are connected. Back to 
the ppc architecture days, Heiko Schocher's i2c-mpc8260 out of tree driver 
worked like a charm.

After switching to the powerpc architecture and Jochen Friedrich's driver, 
I've experienced erratic transfer timeouts. Quite frequent at first (2.6.26), 
the problems disappeared on the road to 2.6.27 and have now resurfaced.

As the problem never occured with a ppc kernel I'm pretty sure we can rule out 
hardware issues. Bad hardware initialisation (either in U-Boot or in the Linux 
kernel) is possible but in my opinion very unlikely, as timeouts occur about 
once every 5 boots at most.

I've added debugging messages to the i2c-cpm driver to track down the issue. 
Here's a sample successful I2C transaction (1 byte write followed by 1 byte 
read) with comments inlined:

-----------------------------------------------------------------------------
> R: 0 T: 0
> Parsing write message (addr 0x90 len 1)
> R: 0 T: 1
> Parsing read message (addr 0x91 len 1)

The two messages making up the transaction are parsed. The driver fills a TX 
buffer descriptor for the first one, and a TX and an RX buffer descriptor for 
the second one.

> IRQ 0 - 00 00 00 00 00 00 00 00

No I2C IRQ occured so far, more on this later.

> rbase 0x01e0 tbase 0x01c0 rfcr 0x30 tfcr 0x30 mrblr 0x0201
> rstate 0x00000000 rptr 0x00000000 rbptr 0x01e0 rcount 0x0000 rtmp 0x00000000
> tstate 0x00000000 tptr 0x00000000 tbptr 0x01c0 tcount 0x0000 ttmp 0x00000000
> i2mod 0x00, i2add 0xfe i2brg 0x03 i2com 0x01 i2cer 0x00 i2cmr 0x00
> rx 0 sc 0x9000 tx 0 sc 0x9400
> rx 1 sc 0x7da4 tx 1 sc 0xac00
> rx 2 sc 0xefef tx 2 sc 0x743b
> rx 3 sc 0xf264 tx 3 sc 0x10e6

I2C controller registers and buffer descriptors state dump.

> Waiting on message 0.

The driver waits with wait_event_interruptible_timeout() for the end of the 
first message.

> IRQ 2 - 02 01 00 00 00 00 00 00

Two I2C interrupts occured, one for each message.

> rbase 0x01e0 tbase 0x01c0 rfcr 0x30 tfcr 0x30 mrblr 0x0201
> rstate 0x30000000 rptr 0x03905001 rbptr 0x01e8 rcount 0x0200 rtmp 0x00000000
> tstate 0x30000000 tptr 0x03920002 tbptr 0x01c0 tcount 0x0000 ttmp 0x91000000
> i2mod 0x01, i2add 0xfe i2brg 0x03 i2com 0x01 i2cer 0x00 i2cmr 0x13
> rx 0 sc 0x1800 tx 0 sc 0x1400
> rx 1 sc 0x7da4 tx 1 sc 0x2c00
> rx 2 sc 0xefef tx 2 sc 0x743b
> rx 3 sc 0xf264 tx 3 sc 0x10e6
> Message 0 completed.
> tx sc 0x1400
> Waiting on message 1.
> IRQ 2 - 02 01 00 00 00 00 00 00
> rbase 0x01e0 tbase 0x01c0 rfcr 0x30 tfcr 0x30 mrblr 0x0201
> rstate 0x30000000 rptr 0x03905001 rbptr 0x01e8 rcount 0x0200 rtmp 0x00000000
> tstate 0x30000000 tptr 0x03920002 tbptr 0x01c0 tcount 0x0000 ttmp 0x91000000
> i2mod 0x01, i2add 0xfe i2brg 0x03 i2com 0x01 i2cer 0x00 i2cmr 0x13
> rx 0 sc 0x1800 tx 0 sc 0x1400
> rx 1 sc 0x7da4 tx 1 sc 0x2c00
> rx 2 sc 0xefef tx 2 sc 0x743b
> rx 3 sc 0xf264 tx 3 sc 0x10e6
> Message 1 completed.
> tx sc 0x2c00, rx sc 0x1800

Both message have been successfully transmitted.
-----------------------------------------------------------------------------

I've rebooted the system, and the same transaction failed:

-----------------------------------------------------------------------------
> R: 0 T: 0
> Parsing write message (addr 0x90 len 1)
> R: 0 T: 1
> Parsing read message (addr 0x91 len 1)
> IRQ 0 - 00 00 00 00 00 00 00 00
> rbase 0x01e0 tbase 0x01c0 rfcr 0x30 tfcr 0x30 mrblr 0x0201
> rstate 0x00000000 rptr 0x00000000 rbptr 0x01e0 rcount 0x0000 rtmp 0x00000000
> tstate 0x00000000 tptr 0x00000000 tbptr 0x01c0 tcount 0x0000 ttmp 0x00000000
> i2mod 0x00, i2add 0xfe i2brg 0x03 i2com 0x01 i2cer 0x00 i2cmr 0x00
> rx 0 sc 0x9000 tx 0 sc 0x9400
> rx 1 sc 0x7da4 tx 1 sc 0xac00
> rx 2 sc 0xeeef tx 2 sc 0x74bb
> rx 3 sc 0x7264 tx 3 sc 0x50e6
> Waiting on message 0.
> IRQ 0 - 00 00 00 00 00 00 00 00
> rbase 0x01e0 tbase 0x01c0 rfcr 0x30 tfcr 0x30 mrblr 0x0201
> rstate 0x00000000 rptr 0x00000000 rbptr 0x01e0 rcount 0x0000 rtmp 0x00000000
> tstate 0x30e00000 tptr 0x03914002 tbptr 0x01c0 tcount 0x0001 ttmp 0x90010000
> i2mod 0x01, i2add 0xfe i2brg 0x03 i2com 0x01 i2cer 0x00 i2cmr 0x13
> rx 0 sc 0x9000 tx 0 sc 0x9400
> rx 1 sc 0x7da4 tx 1 sc 0xac00
> rx 2 sc 0xeeef tx 2 sc 0x74bb
> rx 3 sc 0x7264 tx 3 sc 0x50e6
> Message 0 timed out

Transmission timeout after one second. The first TX buffer descriptor status 
hasn't been modified by the CPM. The CPM state dump shows that processing of 
the first TX buffer has started, but the CPM stopped after the first byte 
(tcount is equal to 0x0001 and ttmp contains the 2 bytes to be transmitted). I 
assume the first byte has been written by the CPM to the I2C controller's 
register. Processing then stopped for an unknown reason.

> cpm_i2c_force_close()
-----------------------------------------------------------------------------

While trying to debug the issue I've added a dev_dbg() in the I2C interrupt 
handler. With that function being called by the interrupt handler I haven't 
been able to reproduce the problem. I thus removed the dev_dbg() call and 
replaced that with an interrupt counter and a table storing the first 8 
interrupts events, and printed all those information outside the interrupt 
handler after wait_for_event_interruptible.

Timing issues come to mind, but what I've found really puzzling is that the 
above log shows that the interrupt handler hasn't been called at all 
(confirmed by /proc/interrupts). Why would a call to dev_dbg() in a function 
that is never called modify execution timings ? This might just be a 
coincidence.

Has anyone run into the same kind of problem with the CPM2 I2C controller ? 
All help will really be appreciated.

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
