Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9019FDDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 00:32:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Mon, 30 Apr 2007 07:32:51 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F7@MERCURY.inside.istor.com>
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



At this point, I would just like to confirm I am thinking clearly and
now understand the IRQ mapping. We are constrained to finish this
project with the kernel we started with, linux-2.6.17.11, so this
discussion is centered around that code base. This is my understanding
based on last week's e-mails and my research.

1. In arch/ppc/platforms/85xx/mpc85xx_cds_common.c is the
mpc85xx_cds_openpic_initsenses[] whose first 4 members are set to
IRQ_SENSE_LEVEL or'ed with IRQ_POLARITY_NEGATIVE. This means the first
four external interrupts are enabled and neg polarity. I can use these
entries as is and change the others from 0x0 as I need more of the
external interrupt pins.

Just for reference, here are a few lines from mpc85xx_cds_init_IRQ

mpc85xx_cds_init_IRQ(void)
{
	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
	/* Map PIC IRQs 0-11 */
	openpic_set_sources(48, 12, OpenPIC_Addr + 0x10000);
#if 0
	openpic_hookup_cascade(PIRQ0A, "82c59 cascade", i8259_irq);
	i8259_init(0, 0);
#endif
	/* Setup CPM2 PIC */
        cpm2_init_IRQ();
	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);

2. In this routine, the first openpic_set_source call is for the 32
internal IRQ's and the second openpic_set_sources maps the 12 external
IRQ's beginning at 48, so that means my external IRQ mapping is:

ExtIrQ    LinuxIrqNum
0		48 (first four are enabled)
1		49
2		50
3		51
4		52 (last 8 not enabled by default)
5		53
6		54
7		55
8		56
9		57=09
10		58=09
11		59

Is this correct?

Charles
