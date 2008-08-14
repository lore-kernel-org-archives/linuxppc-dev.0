Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 39DC6DDFEC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 18:20:05 +1000 (EST)
Date: Thu, 14 Aug 2008 01:20:04 -0700 (PDT)
Message-Id: <20080814.012004.193702132.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: bug in lmb_enforce_memory_limit()
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I just mentioned this to Ben H. on IRC and promised I would report it
here. :-)

The first loop over lmb.memory in this function interprets the
memory_limit as a raw size limit, and that's fine so far.

But the second loop over lmb.reserved interprets this value
instead as an "address limit."

I haven't cobbled together a fix myself, but probably the way to do
this is, when we're about break out of the first loop over lmb.memory,
walk through the now-trimmed memory blobs and trim those from
lmb.reserved, one by one.

This bug got introduced by:

   commit 2babf5c2ec2f2d5de3e38d20f7df7fd815fd10c9
   Author: Michael Ellerman <michael@ellerman.id.au>
   Date:   Wed May 17 18:00:46 2006 +1000

       [PATCH] powerpc: Unify mem= handling

back when LMB was still a powerpc local item. :-)

This led me to another bug which probably a lot of platforms are
effected by.

If you do this command line memory limiting, and the kernel was placed
by the boot loader into physical ram (say at the end of the available
physical memory) that gets trimmed out by the command line option, we
hang or crash right as we boot into userspace because freeing up
initmem ends up freeing invalid page structs.

I think, on sparc64, instead of adding all kinds of complicated logic
to free_initmem() I'm simply going to only poison the pages and
not free them at all if cmdline_memory_size has been set.
