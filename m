Content-Type: text/plain;
  charset="utf-8"
Date: Wed, 31 Jul 2002 12:35:25 +0200
From: Howard Gray <ppclist@matrix-vision.de>
Message-Id: <200207311235.25357.ppclist@matrix-vision.de>
MIME-Version: 1.0
Reply-To: howard.gray@matrix-vision.de
Subject: Davicom DM9102A Network Problems
To: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We have a custom MPC8245 board with an on-board Davicom DM9102A network
(without an EEPROM) and I am trying to verify that our hardware is o.k. I
don't have a PCI network card with a Davicom on it to try in the PCI-slot to
confirm if the driver is o.k.

I am using kernel 2.4.19-rc1.

Using a modified PPCBoot tulip driver I can boot the board via the network.
This driver is simple and works without interrupts. But when trying to get
the Davicom to work with Linux I encounter the following problems:

1. Using the tulip driver (0.9.15-pre11) included with kernel 2.4.19-rc1,
receive seems to work. The Tulip driver finds and recognises the Davicom:

Linux Tulip driver version 0.9.15-pre11 (May 11, 2002)
tulip0: Old style EEPROM with no media selection information.
tulip0:  MII transceiver #1 config 1100 status 7829 advertising 01e1.
eth1: Davicom DM9102/DM9102A rev 64 at 0xbfff00, EEPROM not present,
00:E0:29:14:64:F4, IRQ 1

Interrupts are working and the interrupt routines are being called but the
transmitted replies are incorrect.

e.g.
The Davicom's HWaddr is 00:e0:29:14:64:f4 and the destination's HWaddr is
00:e0:29:14:64:f3
In response to an ARP "who has", the Davicom sends the following (output from
Ethereal)...

0000  00 00 00 e0 29 14 64 f3  00 e0 29 14 64 f4 08 06   ...à).dó .à).dô..
0010  00 01 08 00 06 04 00 02  00 e0 29 14 64 f4 c0 a8   ........ .à).dôÀ¨
0020  0b 1d 00 e0 29 14 64 f3  c0 a8 00 00 00 00 00 00   ...à).dó À¨......
0030  00 00 00 00 00 00 00 00  00 00 00 00               ........ ....

i.e. The data in the response packet is shifted by 2 bytes. The first 2 bytes
(00 00) are extra and incorrect. This would appear to be because the transmit
buffer (the skb_buff -> data field) is not long word aligned as required by
the Davicom. The skb_buff appears to be allocated by the kernel's network
core - I don't have any control over its alignment! Or maybe someone knows
how to do this ?


2. I have also tried using the dmfe.c driver specifically for Davicom with
even less success. Nothing is transmitted at all. This driver creates its own
transmit buffers and ensures that they are correctly aligned. When data is to
be transmitted it copies from the skb_buff structure into its own buffer
first, but this still seems not to work.


My questions:

- Has anybody got a DM9102A working on a PPC (preferably MPC8245) system ? I
notice that the Musenki specification includes this network chip and the same
CPU and that there are mails in this list referring to a similar problem at
Musenki. Did you solve that problem ?

- How can the tulip driver work with the DM9102A at all if the transmit
buffers are not guaranteed to be correctly aligned ?


Thanks for any help in advance,
--
Howard Gray
MATRIX Vision GmbH
Oppenweiler
Germany


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
