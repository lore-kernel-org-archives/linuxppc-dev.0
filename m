Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx019.isp.belgacom.be (outmx019.isp.belgacom.be
	[195.238.4.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8290E67B60
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 19:38:21 +1000 (EST)
Received: from outmx019.isp.belgacom.be (localhost [127.0.0.1])
	by outmx019.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k679c3PU002148
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Jul 2006 11:38:04 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: SIU_INT_IRQ4 in MPC 8260
Date: Fri, 7 Jul 2006 11:39:57 +0200
References: <8C86FBB9DCF99D2-1D1C-336A@FWM-D43.sysops.aol.com>
In-Reply-To: <8C86FBB9DCF99D2-1D1C-336A@FWM-D43.sysops.aol.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607071139.57721.laurent.pinchart@tbox.biz>
Cc: jagannathanjay@aim.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I am trying to set up a interrupt handler for SIU_INT_IRQ4.
>
> The target I am using is MPC 8260 , emmbedded planet Evaluation board.
> The OS is Embedded Linux .

[snip]

> But my_interrupt_handler isn't getting called .

Make sure the CPM IRQ controller is properly configured. Here's the code I 
used to configure IRQ5 and IRQ6 in edge sensitive mode. Read the MPC8260 
datasheet to check how to set other options. If IRQ4 is multiplexed with 
other signals, make sure you configured the MPC8260 to use the external pin 
as IRQ4.

static void __init tbox_cp11_init_irq(void)
{
        volatile intctl_cpm2_t *ic = &cpm2_immr->im_intctl;

        init_irq();

        /* Make IRQ5 and IRQ6 edge sensitive */
        ic->ic_siexr |= 1 << (14 - (SIU_INT_IRQ5 - SIU_INT_IRQ1));
        irq_desc[SIU_INT_IRQ5].status &= ~IRQ_LEVEL;

        ic->ic_siexr |= 1 << (14 - (SIU_INT_IRQ6 - SIU_INT_IRQ1));
        irq_desc[SIU_INT_IRQ6].status &= ~IRQ_LEVEL;
}

void __init m82xx_board_init(void)
{
        init_irq = ppc_md.init_IRQ;
        ppc_md.init_IRQ = tbox_cp11_init_irq;

}

Laurent Pinchart
