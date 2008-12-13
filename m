Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A73FDE092
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 10:49:40 +1100 (EST)
Message-Id: <1957A815-19D9-434C-9F46-8124D86C075F@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081211191503.1e8bbf18@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/9] powerpc: Fix bogus cache flushing on all 40x and
	BookE processors v2
Date: Sat, 13 Dec 2008 17:49:03 -0600
References: <1228714789.103940.266501677728.qpush@grosgo>
	<20081208054038.20368DDE1F@ozlabs.org>
	<20081211191503.1e8bbf18@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2008, at 6:15 PM, Josh Boyer wrote:

> On Mon, 08 Dec 2008 16:39:52 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> We were missing the CPU_FTR_NOEXECUTE bit in our cputable for all
>> these processors. The result is that update_mmu_cache() would flush
>> the cache for all pages mapped to userspace which is totally
>> unnecessary on those processors since we already handle flushing
>> on execute in the page fault path.
>>
>> This should provide a nice speed up ;-)
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> Kumar, feel free to take this through your tree.
>
> josh

applied to next

- k
