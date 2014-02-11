Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id A35112C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 00:25:56 +1100 (EST)
Message-ID: <52FA24D9.3040406@redhat.com>
Date: Tue, 11 Feb 2014 08:25:45 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mgorman@suse.de,
 mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] mm: Use ptep/pmdp_set_numa for updating _PAGE_NUMA bit
References: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1392114895-14997-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1392114895-14997-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2014 05:34 AM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Archs like ppc64 doesn't do tlb flush in set_pte/pmd functions. ppc64 also doesn't implement
> flush_tlb_range. ppc64 require the tlb flushing to be batched within ptl locks. The reason
> to do that is to ensure that the hash page table is in sync with linux page table.
> We track the hpte index in linux pte and if we clear them without flushing hash and drop the
> ptl lock, we can have another cpu update the pte and can end up with double hash. We also want
> to keep set_pte_at simpler by not requiring them to do hash flush for performance reason.
> Hence cannot use them while updating _PAGE_NUMA bit. Add new functions for marking pte/pmd numa
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
