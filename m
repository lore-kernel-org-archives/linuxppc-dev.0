Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG50r9fzDr5G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:57 +1000 (AEST)
In-Reply-To: <20170803041551.7934-1-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: powerpc/mm: Invalidate partition table cache on host proc tbl
 base update
Message-Id: <3xTPG46FVJz9t3m@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 04:15:51 UTC, Suraj Jitindar Singh wrote:
> The host process table base is stored in the partition table by calling
> the function native_register_process_table(). Currently this just sets
> the entry in memory and is missing a proceeding cache invalidation
> instruction. Any update to the partition table should be followed by a
> cache invalidation instruction specifying invalidation of the caching of
> any partition table entries (RIC = 2, PRS = 0).
> 
> We already have a function to update the partition table with the
> required cache invalidation instructions - mmu_partition_table_set_entry().
> Update the native_register_process_table() function to call
> mmu_partition_table_set_entry(), this ensures all appropriate
> invalidation will be performed.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7cd2a8695ef9c31e8f51773f0de9e6

cheers
