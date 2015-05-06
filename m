Return-Path: <kas@node.shutemov.name>
Received: from jenni1.inet.fi (mta-out1.inet.fi [62.71.2.203])
 by lists.ozlabs.org (Postfix) with ESMTP id 44CC31A035A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 10:11:28 +1000 (AEST)
Date: Wed, 6 May 2015 03:11:05 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] mm/thp: Use new function to clear pmd before THP
 splitting
Message-ID: <20150506001105.GA14559@node.dhcp.inet.fi>
References: <1430760556-28137-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430760556-28137-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 04, 2015 at 10:59:16PM +0530, Aneesh Kumar K.V wrote:
> Archs like ppc64 require pte_t * to remain stable in some code path.
> They use local_irq_disable to prevent a parallel split. Generic code
> clear pmd instead of marking it _PAGE_SPLITTING in code path
> where we can afford to mark pmd none before splitting. Use a
> variant of pmdp_splitting_clear_notify that arch can override.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Sorry, I still try wrap my head around this problem.

So, Power has __find_linux_pte_or_hugepte() which does lock-less lookup in
page tables with local interrupts disabled. For huge pages it casts pmd_t
to pte_t. Since format of pte_t is different from pmd_t we want to prevent
transit from pmd pointing to page table to pmd pinging to huge page (and
back) while interrupts are disabled.

The complication for Power is that it doesn't do implicit IPI on tlb
flush.

Is it correct?

For THP, split_huge_page() and collapse sides are covered. This patch
should address two cases of splitting PMD, but not compound page in
current upstream.

But I think there's still *big* problem for Power -- zap_huge_pmd().

For instance: other CPU can shoot out a THP PMD with MADV_DONTNEED and
fault in small pages instead. IIUC, for __find_linux_pte_or_hugepte(),
it's equivalent of splitting.

I don't see how this can be fixed without kick_all_cpus_sync() in all
pmdp_clear_flush() on Power.

-- 
 Kirill A. Shutemov
