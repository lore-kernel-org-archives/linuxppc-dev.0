Return-Path: <david.jander@protonic.nl>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 4DC192BF16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 20:52:11 +1100 (EST)
Received: from linux.local (linux.local [192.168.1.97])
	by protonic.xs4all.nl (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id
	43E16D4052 for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 10:41:10 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 12 Jan 2005 10:51:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200501121051.58953.david.jander@protonic.nl>
Subject: MPC8xx: Using SCM/SCC and standard 16C550 Uarts together...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

The situation is:
Our custom board needs to use SCM1 as console, and has an external quad uart 
chip (16C554) connected to the external bus, mapped at 0xf8100000.
I am using the ppclinux_2_4_devel tree from Denx.
I ioremapped that address space, and it seems to work. Right now I don't have 
the daughterboard with the quad-uarts working (as in hardware), so I can't 
fully test that.

The problem is:
Apparently arch/ppc/8xx_io/uart.c doesn't take into account other serial 
drivers that may initialize later, and uses a serial_state struct statically.
Shouldn't this be visible to the outside? Shouldn't there be a global 
serial_state structure somewhere that lists all serial ports?
Right now, I get this:

-----------------------------------
...
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0200 is on SCC3 using BRG2
ttyS2 at 0x0300 is on SCC4 using BRG3
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ enabled
...
VFS: Mounted root (jffs2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 56k init
------------------------------------

And then nothing more. I assume, at that point init opens /dev/console (ttyS0) 
and that device doesn't exist, since drivers/char/serial.c doesn't detect any 
uart at the moment.
If it did, maybe I would get console stuff out of the first 16c554 port.

Has anybody else tried this?
What would be the right way to fix this?

Greetings,

-- 
David Jander
Protonic Holland.
