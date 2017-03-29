Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtCzZ6wx9zDq93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 14:34:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 04/17] powerpc/mm: Remove redundant TASK_SIZE_USER64
 checks
In-Reply-To: <1490153823-29241-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490153823-29241-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 14:34:02 +1100
Message-ID: <87inmskb85.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> The check against VSID range is implied when we check task size against
> hash and radix pgtable range[1], because we make sure page table range cannot
> exceed vsid range.
>
> [1] BUILD_BUG_ON(TASK_SIZE_USER64 > H_PGTABLE_RANGE);
> BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
>
> The check for smaller task size is also removed here, because the follow up
> patch will support a tasksize smaller than pgtable range.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c    | 4 ----
>  arch/powerpc/mm/pgtable_64.c | 5 -----
>  2 files changed, 9 deletions(-)

As discussed this has become:

commit f0aceca42796829295f5d20d01d4bee9773b63b7
Author:     Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
AuthorDate: Wed Mar 22 09:06:50 2017 +0530
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Tue Mar 28 20:28:20 2017 +1100

    powerpc/mm: Remove checks that TASK_SIZE_USER64 is too small
    
    Remove the checks that TASK_SIZE_USER64 is smaller than H_PGTABLE_RANGE
    and USER_VSID_RANGE.
    
    In a following patch we will deliberately add support for a TASK_SIZE
    smaller than both ranges, so this will no longer be an error condition.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    [mpe: Keep the check in pgtable_64.c that we don't exceed USER_VSID_RANGE]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 9be992083d2a..8f6f2a173e47 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -71,10 +71,6 @@
 #if H_PGTABLE_RANGE > USER_VSID_RANGE
 #warning Limited user VSID range means pagetable space is wasted
 #endif
-
-#if (TASK_SIZE_USER64 < H_PGTABLE_RANGE) && (TASK_SIZE_USER64 < USER_VSID_RANGE)
-#warning TASK_SIZE is smaller than it needs to be.
-#endif
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 phys_addr_t memstart_addr = ~0;


cheers
