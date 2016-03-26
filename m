Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXFh61bPnzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 20:47:18 +1100 (AEDT)
In-Reply-To: <1458921929-15264-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-mm@kvack.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, mgorman@suse.de, zhlcindy@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RFC] mm: Fix memory corruption caused by deferred page
 initialization
Message-Id: <3qXFh60DRNz9sDH@ozlabs.org>
Date: Sat, 26 Mar 2016 20:47:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gavin,

On Fri, 2016-25-03 at 16:05:29 UTC, Gavin Shan wrote:
> During deferred page initialization, the pages are moved from memblock
> or bootmem to buddy allocator without checking they were reserved. Those
> reserved pages can be reallocated to somebody else by buddy/slab allocator.
> It leads to memory corruption and potential kernel crash eventually.

Can you give me a bit more detail on what the bug is?

I haven't seen any issues on my systems, but I realise now I haven't enabled
DEFERRED_STRUCT_PAGE_INIT - I assumed it was enabled by default.

How did this get tested before submission?

> This fixes above issue by:
> 
>    * Deferred releasing bootmem bitmap until the completion of deferred
>      page initialization.

As I said in my other mail, we don't support bootmem anymore. So please resend
with just the non-bootmem fixes.

cheers
