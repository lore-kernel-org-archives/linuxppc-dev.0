Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 48F98B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 09:16:23 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.54])
 by hrndva-qmta03.mail.rr.com with ESMTP
 id <20111012210922583.TUYP29997@hrndva-qmta03.mail.rr.com>
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 21:09:22 +0000
Received: from crust.elkhashab.com (localhost [127.0.0.1])
 by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id p9CL8GTb018057
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 16:08:16 -0500
Received: (from ayman@localhost)
 by crust.elkhashab.com (8.14.3/8.14.3/Submit) id p9CL8G70018056
 for linuxppc-dev@lists.ozlabs.org; Wed, 12 Oct 2011 16:08:16 -0500
Date: Wed, 12 Oct 2011 16:08:16 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: How to handle cache when I allocate phys memory?
Message-ID: <20111012210816.GA17878@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm using the 460sx (440 core) so no snooping here.  What
I've done is reserved the top of memory for my driver.  My
driver can read/write the memory and I can mmap it just
fine.  The problem is I want to enable caching on the mmap
for performance but I don't know / can't figure out how to
tell the kernel to sync the cache after it gets dma data
from the device or after i put data into it from user space.
I know how to do it from regular devices, but not when I've
allocated the physical memory myself.  I suppose what I am
looking for is something akin to dma_sync_single cpu/device.

In my device driver, I am allocating the memory like this, 
in this case the buffer is about 512MB.

 vma->vm_flags |= VM_LOCKED | VM_RESERVED;

 /* map the physical area into one buffer */
 rc = remap_pfn_range(vma, vma->vm_start, 
                         (PHYS_MEM_ADDR)>>PAGE_SHIFT, 
                         len, vma->vm_page_prot);

Is this going to give me the best performance, or is there
something more I can do?

Failing that, what is the best way to do this (i need a very
large contiguous buffer).  it runs in batch mode, so it
DMAs, stops, cpu reads, cpu writes, repeat ...

thanks
ayman
