Date: Thu, 19 Aug 2004 10:36:24 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Mark S. Mathews" <mark@linux-wlan.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405EP and pci_alloc_consistent()
Message-ID: <20040819173623.GA11437@gate.ebshome.net>
References: <Pine.LNX.4.61.0408191303100.3546@chef.linux-wlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0408191303100.3546@chef.linux-wlan.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 19, 2004 at 01:11:30PM -0400, Mark S. Mathews wrote:
> This device/driver relies on a dma'd 'control block' where all the queues
> (heads,tails,metadata etc.) are managed.  We allocate that block with
> pci_alloc_consistent().  I had some trouble with stale values

Could you elaborate a little on what "stale" means?

> until I
> wrapped all the accesses of the block with invalidate_dcache_range()
> before reads and flush_dcache_range() after writes.
>
> I don't have a problem with the necessity to do all that, but it does
> leave me a little uncomfortable.  I thought the pci_alloc_consistent call
> should mark the tlb entrie(s) for that memory as non-cacheable.  Am I
> missing something?

Yes, your expectations are correct.

I'd check PCI bridge behavior here. Maybe your problem is caused by
the bridge doing its own caching (prefetching and/or write posting).

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
