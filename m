Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 7396867BF7
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:41:14 +1100 (EST)
Message-ID: <4560C1C6.8000203@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:42:46 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	
	<1163966437.5826.99.camel@localhost.localdomain>	
	<20061119200650.GA22949@elte.hu>	
	<1163967590.5826.104.camel@localhost.localdomain>	
	<20061119202348.GA27649@elte.hu> <4560BF28.8010406@ru.mvista.com>
	<1163968570.5826.113.camel@localhost.localdomain>
In-Reply-To: <1163968570.5826.113.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Benjamin Herrenschmidt wrote:

>>   The fasteoi flow seem to only had been used for x86 IOAPIC in the RT patch 
>>only *before* PPC took to using them in the mainline...

> I don't think so, I asked for the fasteoi to be created while porting
> ppc to genirq :-)

    Oh, I was unaware of such details. :-)

>>>threaded handlers need a mask() + an ack(), because that's the correct

>>    Not all of them. This could be customized on type-by-type basis. I.e. we 
>>could call eoi() instead of ack() for fasteoi chips without having to resort 
>>to the duplicated ack/eoi handlers.

> I still don't see how ack() makes sense in the context of a fasteoi...

    It doesn't make sense even in the context of 8259 with its level/edge 
flows. That's what I'm talking about...

> You can either just not EOI until it's handled, but you'll indeed
> introduce delays for other interrupts of the same priority or lower, or
> you can mask() and then eoi(), which is, I think, what Apple does, to
> deliver the interrupt to a thread (and later unmask).
> In any case, I don't see the need for a separate ack().

   Yeah, that's what the threaded versions of flow handlers are doing. Except 
they're calling ack() to actually EOI an IRQ.

> Ben.

WBR, Sergei
