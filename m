Return-Path: <chi@artesyncp.com>
Received: from bifrost.spider.com (caly80.spider.com [194.217.109.12])
	by ozlabs.org (Postfix) with SMTP id 8B9BA67B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 21:19:11 +1000 (EST)
Received: from heimdall-dmz.spider.com (mailhub.spider.com [212.240.99.13])
	by caly80.spider.com (Postfix) with SMTP id 026276F57
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 12:01:30 +0100 (BST)
Message-ID: <797470E884C6D611B7A500B0D0AA56D0F195AE@batistuta.spider.com>
From: "Tsang, Chi Kit" <chi@artesyncp.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 13 Apr 2005 12:01:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: cpm_uart console problems?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am working on an 8260 based board and currently cannot get 
the serial (running on SMC 1) to work using the 2.6.11 kernel. 
The last message I see in my console is: "Now booting the 
kernel".

I currently use NFS root for mounting the root filesystem. 
Despite not seeing any output from the serial console, the 
board does actually boot up and I can telnet in okay. Here is 
what I see in:

/proc/interrupts:

CPU0
4: 0 CPM2 SIU Edge cpm_uart
32: 23184 CPM2 SIU Edge fenet
BAD: 793

/proc/devices:

Character devices:
1 mem
2 pty
3 ttyp
4 /dev/vc/0
4 tty
5 /dev/tty
5 /dev/console
5 /dev/ptmx
7 vcs
10 misc
13 input
128 ptm
136 pts
204 ttyCPM
254 devfs

Block devices:

There are no block devices installed.

In /dev, I see:

crw--w--w- 1 root root 204, 46 Jan 1 00:32 ttyCPM0

And when I do "dmesg", I see:

...
...
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a80 (irq = 4) is a CPM UART
...
...

I currently do not specify the "console=ttyCPM" in my boot command 
line. Would this be an issue?

I have tried to add "console=ttyCPM" to my boot command line but in 
such cases, the kernel would fail to boot. Using some LEDs as debug, 
I tracked down the hang which seems to happen during cpm_uart_console_write.
This is as far as I got.

I am running with devfs enabled in the kernel. Does the cpm_uart 
driver work with devfs?

As an aside, I have ported the 2.6.5 kernel to my 8260 based board and
both ethernet (FCC 1) and serial (SMC 1) worked okay using this particular
kernel.

Any suggestions/ideas would be much appreciated.

Thanks,
Chi
