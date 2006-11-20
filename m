Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1BC7C67F05
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 07:07:03 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061120100144.GA27812@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 07:07:10 +1100
Message-Id: <1164053230.8073.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-20 at 11:01 +0100, Ingo Molnar wrote:

> so the question is not 'is there an ACK' (all non-MSI-type-of IRQ 
> delivery mechanisms have some sort of ACK mechanism), but what is the 
> precise structure of ACK-ing an IRQ that the host recieves.
> 
> on PPC64, 'get the vector' initiates an ACK as well - is that done 
> before handle_irq() is done?

Yes.

> > So by doing a mask followed by an eoi, you essentially mask the 
> > interrupt preventing further delivery of that interrupt and lower the 
> > CPU priority in the PIC thus allowing processing of further 
> > interrupts.
> 
> correct, that's what should happen.
> 
> > Are there other fasteoi controllers than the ones I have on powerpc 
> > anyway ?
> 
> well, if you mean the x86 APICs, there you get the vector 'for free' as 
> part of the IRQ entry call sequence, and there's an EOI register in the 
> local APIC that notifies the IRQ hardware, lowers the CPU priority, etc. 
> We have that as an ->eoi handler right now.

Ok, so that's like me. Which means that what you need is a specific thre
aded_fasteoi flow handler that does mask & eoi, not ack.

Note that I still think it would work in the absence of mask too if the
controller only does edge interrupts, as it is the case for the cell.

Cheers,
Ben.
