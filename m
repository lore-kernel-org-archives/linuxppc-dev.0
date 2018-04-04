Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBf5jZvzF1Wm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:54 +1000 (AEST)
In-Reply-To: <20180403135402.30374-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ldufour@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, vaibhav@linux.vnet.ibm.com
Subject: Re: [v2] cxl: Fix possible deadlock when processing page faults from
 cxllib
Message-Id: <40GTBf4GFWz9ryr@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-03 at 13:54:02 UTC, Frederic Barrat wrote:
> cxllib_handle_fault() is called by an external driver when it needs to
> have the host resolve page faults for a buffer. The buffer can cover
> several pages and VMAs. The function iterates over all the pages used
> by the buffer, based on the page size of the VMA.
> 
> To ensure some stability while processing the faults, the thread T1
> grabs the mm->mmap_sem semaphore with read access (R1). However, when
> processing a page fault for a single page, one of the underlying
> functions, copro_handle_mm_fault(), also grabs the same semaphore with
> read access (R2). So the thread T1 takes the semaphore twice.
> 
> If another thread T2 tries to access the semaphore in write mode W1
> (say, because it wants to allocate memory and calls 'brk'), then that
> thread T2 will have to wait because there's a reader (R1). If the
> thread T1 is processing a new page at that time, it won't get an
> automatic grant at R2, because there's now a writer thread
> waiting (T2). And we have a deadlock.
> 
> The timeline is:
> 1. thread T1 owns the semaphore with read access R1
> 2. thread T2 requests write access W1 and waits
> 3. thread T1 requests read access R2 and waits
> 
> The fix is for the thread T1 to release the semaphore R1 once it got
> the information it needs from the current VMA. The address space/VMAs
> could evolve while T1 iterates over the full buffer, but in the
> unlikely case where T1 misses a page, the external driver will raise a
> new page fault when retrying the memory access.
> 
> Fixes: 3ced8d730063 ("cxl: Export library to support IBM XSL")
> Cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ad7b4e8022b9864c075fe71e1328b1

cheers
