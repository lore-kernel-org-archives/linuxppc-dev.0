Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4A3A2DDF25
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 16:24:21 +1000 (EST)
Date: Wed, 23 Apr 2008 23:24:19 -0700 (PDT)
Message-Id: <20080423.232419.193712136.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: LMB regression...
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, I finally got around to testing your changeset on sparc64, it
breaks things:

commit d9024df02ffe74d723d97d552f86de3b34beb8cc
Author: Paul Mackerras <paulus@samba.org>
Date:   Sat Apr 12 15:20:59 2008 +1000

    [LMB] Restructure allocation loops to avoid unsigned underflow
 ...    

Specifically, you removed the aligning of the size argument given to
lmb_add_region() in the lmb allocators, and that is critical when
allocating many small chunks, we run out of LMB slots otherwise
and allocations start failing.

I added the alignment there as a bug fix earlier:

commit eea89e13a9c61d3928223d2f9bf2295e22e0efb6
Author: David S. Miller <davem@davemloft.net>
Date:   Wed Feb 13 16:57:09 2008 -0800

    [LMB]: Fix bug in __lmb_alloc_base().
    
    We need to check lmb_add_region() for errors, it can run out
    of regions etc.
    
    Also, the size needs to be padded to the given alignment
    or else the lmb.reserved regions don't get expanded and
    instead we get tons of holes and eventually run out of
    regions prematurely.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

Please be more careful in the future :-(

I find it quite ironic that you spent so much time and effort fixing
an absolutely totally theoretical bug that nobody was triggering, and
in the process reintroduced a real one that triggers immediately on
real systems, and that had even been explicitly fixed previously.
