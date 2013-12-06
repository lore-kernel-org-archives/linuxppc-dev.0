Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 6F1482C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 22:30:10 +1100 (EST)
Date: Fri, 6 Dec 2013 11:30:03 +0000
From: Mel Gorman <mgorman@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
Message-ID: <20131206113003.GP11295@suse.de>
References: <1386268702-30806-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1386268702-30806-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: riel@redhat.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 06, 2013 at 12:08:22AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> change_prot_numa should work even if _PAGE_NUMA != _PAGE_PROTNONE.
> On archs like ppc64 that don't use _PAGE_PROTNONE and also have
> a separate page table outside linux pagetable, we just need to
> make sure that when calling change_prot_numa we flush the
> hardware page table entry so that next page access  result in a numa
> fault.
> 
> We still need to make sure we use the numa faulting logic only
> when CONFIG_NUMA_BALANCING is set. This implies the migrate-on-fault
> (Lazy migration) via mbind will only work if CONFIG_NUMA_BALANCING
> is set.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

You're right on that there is no direct dependance on numa balancing and
use of prot_none. The BUILD_BUG_ON was to flag very clearly that arches
wanting to support automatic NUMA balancing must ensure such things as

o _PAGE_NUMA is defined
o setting _PAGE_NUMA traps a fault and the fault can be uniquely
  identified as being a numa hinting fault
o that pte_present still returns true for pte_numa pages even though the
  underlying present bit may be cleared. Otherwise operations like
  following and copying ptes will get confused
o shortly, arches will also need to avoid taking references on pte_numa
  pages in get_user_pages to account for hinting faults properly

I guess the _PAGE_NUMA parts will already be caught by other checks and
the rest will fall out during testing so it's ok to remove.

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
