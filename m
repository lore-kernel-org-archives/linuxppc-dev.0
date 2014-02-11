Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A6D062C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 05:49:56 +1100 (EST)
Message-ID: <1392144570.23418.8.camel@pasglop>
Subject: Re: [PATCH 3/3] mm: Use ptep/pmdp_set_numa for updating _PAGE_NUMA bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mgorman@suse.de>
Date: Wed, 12 Feb 2014 05:49:30 +1100
In-Reply-To: <20140211170724.GM6732@suse.de>
References: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1392114895-14997-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211170724.GM6732@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: riel@redhat.com, linux-mm@kvack.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-11 at 17:07 +0000, Mel Gorman wrote:
> On Tue, Feb 11, 2014 at 04:04:55PM +0530, Aneesh Kumar K.V wrote:
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > Archs like ppc64 doesn't do tlb flush in set_pte/pmd functions. ppc64 also doesn't implement
> > flush_tlb_range. ppc64 require the tlb flushing to be batched within ptl locks. The reason
> > to do that is to ensure that the hash page table is in sync with linux page table.
> > We track the hpte index in linux pte and if we clear them without flushing hash and drop the
> > ptl lock, we can have another cpu update the pte and can end up with double hash. We also want
> > to keep set_pte_at simpler by not requiring them to do hash flush for performance reason.
> > Hence cannot use them while updating _PAGE_NUMA bit. Add new functions for marking pte/pmd numa
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Acked-by: Mel Gorman <mgorman@suse.de>
> 

How do you guys want me to proceed ? Will you (or Andrew) send these to
Linus or should I do it myself ?

Cheers,
Ben.
