Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18448.12058.743037.267216@cargo.ozlabs.ibm.com>
Date: Thu, 24 Apr 2008 16:56:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: LMB regression...
In-Reply-To: <20080423.232419.193712136.davem@davemloft.net>
References: <20080423.232419.193712136.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> Specifically, you removed the aligning of the size argument given to
> lmb_add_region() in the lmb allocators, and that is critical when
> allocating many small chunks, we run out of LMB slots otherwise
> and allocations start failing.

Sorry.  It's still there in lmb_alloc_nid_unreserved but I lost the
one in __lmb_alloc_base.  Are you going to send a fix to Linus, or
will I include it in the pull request I'm going to send tomorrow?

> I find it quite ironic that you spent so much time and effort fixing
> an absolutely totally theoretical bug that nobody was triggering, and
> in the process reintroduced a real one that triggers immediately on
> real systems, and that had even been explicitly fixed previously.

In fact the bug should be relatively easily triggerable in
lmb_alloc_nid as far as I can see, since it scans upwards
from zero.  It depends a bit on how memory is distributed across
nodes, but it you are allocating on the node that has the memory
starting at physical address 0, and all of the first contiguous chunk
on that node is reserved, then I think you'll hit the bug.  The only
saving grace is that lmb_alloc_nid is presently unused.

Paul.
