Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2310EDE015
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 05:05:55 +1000 (EST)
Message-Id: <92B9A919-0F13-43FA-8E01-4470065A9131@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090522194930E.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
Date: Wed, 27 May 2009 14:05:42 -0500
References: <4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<4A15B72E.2070202@goop.org>
	<20090522194930E.fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@ozlabs.org, jeremy@goop.org, linux-kernel@vger.kernel.org,
	Ian.Campbell@citrix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 22, 2009, at 5:51 AM, FUJITA Tomonori wrote:

> On Thu, 21 May 2009 13:18:54 -0700
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>> Becky Bruce wrote:
>>> I can work with that, but it's going to be a bit inefficient, as I
>>> actually need the dma_addr_t, not the phys_addr_t, so I'll have to
>>> convert.  In every case, this is a conversion I've already done and
>>> that I need in the calling code as well.  Can we pass in both the
>>> phys_addr_t and the dma_addr_t?
>>
>> The Xen implementation would needs to do the phys to bus conversion  
>> page
>> by page anyway, so it wouldn't help much.  But it also wouldn't hurt.
>>
>> How expensive is the phys-to-bus conversion on power?  Is it worth
>> making the interface more complex for?  Would passing phys+bus mean  
>> that
>> we wouldn't also need to pass dev?
>
> I don't think so. POWERPC needs it.

Hrm, it looks like my response to this got dropped.  Fujita is correct  
- we still need the dev on powerpc because we use it to get device- 
specific information that is used to determining when we need to  
actually bounce.

Cheers,
B
