Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 531C9B6FFC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 06:55:42 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Mon, 18 Jun 2012 16:55:38 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D2D4338C801C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 16:55:35 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5IKtZ38139988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 16:55:35 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5IKtZl8011922
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 16:55:35 -0400
Message-ID: <4FDF95C5.3090903@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2012 15:55:33 -0500
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: CPU-local TLB flushing
Content-Type: text/plain; charset=ISO-8859-1
Cc: Minchan Kim <minchan@kernel.org>, Robert Jennings <rcj@linux.vnet.ibm.com>,
 Nitin Gupta <ngupta@vflare.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a continuation of a thread a few months ago:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-February/095775.html

zsmalloc is now in the staging tree and there are patches
on lkml to convert the x86 only tlb flushing code to arch
independent code.

https://lkml.org/lkml/2012/5/14/55

A quick back story, zsmalloc does some pte/tlb manipulation
to quickly map a pair of pages into a single VM area.  It
does this with interrupts disabled in a preallocated per-cpu
VM area, which means the mapping only exists in the TLB of
the cpu that does the mapping and, therefore, only needs to
be flushed on that same cpu during the unmapping process.

Right now, zsmalloc uses __flush_tlb_one() on x86 to do a
cpu-local single entry tlb flush.  Afaict, there is no such
call on ppc64.

The patch replaces that x86 call with a call to a new function,
local_unmap_kernel_range(), which is exactly the same as
unmap_kernel_range() in mm/vmalloc.c except that it calls
local_flush_tlb_kernel_range() instead of 
flush_tlb_kernel_range().

A few archs support local_flush_tlb_kernel_range() already and
another patch in the patchset above, introduces this function
for x86; basically a wrapper for __flush_tlb_single().

For PPC_STD_MMU_64, it looked like all the tlb flushing
functions were just stubs, so I just added a stub for
local_flush_tlb_kernel_range().  This was stable running
a single threaded application, bound to one cpu, but crashes
with even two threads.

With local_flush_tlb_kernel_range() being a stub,
the new function local_unmap_kernel_range() is exactly
the same as unmap_kernel_range() since 
local_flush_tlb_kernel_range() and flush_tlb_kernel_range()
are both stubs on ppc64.

My knowledge of the ppc64 hashing tlb design is almost
nothing, but it seems like this should work, albeit slowly
since it would be a global flush rather than cpu-local.

I was wondering if anyone could tell me why this doesn't work,
and what needs to be done to make it work.

Thanks in advance for any help!  Let me know if you need
clarification on something.

--
Seth
