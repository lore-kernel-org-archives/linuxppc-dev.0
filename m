Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 6C84F67B1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 05:58:05 +1000 (EST)
Received: from zaphod.acdstar.com (zaphod.int.acdstar.com [192.168.2.100])
	by mail.acdstar.com (8.13.0/8.13.0) with ESMTP id j3CJfWDj006119
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Apr 2005 14:41:32 -0500
Message-Id: <6.2.1.2.1.20050412143653.02ae7720@mail.int.acdstar.com>
Date: Tue, 12 Apr 2005 14:38:20 -0500
To: linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: (no subject)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone been able to use an I2S audio DAC connected to a Programmable 
Serial Controllers (PSC) on the Freescale MPC5200 CPU working under Linux?

The kernel included in the DENX ELDK v3.1.1 has two drivers:
   i2s_ring.c and i2s.c.
The ring driver appears to be RX only, and the i2s.c driver causes the FEC 
ethernet to hang at startup.  I've read some previous mailing list messages 
that suggest there are issues with bestcomm and i2s support.

We've tried adapting the i2s_ring.c driver for our needs.  By default, it 
only has a receive task.  It partially initializes the port, and we see 
appropriate waveforms on the MCLK, CLK, and FRAME lines, but have not been 
able to transmit data.

The stock i2s.c driver hung the boot sequence, but if we comment out the 
bestcomm startup code, it at least completes the boot cycle.  Again we see 
appropriate waveforms on the MCLK, CLK, and FRAME lines.  If we feed data 
to the device (after performing the port setup IOCTLs), we see a 750 us 
burst of data every 45 ms or so.

Is it feasible to send 44.1 or 48 KHz 16-bit audio this way or is the PSC 
only usable for lower data rate applications?

Thank you,
Eric
------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
