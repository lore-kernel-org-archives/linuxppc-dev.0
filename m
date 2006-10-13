Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A6D4679FD
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 09:14:45 +1000 (EST)
Subject: Re: preempt crash in 2.6.18
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20061014012105.6ca4ff05@localhost.localdomain>
References: <DCEAAC0833DD314AB0B58112AD99B93B07B397@ismail.innsys.innovsys.com>
	<20061014012105.6ca4ff05@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 09:14:38 +1000
Message-Id: <1160781278.4792.279.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-10-14 at 01:21 +0400, Vitaly Bordug wrote:
> On Fri, 13 Oct 2006 09:16:52 -0500
> Rune Torgersen wrote:
> 
> > 
> > This is from a Freescale 8265 running 2.6.18
> > Anyone have any idea what this is and how to fix it?
> > 
> Yes. Actually, I recall alike thing and used to fix with proper spin-locking if the 
> cascade PCI irq, which apparently does do_irq that seems to confuse preempt counters.
> 
> Just a pure guess.

How so ? Cascades shouldn't do do_IRQ with the new irq code anyway
unless this is still arch/ppc, they should do either __do_IRQ or better,
generic_handle_irq().

Ben.
