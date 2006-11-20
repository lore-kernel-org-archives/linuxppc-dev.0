Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id D3BCB67C82
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 04:01:31 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061120164213.GA30350@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu>
	<1164039954.3028.19.camel@localhost.localdomain>
	<20061120164213.GA30350@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 09:01:19 -0800
Message-Id: <1164042079.3028.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-20 at 17:42 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > It makes porting to powerpc for instance harder because some 
> > controllers have ack(), and some don't.. Some have mask(), and some 
> > don't.. So you end up with what Sergei is doing which is flat out make 
> > ack == eoi .. Where you have multiple irq chip types each one really 
> > needs an individual evaluation ..
> 
> this isnt really a problem. The current situation is simply hacky, 
> because right now there's no 'threaded' flow type at all. The x86 code 
> just moves the code away from fasteoi:
> 
>  #ifdef CONFIG_PREEMPT_HARDIRQS
>                 set_irq_chip_and_handler_name(irq, &ioapic_chip,
>                                             handle_level_irq, "level-threaded");#else
>                 set_irq_chip_and_handler_name(irq, &ioapic_chip,
>                                               handle_fasteoi_irq, "fasteoi");
>  #endif
> 
> what should happen is a handle_thread_irq irq-flow handler that will 
> first mask, and then ack or eoi (whichever callbacks is available), and 
> thus can and will handle both fasteoi, edge and level irqs.

If it still calls for arch level changes, I have an aversion to those ..
Maybe if it was internal to the set_irq_chip_and_handler_name() macro?

Daniel
