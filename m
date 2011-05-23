Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2887DB6FBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 06:41:09 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4NKTV4h025640
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2011 14:29:31 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p4NKevGh150560
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2011 14:40:57 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4NKeudT002502
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2011 14:40:57 -0600
Date: Mon, 23 May 2011 16:42:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Muhammad Waseem <vasim98@gmail.com>
Subject: Re: Fwd: UART #1 access on Sequoia board
Message-ID: <20110523204208.GA28540@zod.rchland.ibm.com>
References: <BANLkTims8CrK6s0bJZPBt3jTDRDKzg2e-A@mail.gmail.com>
	<20110523124035.GJ25179@zod.rchland.ibm.com>
	<BANLkTin5TyfdfNDfXokDdtdpDmnoRQ6aAA@mail.gmail.com>
	<BANLkTikvmy-bkckgxyQttoKQqkuNUd2+5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikvmy-bkckgxyQttoKQqkuNUd2+5g@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 24, 2011 at 12:22:14AM +0500, Muhammad Waseem wrote:

Please don't top post.

>I am using kernel version 2.6.23 which came with the Sequoia support CD. So
>that means UART # 1 BSP would probably not there?  But device file
>/dev/ttyS1 is present in rootfs when listed using 'ls'. Do you think
>updating the kernel might solve the problem?

Not necessarily.  You can create device nodes on the rootfs without
anything being bound to them.  One of the easiest ways to see if
something discovered the serial port is to look in the boot output.  You
should see something like:

serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A                  
console [ttyS0] enabled, bootconsole disabled                                   
console [ttyS0] enabled, bootconsole disabled                                   
serial8250.0: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A                  
serial8250.0: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A                  
serial8250.0: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A   

or:

1ef600300.serial: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550               
1ef600400.serial: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550               
1ef600500.serial: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550               
1ef600600.serial: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550      

>BTW where can I see the board's DTS file?

arch/powerpc/boot/dts/sequoia.dts

josh
