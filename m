Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SV1sZqzF37h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:20:58 +1000 (AEST)
In-Reply-To: <20180817042501.15538-1-rashmica.g@gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>, bsingharora@gmail.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: powerpc/memtrace: Remove memory in chunks
Message-Id: <42G3ST5YYkz9sCS@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-17 at 04:25:01 UTC, Rashmica Gupta wrote:
> When hot-removing memory release_mem_region_adjustable() splits iomem
> resources if they are not the exact size of the memory being
> hot-deleted. Adding this memory back to the kernel adds a new resource.
> 
> Eg a node has memory 0x0 - 0xfffffffff. Hot-removing 1GB from
> 0xf40000000 results in the single resource 0x0-0xfffffffff being split
> into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.
> 
> When we hot-add the memory back we now have three resources:
> 0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.
> 
> This is an issue if we try to remove some memory that overlaps
> resources. Eg when trying to remove 2GB at address 0xf40000000,
> release_mem_region_adjustable() fails as it expects the chunk of memory
> to be within the boundaries of a single resource. We then get the
> warning: "Unable to release resource" and attempting to use memtrace
> again gives us this error: "bash: echo: write error: Resource
> temporarily unavailable"
> 
> This patch makes memtrace remove memory in chunks that are always the
> same size from an address that is always equal to end_of_memory -
> n*size, for some n. So hotremoving and hotadding memory of different
> sizes will now not attempt to remove memory that spans multiple
> resources.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3f7daf3d7582dc6628ac40a9045dd1

cheers
