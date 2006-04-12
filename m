Return-Path: <tony.luck@intel.com>
Received: from azsmga101-1.ch.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id AD9F667C5E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 02:04:55 +1000 (EST)
Date: Wed, 12 Apr 2006 08:54:29 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
Message-ID: <20060412155429.GA10645@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
	<20060412000500.GA8532@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
Cc: linuxppc-dev@ozlabs.org, ak@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> That seems to register memory about the 0-2G mark and 6-8G with some small 
> holes here and there. Sounds like what you expected to happen. In case the 
> 1:1 virt->phys mapping is not always true on IA64, I decided to use __pa() 
> instead of PAGE_OFFSET like;
> 
> add_active_range(node, __pa(start) >> PAGE_SHIFT, __pa(end) >> PAGE_SHIFT);
> 
> Is this the correct thing to do or is "start - PAGE_OFFSET" safer? 
> Optimistically assuming __pa() is ok, the following patch (which replaces 
> Patch 5/6 again) should boot (passed compile testing here). If it doesn't, 
> can you send the console log again please?

Almost all of "region 7" (0xE000000000000000-0xFFFFFFFFFFFFFFFF) of the kernel
address space is defined to have a 1:1 mapping with physical memory (the exception
being the top 64K (0xFFFFFFFFFFFF0000-0xFFFFFFFFFFFFFFFF) which is mapped as
a per-cpu area).  So __pa(x) is simply defined as ((x) - PAGE_OFFSET). Using
__pa(start) is effectively identical to (start - PAGE_OFFSET), but __pa() is
a bit cleaner and easier to read.


-Tony
