Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A095CDDFB1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 04:47:52 +1000 (EST)
Date: Tue, 3 Jun 2008 11:47:00 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<20080602072403.GA20222@flint.arm.linux.org.uk>
	<200806031416.18195.nickpiggin@yahoo.com.au>
	<alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Jun 2008, Linus Torvalds wrote:
> On Tue, 3 Jun 2008, Nick Piggin wrote:
>>
>> Linus: on x86, memory operations to wc and wc+ memory are not ordered
>> with one another, or operations to other memory types (ie. load/load
>> and store/store reordering is allowed). Also, as you know, store/load
>> reordering is explicitly allowed as well, which covers all memory
>> types. So perhaps it is not quite true to say readl/writel is strongly
>> ordered by default even on x86. You would have to put in some
>> mfence instructions in them to make it so.

So on x86, these could be re-ordered?

writel(START_OPERATION, CONTROL_REGISTER);
status = readl(STATUS_REGISTER);

> Well, you have to ask for WC/WC+ anyway, so it's immaterial. A driver that
> does that needs to be aware of it. IOW, it's a non-issue, imnsho.

You need to ask for coherent DMA memory too.
