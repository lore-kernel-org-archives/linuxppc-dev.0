Date: Fri, 18 Jul 2003 10:33:57 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kmalloc vs pci_alloc_consistent
Message-ID: <20030718153357.GA9047@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <F9102D41F595D311ACA7009027DE2C840527B4D7@c3po.heurikon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9102D41F595D311ACA7009027DE2C840527B4D7@c3po.heurikon.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 18, 2003 at 09:56:35AM -0500, Johnson, Stephen wrote:
> I read one thing noted on a man page for kmalloc that should be highlighted.
> "the GFP_DMA flag may be set to indicate the memory must be suitable for
> DMA. ***This can mean different things on different platforms.*** For
> example, on x86, it means that the memory must come from the first 16MB."

Just to clarify -- the 16MB lower memory limit is only true on x86 when doing
DMA via ISA.  PCI does not have this problem.

In addition to making sure you get pages that are usable for DMA,
pci_alloc_consistent() also takes care of cache coherency issues.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
