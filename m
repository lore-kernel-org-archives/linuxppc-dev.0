Date: Thu, 19 Aug 2004 14:26:38 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405EP and pci_alloc_consistent()
In-Reply-To: <20040819173623.GA11437@gate.ebshome.net>
Message-ID: <Pine.LNX.4.61.0408191420070.3546@chef.linux-wlan.com>
References: <Pine.LNX.4.61.0408191303100.3546@chef.linux-wlan.com>
 <20040819173623.GA11437@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 19 Aug 2004, Eugene Surovegin wrote:

> On Thu, Aug 19, 2004 at 01:11:30PM -0400, Mark S. Mathews wrote:
>> This device/driver relies on a dma'd 'control block' where all the queues
>> (heads,tails,metadata etc.) are managed.  We allocate that block with
>> pci_alloc_consistent().  I had some trouble with stale values
>
> Could you elaborate a little on what "stale" means?

Occasionally (can't be any more specific than that) the code that reads
out the queue head index for our receive queue hands me a value
corresponding to a frame that that was just previously handled.

>> until I
>> wrapped all the accesses of the block with invalidate_dcache_range()
>> before reads and flush_dcache_range() after writes.
>>
>> I don't have a problem with the necessity to do all that, but it does
>> leave me a little uncomfortable.  I thought the pci_alloc_consistent call
>> should mark the tlb entrie(s) for that memory as non-cacheable.  Am I
>> missing something?
>
> Yes, your expectations are correct.
>
> I'd check PCI bridge behavior here. Maybe your problem is caused by
> the bridge doing its own caching (prefetching and/or write posting).

Agreed.  One of the hw engineers responsible for the board design pointed
me at some text in the 405 manual.  Haven't had the opportunity to check
it out yet.

If this turns out to be the case, it'll be interesting to ponder how my
current 'fix' is altering the behavior.

Thanks for the input,
-Mark

  --

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
