Date: Thu, 19 Aug 2004 13:11:30 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 405EP and pci_alloc_consistent()
Message-ID: <Pine.LNX.4.61.0408191303100.3546@chef.linux-wlan.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,

I've got a wlan driver I'm running on a 405EP target with the 2.4.27
rsynch'd from the mvista site last week (my customer did that, I don't
have the exact details).

This device/driver relies on a dma'd 'control block' where all the queues
(heads,tails,metadata etc.) are managed.  We allocate that block with
pci_alloc_consistent().  I had some trouble with stale values until I
wrapped all the accesses of the block with invalidate_dcache_range()
before reads and flush_dcache_range() after writes.

I don't have a problem with the necessity to do all that, but it does
leave me a little uncomfortable.  I thought the pci_alloc_consistent call
should mark the tlb entrie(s) for that memory as non-cacheable.  Am I
missing something?

Thanks,
-Mark

--

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
