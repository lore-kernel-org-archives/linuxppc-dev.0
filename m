Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3391567C4A
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 03:43:13 +1100 (EST)
Date: Mon, 20 Nov 2006 17:42:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
Message-ID: <20061120164213.GA30350@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu>
	<1164039954.3028.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164039954.3028.19.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Daniel Walker <dwalker@mvista.com> wrote:

> It makes porting to powerpc for instance harder because some 
> controllers have ack(), and some don't.. Some have mask(), and some 
> don't.. So you end up with what Sergei is doing which is flat out make 
> ack == eoi .. Where you have multiple irq chip types each one really 
> needs an individual evaluation ..

this isnt really a problem. The current situation is simply hacky, 
because right now there's no 'threaded' flow type at all. The x86 code 
just moves the code away from fasteoi:

 #ifdef CONFIG_PREEMPT_HARDIRQS
                set_irq_chip_and_handler_name(irq, &ioapic_chip,
                                            handle_level_irq, "level-threaded");#else
                set_irq_chip_and_handler_name(irq, &ioapic_chip,
                                              handle_fasteoi_irq, "fasteoi");
 #endif

what should happen is a handle_thread_irq irq-flow handler that will 
first mask, and then ack or eoi (whichever callbacks is available), and 
thus can and will handle both fasteoi, edge and level irqs.

	Ingo
