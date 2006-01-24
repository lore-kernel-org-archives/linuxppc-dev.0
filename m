Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76C57681BD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jan 2006 19:26:33 +1100 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0O8QM8A030230
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jan 2006 09:26:22 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx008.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0O8QGq4030145
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jan 2006 09:26:17 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Trouble with SMC serial port in ppc/boot/simple on Embedded Planet
	8248 board
MIME-Version: 1.0
Date: Tue, 24 Jan 2006 09:26:14 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601240926.14408.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

(First of all, this is a repost of a mail I sent yesterday for which I haven't 
received a copy from the mailing list and which does not appear in the 
archives. If the mail hasn't been dropped, sorry for the duplicate).

I'm trying to port the Linux kernel (2.6.15.1) to the Embedded Planet 8248 
board. The board has a proprietary boot loader and uses SMC1 has a serial 
console.

After some work (2.6.15.1 has a nasty bug related to relocation which has been 
fixed in the git tree), I have been able to load and start the kernel image.

Unfortunately, the early serial output is lost. Here is the kernel boot 
messages I get with 2.6.15.1 :

-----------------------------------------------------------------------------
Embedded Planet EP8248 PowerPC port
Built 1 zonelists
Kernel command line: console=ttyCPM0,9600n8 root=/dev/ram0 rw
PID hash table entries: 4096 (order: 12, 65536 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 777088k available (1520k kernel code, 440k data, 96k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
-----------------------------------------------------------------------------

And here is the same with the modified 2.6.10-pre3 kernel shipped with the 
board:

-----------------------------------------------------------------------------
loaded at:     00200000 002D01E8
relocated to:  00400000 004D01E8
board data at: 004CE12C 004CE168
relocated to:  0040509C 004050D8
zimage at:     00405A31 004CD2C4
avail ram:     004D1000 01000000

Linux/PPC load: console=ttyCPM0,9600n8 root=/dev/ram0 rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.10-rc3 (laurent@pclaurent) (gcc version 3.4.1) #5 Thu Jan 19 
15:25:42 CET 2006
Embedded Planet EP8248 PowerPC port
Built 1 zonelists
[...]
-----------------------------------------------------------------------------

Early boot messages (printed with puts in ppc/boot/simple/misc-embedded.c) are 
lost.

I compared the Embedded Planet kernel with the 2.6.10-rc3 from kernel.org, 
haven't seen any big change related to the SMC serial port. Embedded Planet 
uses BRGC7 instead of BRGC1 for SMC1, but that didn't work better for me.

I of course enabled the RS232 transceivers in the board control and status 
registers (BCSR).

Could anyone give me any pointer to where I should look at ?

Thanks in advance,

Laurent Pinchart
