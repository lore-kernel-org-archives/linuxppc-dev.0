Return-Path: <carolyn.j.smith@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 46CB82BD46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Oct 2004 07:18:10 +1000 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id i9RL61sP029429
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 14:06:01 -0700 (PDT)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.11.7p1+Sun/8.11.7) with SMTP id i9RL60X17415
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 14:06:00 -0700 (PDT)
Message-ID: <212D7E61C1F7D511B9270002A507DE7D07AB3974@us-bv-m10.bv.tek.com>
From: carolyn.j.smith@exgate.tek.com
To: linuxppc-embedded@ozlabs.org
Date: Wed, 27 Oct 2004 14:05:59 -0700
MIME-Version: 1.0
Content-Type: text/plain
Subject: Machine check in USB driver interrupt handler on 8xx board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am porting a USB (Philips ISP116x) driver to an 8xx (852T in particular)
board. It is built into the kernel at the moment (i.e. it isn't a loadable
module) and comes up fine and gets and handles interrupts (at least 2400 of
them) while the rest of the kernel is initializing.

Just before the kernel is completely up, after the message "Freeing unused
kernel memmory ...", I get a machine check in the driver's interrupt
handler, in particular on a write to the command port register. 

The ISP116x has only 2 16-bit registers which are memory mapped to 2 16-bit
words in the phyiscal address space 0xfa000000 and 0xfa000002 and then
ioremap'ed to kernel address space when the driver starts up. That seems to
be working fine up until the machine check occurs.

I am baffled and don't know where to look next. Any ideas / suggestions will
be gratefully received.

Carolyn Smith
Tektronix, Inc.
