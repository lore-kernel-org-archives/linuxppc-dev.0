Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94D4367D6D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 16:49:03 +1100 (EST)
Subject: Re: [PATCH 7/32] powerpc: Make pci_read_irq_line the default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1163483230.3906.2.camel@localhost.localdomain>
References: <20061110074452.BBF6167D13@ozlabs.org>
	<1163483230.3906.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 16:48:57 +1100
Message-Id: <1163483337.5940.108.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-14 at 13:47 +0800, Zang Roy-r61911 wrote:
> On Fri, 2006-11-10 at 15:44, Benjamin Herrenschmidt wrote:
> 
> > I also haven't updated the old-style fixup code from 85xx_cds.c
> > because it's actually buggy :) It assigns pci_dev->irq hard coded
> > numbers which is no good with the new IRQ mapping code. It should
> > at least use irq_create_mapping(NULL, hard_coded_number); and possibly
> > also set_irq_type() to set them as level low.
> > 
> 85xx cds is a little more complex. There are hardware revises.

In fact, my comment is partially wrong I noticed... That is, some of
those seem to have a 8259. In this case, the 8259 interrupts are always
down at 1...15 and can perfectly be hard coded in fixups as there is
always a 1:1 mapping between virq and hwirq for 8259 (that's what the
HOST_LEGACY choice is, specifically for 8259).

Ben.
