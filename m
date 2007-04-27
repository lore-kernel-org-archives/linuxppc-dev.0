Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43A83DE025
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 06:58:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 13:58:52 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F3@MERCURY.inside.istor.com>
In-Reply-To: <46324428.7070401@ru.mvista.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A little further on IRQ mapping. I was incorrect in saying enet_tx is at
19. According to MPC8555ERM.pdf the TSEC1_tx, TSEC_rx and DUART are at

13 TSEC1_tx   (maps to 93)
14 TSEC1_rx   (maps to 94)
26 DUART      (maps to 106)

A 'cat /proc/interrupts' shows this 93, 94 & 106 mapping:

root@sff1:~# cat /proc/interrupts
           CPU0
  2:          0   i8259     Edge      82c59 secondary cascade
 32:          0   CPM2 SIU  Level     ichar
 93:      10701   OpenPIC   Level     enet_tx
 94:      13945   OpenPIC   Level     enet_rx
 98:          0   OpenPIC   Level     enet_error
106:        542   OpenPIC   Level     serial
107:          0   OpenPIC   Level     i2c-mpc
110:          0   OpenPIC   Level     cpm2_cascade
128:          0   OpenPIC   Level     <NULL>
BAD:          0
root@sff1:~#

Looking at arch/ppc/platforms/85xx/mpc85xx_cds_common.c, I can see the
mpc85xx_cds_openpic[] array and since CONFIG_PCI is defined, the first
four entries for IRQ0..3 (or INTA, INTB, INTC & INTD) have non-zero
entries containing (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), which
should be OK.

Down a little further in this file is mpc85xx_cds_init_IRQ and it we do
not have CONFIG_MPC8548 defined, so we should be calling

openpic_set_sources(0, 32, OpenPIC_ADDR + 0x10200)=20

followed by calling=20

openpic_set_sources(48, 12, OpenPIC_ADDR + 0x10000)

This leads to a couple of new questions.

1. We have no 8259 in our design. Is this a concern as we are always
calling the i8259_init() routine.

2. The 'cat /proc/interrupts' shows 82c59 secondary cascade. Again, does
this matter?

3. The offset between TSEC1_tx of 13-->93 is a constant of 80 decimal.
Is this a clue to what the irq should be set to for external IRQ0 in
this design?

Charles Krinke
