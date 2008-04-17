Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6D630DE015
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 17:09:47 +1000 (EST)
Date: Thu, 17 Apr 2008 00:09:46 -0700 (PDT)
Message-Id: <20080417.000946.44234467.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [LMB][2/2] Restructure allocation loops to avoid unsigned
	underflow
From: David Miller <davem@davemloft.net>
In-Reply-To: <18432.18107.854417.50018@cargo.ozlabs.ibm.com>
References: <18432.18107.854417.50018@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 12 Apr 2008 15:20:59 +1000

> There is a potential bug in __lmb_alloc_base where we subtract `size'
> from the base address of a reserved region without checking whether
> the subtraction could wrap around and produce a very large unsigned
> value.  In fact it probably isn't possible to hit the bug in practice
> since it would only occur in the situation where we can't satisfy the
> allocation request and there is a reserved region starting at 0.
> 
> This fixes the potential bug by breaking out of the loop when we get
> to the point where the base of the reserved region is less than the
> size requested.  This also restructures the loop to be a bit easier to
> follow. 
> 
> The same logic got copied into lmb_alloc_nid_unreserved, so this makes
> a similar change there.  Here the bug is more likely to be hit because
> the outer loop  (in lmb_alloc_nid) goes through the memory regions in
> increasing order rather than decreasing order as __lmb_alloc_base
> does, and we are therefore more likely to hit the case where we are
> testing against a reserved region with a base address of 0.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

This looks great, thanks for doing this work Paul.

I'll try to find some cycles to validate these changes alongside
the pending sparc64 NUMA changes I have.
