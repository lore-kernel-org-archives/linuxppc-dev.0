Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id C80F1DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 02:41:31 +1100 (EST)
Message-ID: <49355723.8000200@harris.com>
Date: Tue, 02 Dec 2008 10:41:23 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors
References: <20081201060152.00DCCDDDE3@ozlabs.org>
	<BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
In-Reply-To: <BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> 
> On Dec 1, 2008, at 12:01 AM, Benjamin Herrenschmidt wrote:
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

I'm running with your patch on a 440 Sequoia board, and it
works fine for me.

Acked-by: Steven A. Falco <sfalco@harris.com>

	Steve
