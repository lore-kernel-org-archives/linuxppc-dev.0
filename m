Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wR7pw40rBzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 15:06:48 +1000 (AEST)
In-Reply-To: <1494317148-18554-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm/book3s/64: Rework page table geometry for lower memory
 usage
Message-Id: <3wR7pt2l3Cz9s8J@ozlabs.org>
Date: Mon, 15 May 2017 15:06:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-09 at 08:05:48 UTC, Michael Ellerman wrote:
> Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
> we increased the virtual address space for user processes to 128TB by default,
> and up to 512TB if user space opts in.
> 
> This obviously required expanding the range of the Linux page tables. For Book3s
> 64-bit using hash and with PAGE_SIZE=64K, we increased the PGD to 2^15 entries.
> This meant we could cover the full address range, while still being able to
> insert a 16G hugepage at the PGD level and a 16M hugepage in the PMD.
> 
> The downside of that geometry is that it uses a lot of memory for the PGD, and
> in particular makes the PGD a 4-page allocation, which means it's much more
> likely to fail under memory pressure.
> 
> Instead we can make the PMD larger, so that a single PUD entry maps 16G,
> allowing the 16G hugepages to sit at that level in the tree. We're then able to
> split the remaining bits between the PUG and PGD. We make the PGD slightly
> larger as that results in lower memory usage for typical programs.
> 
> When THP is enabled the PMD actually doubles in size, to 2^11 entries, or 2^14
> bytes, which is large but still < PAGE_SIZE.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/ba95b5d0359609b4ec8010f77c40ab

cheers
