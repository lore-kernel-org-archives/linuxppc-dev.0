Return-Path: <kas@node.shutemov.name>
Received: from jenni2.inet.fi (mta-out1.inet.fi [62.71.2.195])
 by lists.ozlabs.org (Postfix) with ESMTP id 48B271A0386
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:46:55 +1000 (AEST)
Date: Mon, 11 May 2015 10:46:31 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] powerpc/thp: Serialize pmd clear against a linux page
 table walk.
Message-ID: <20150511074631.GA10974@node.dhcp.inet.fi>
References: <1431325561-21396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431325561-21396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Mon, May 11, 2015 at 11:56:01AM +0530, Aneesh Kumar K.V wrote:
> Serialize against find_linux_pte_or_hugepte which does lock-less
> lookup in page tables with local interrupts disabled. For huge pages
> it casts pmd_t to pte_t. Since format of pte_t is different from
> pmd_t we want to prevent transit from pmd pointing to page table
> to pmd pointing to huge page (and back) while interrupts are disabled.
> We clear pmd to possibly replace it with page table pointer in
> different code paths. So make sure we wait for the parallel
> find_linux_pte_or_hugepage to finish.
> 
> Without this patch, a find_linux_pte_or_hugepte running in parallel to
> __split_huge_zero_page_pmd or do_huge_pmd_wp_page_fallback or zap_huge_pmd
> can run into the above issue. With __split_huge_zero_page_pmd and
> do_huge_pmd_wp_page_fallback we clear the hugepage pte before inserting
> the pmd entry with a regular pgtable address. Such a clear need to
> wait for the parallel find_linux_pte_or_hugepte to finish.
> 
> With zap_huge_pmd, we can run into issues, with a hugepage pte
> getting zapped due to a MADV_DONTNEED while other cpu fault it
> in as small pages.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

CC: stable@ ?

-- 
 Kirill A. Shutemov
