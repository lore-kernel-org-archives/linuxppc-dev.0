Return-Path: <richard.danter@ntlworld.com>
Received: from queue01-winn.ispmail.ntl.com (queue01-winn.ispmail.ntl.com
	[81.103.221.55]) by ozlabs.org (Postfix) with ESMTP id 346EA687BB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 23:07:44 +1100 (EST)
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
	by mta08-winn.ispmail.ntl.com with ESMTP id
	<20051122102037.ZIAD17804.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 10:20:37 +0000
Received: from [192.168.1.10] (really [82.4.184.52])
	by aamta09-winn.ispmail.ntl.com with ESMTP id
	<20051122102037.WWBS1233.aamta09-winn.ispmail.ntl.com@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 10:20:37 +0000
Message-ID: <4382F0F2.4040807@ntlworld.com>
Date: Tue, 22 Nov 2005 10:20:34 +0000
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Trying to understand initsenses and pci_irq_table
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

I am trying to port a 2.6.14.2 kernel to a 74xx/107 board and am having 
some problems which I think may be interrupt related. I have based my 
board support on the Sandpoint but realise that I do not really 
understand the initsenses or pci_irq_table structures and was hoping 
someone could either explain it or point me in the direction of some docs.

So far the kernel does boot and mount a NFS root filesystem, but crashes 
soon after. Whilst it boots the serial is very slow. It is at 9600 baud 
as expected, but it seems the characters are being spaced out in time 
which makes me think the serial is running in a polled mode rather than 
interrupt driven.

The board is very simple. There are several versions and the one I am 
working on now has a 7400 CPU, a 107 mem controller, a couple of PCI 
slots, serial port and some LED's.

Interrupts A, B, C and D from the PCI slots are connected to IRQ 0..3 on 
the 107. The serial port chip (16550 compatible) is wired directly to 
IRQ 4. There are no other PIC's or any other logic to confuse things.

U-Boot is running just fine and shows the following when I use the "pci" 
command:

Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1057     0x0004     Bridge device           0x00
00.10.00   0x8086     0x1030     Network controller      0x00
00.12.00   0x1011     0x0026     Bridge device           0x04


How should these be mapped with the structures in the kernel?

The fact that NFS seems to be working and that the network card 
(EEPRO100) says it is using IRQ 16 is just pure luck I think!

The kernel crashes after starting init. I see some random characters on 
the serial and then nothing. Looking in the log buffer via JTAG I can 
see that the init process exited with signal 11. I assume this is 
unrelated to the above, but any suggestions where I should look?

Many thanks,
Rich
