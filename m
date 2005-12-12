Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep8.connect.com.au (fep8.mfe.bur.connect.com.au [203.63.86.8])
	by ozlabs.org (Postfix) with ESMTP id F2D92688C4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Dec 2005 14:44:29 +1100 (EST)
Received: from [192.168.1.100] (cor11-ppp3577.hay.dsl.connect.net.au
	[61.69.222.21])
	by mfep8.connect.com.au (Postfix) with ESMTP id E80E1B5F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Dec 2005 13:42:49 +1100 (EST)
Message-ID: <439CE3A2.8020603@rftechnology.com.au>
Date: Mon, 12 Dec 2005 13:42:42 +1100
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: 82xx IRQ handling
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

I am trying to setup an IRQ handler for IRQ4:

#define IRQ          SIU_INT_IRQ4

volatile cpm2_map_t *immap;
int irq_flags = 0;

immap = (cpm2_map_t *)CPM_MAP_ADDR;

immap->im_intctl.ic_simrh &= ~(0x0800);

request_irq(IRQ,	
             &irq_handler,	/* our handler */
             irq_flags,
             "interrupt_test",
             NULL);

immap->im_intctl.ic_simrh |= 0x0800;

I can see on a scope that IRQ line pulls up/down but handler get never
called. I am sure I made some very stupid mistake here but I will really
appreciate if somebody can help me with this.

Thank you

Dmytro
