Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEDB41A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 16:20:27 +1100 (AEDT)
Received: by mail-pa0-x230.google.com with SMTP id fy10so57369189pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 21:20:27 -0800 (PST)
Message-ID: <1455600014.3308.9.camel@gmail.com>
Subject: Re: [PATCH V3] powerpc/mm: Fix Multi hit ERAT cause by recent THP
 update
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Date: Tue, 16 Feb 2016 16:20:14 +1100
In-Reply-To: <87d1ryfd94.fsf@linux.vnet.ibm.com>
References: <1454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455504278.16012.18.camel@gmail.com> <87lh6mfv2j.fsf@linux.vnet.ibm.com>
 <1455512997.16012.24.camel@gmail.com> <87d1ryfd94.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-15 at 16:31 +0530, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > > Now we can't depend for mm_cpumask, a parallel find_linux_pte_hugepte
> > > can happen outside that. Now i had a variant for kick_all_cpus_sync that
> > > ignored idle cpus. But then that needs more verification.
> > > 
> > > http://article.gmane.org/gmane.linux.ports.ppc.embedded/81105
> > Can be racy as a CPU moves from non-idle to idle
> > 
> > In
> > 
> > > +     pmd_hugepage_update(vma->vm_mm, address, pmdp, ~0UL, 0);
> > > +     /*
> > > +      * This ensures that generic code that rely on IRQ disabling
> > > +      * to prevent a parallel THP split work as expected.
> > > +      */
> > > +     kick_all_cpus_sync();
> > 
> > pmdp_invalidate()->pmd_hugepage_update() can still run in parallel with 
> > find_linux_pte_or_hugepte() and race.. Am I missing something?
> > 
> 
> Yes. But then we make sure that the pte_t returned by
> find_linux_pte_or_hugepte doesn't change to a regular pmd entry by using
> that kick. Now callers of find_lnux_pte_or_hugepte will check for
> _PAGE_PRESENT. So if it called before
> pmd_hugepage_update(_PAGE_PRESENT), we wait for the caller to finish the
> usage (via kick()). Or they bail out after finding _PAGE_PRESENT cleared.

Makes sense, but I would still check the assumption about checking for
_PAGE_PRESENT

Balbir Singh
