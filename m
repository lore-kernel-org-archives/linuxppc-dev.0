Return-Path: <david.jander@protonic.nl>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0F7D62BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 22:59:52 +1100 (EST)
Received: from linux.local (linux.local [192.168.1.97])
	by protonic.xs4all.nl (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id
	84ECBD4057 for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 12:49:17 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Date: Thu, 30 Dec 2004 12:59:48 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412301259.49177.david.jander@protonic.nl>
Subject: SMC/SCC uart problem with MPC852T
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

I have been searching for a way to do the BRG routing to SCC3 and SCC4 on the 
MPC852T, so that BGR3 is routed to SCC3 and SMC1 and BRG4 to SCC4. I could 
not find anything in the kernel (CVS linux_2_4_devel from DENX) to do this.
I think I also need a special ucode-patch, but I don't know where to look for 
it either.
Right now SMC1 works as serial console (115200 baud).
The kernel says this:
...
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0200 is on SCC3 using BRG2
ttyS2 at 0x0300 is on SCC4 using BRG3
...
IMHO this can't be right. At least not for the MPC852T.
If I connect a device to ttyS1 or ttyS2, it seems to work OK though, but if I 
connect the respective RX pin directly to the corresponding TX pin, strange 
things begin to happen. /proc/interrupt counts skyrocket, and I get a lot of 
repeated data back from the serial port. It looks like as if CPM buffers 
overlap or something like that.

Searching on Google I was able to find these boot-messages from someone using 
an MPC852T:

....
CPM UART driver version 0.03
ttyS0 at 0x0280 is on SMC1 using BRG3 - SMC1/SCC3/I2C/SPI Patch enabled
ttyS1 at 0x0200 is on SCC3 using BRG3
ttyS2 at 0x0300 is on SCC4 using BRG4
....

That looks a lot better, but I wonder how he accomplished this? What's that 
"SMC1/SCC3/I2C/SPI Patch" ? Where do I get it from?

Greetings,

-- 
David Jander
Protonic Holland.
