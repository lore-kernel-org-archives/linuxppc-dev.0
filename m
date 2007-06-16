Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 5CC54DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jun 2007 19:56:41 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 10FD48780C6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jun 2007 02:27:43 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 57B6D8780B2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jun 2007 02:27:42 -0700 (PDT)
Message-ID: <4673AD08.1080800@gmail.com>
Date: Sat, 16 Jun 2007 14:57:36 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Regarding MPC8540 IRQ Issue 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All

I am working on MPC8540 board placing it in the PCI slot of the x86 system.
After system bootup , i could see the powerpc board detected and pci 
config space configured.
But i could not find any IRQ assigned for it.

SetUp:
Host: x86 System- Linux-2.6.9
HOST PCI Slot is 64-bit, 66MHz
Agent: MPC8540 Board.

Here is dump of "lspci -vx " for this device.

04:03.0 Power PC: Motorola MPC8540 (rev 20) (prog-if 01)
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Memory at dee00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [60] #00 [0000]
00: 57 10 08 00 46 01 b0 00 20 01 20 0b 00 40 00 00
10: 00 00 e0 de 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

 From the above dump - IRQ Pin & Line of config space shows zeroes.

I tried writing a small module and probing for IRQ generating a message 
interrupt. Though i could see in the 8540 message status register that 
interrupt is generated, i could not get any IRQ when i do the probe. For 
this trial,  i have configured the PIC message enable register, message 
vector/priority and destination registers, processor current task 
priority register (CPTR).

Can anyone give me some suggestions to try out.

Thanks
Sudheer
