Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A80C067BD7
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:36:04 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4560BF28.8010406@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>  <4560BF28.8010406@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:36:10 +1100
Message-Id: <1163968570.5826.113.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-19 at 23:31 +0300, Sergei Shtylyov wrote:

>    The fasteoi flow seem to only had been used for x86 IOAPIC in the RT patch 
> only *before* PPC took to using them in the mainline...

I don't think so, I asked for the fasteoi to be created while porting
ppc to genirq :-)

> > threaded handlers need a mask() + an ack(), because that's the correct
> 
>     Not all of them. This could be customized on type-by-type basis. I.e. we 
> could call eoi() instead of ack() for fasteoi chips without having to resort 
> to the duplicated ack/eoi handlers.

I still don't see how ack() makes sense in the context of a fasteoi...
You can either just not EOI until it's handled, but you'll indeed
introduce delays for other interrupts of the same priority or lower, or
you can mask() and then eoi(), which is, I think, what Apple does, to
deliver the interrupt to a thread (and later unmask).

In any case, I don't see the need for a separate ack().

Ben.
