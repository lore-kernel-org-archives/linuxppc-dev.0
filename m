Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav13.bay1.hotmail.com [65.54.244.117])
	by ozlabs.org (Postfix) with ESMTP id 6797E67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 19:55:35 +1100 (EST)
Message-ID: <BAY1-DAV1357D81F947F1A31523FE48B4F0@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Wed, 23 Mar 2005 14:25:57 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: question about writing to memory directly from user space in Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I am running Linux 2.6.10 on an MPC8260 target. We have an I2C controller
that is part of our application code. In VxWorks, we could address the
MPC8260 I2C memory registers directly from application space and so this was
not a problem.

To port this same code to Linux, I am opening '/dev/mem' and mmapping the
internal memory map of 128 KB to user space. I am writing directly to the
I2C_BASE, I2C PRAM and I2C RxBD/TxBD registers, all of which are in DPRAM,
from my application code through suitable macros.

All of this is fine. I can see that the values have been written to memory
if I do a memory dump of those registers with an external dump tool that
uses '/dev/mem' too.

Now, I have kept my Tx and Rx buffers in DPRAM as well, and have programmed
those addresses in the buffer pointers of my TxBD and RxBDs. However, I am
not sure if the values I'm writing to those locations from user space are
actually being written to the actual memory locations.

This is because I print the value of the first byte of my transmit buffer
pointer BEFORE and AFTER I write the I2C address (0xA0 for us) to it. Before
the address is written, the contents shown are 0x90. After it's written, the
contents are shown rightly as 0xA0, but I don't think this value is actually
written to DPRAM.

This is because when I start I2C transmission by setting the start transfer
bit in I2COM register, the address byte outputted on the I2C SDA bus is
0x90. This means it outputs the original value and not the value which I
wrote to it.

Can you suggest some kind of a "synchronization" function which I can call
from *user space* which will ensure that all values written to mmaped memory
locations from user space are actually flushed to their physical locations?
I think this might be a potential problem with my code.

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
