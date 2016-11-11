Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFljn6SCzzDvpk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 03:29:15 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id u144so10510415wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:29:15 -0800 (PST)
Date: Fri, 11 Nov 2016 19:29:09 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] mm: THP page cache support for ppc64
Message-ID: <20161111162909.GG19382@node.shutemov.name>
References: <20161107083441.21901-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161107083441.21901-2-aneesh.kumar@linux.vnet.ibm.com>
 <20161111101439.GB19382@node.shutemov.name>
 <8737iy1ahw.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737iy1ahw.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 11, 2016 at 05:42:11PM +0530, Aneesh Kumar K.V wrote:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > On Mon, Nov 07, 2016 at 02:04:41PM +0530, Aneesh Kumar K.V wrote:
> >> @@ -2953,6 +2966,13 @@ static int do_set_pmd(struct fault_env *fe, struct page *page)
> >>  	ret = VM_FAULT_FALLBACK;
> >>  	page = compound_head(page);
> >>  
> >> +	/*
> >> +	 * Archs like ppc64 need additonal space to store information
> >> +	 * related to pte entry. Use the preallocated table for that.
> >> +	 */
> >> +	if (arch_needs_pgtable_deposit() && !fe->prealloc_pte)
> >> +		fe->prealloc_pte = pte_alloc_one(vma->vm_mm, fe->address);
> >> +
> >
> > -ENOMEM handling?
> 
> How about
> 
> 	if (arch_needs_pgtable_deposit() && !fe->prealloc_pte) {
> 		fe->prealloc_pte = pte_alloc_one(vma->vm_mm, fe->address);
> 		if (!fe->prealloc_pte)
> 			return VM_FAULT_OOM;
> 	}
> 
> 
> 
> >
> > I think we should do this way before this point. Maybe in do_fault() or
> > something.
> 
> doing this in do_set_pmd keeps this closer to where we set the pmd. Any
> reason you thing we should move it higher up the stack. We already do
> pte_alloc() at the same level for a non transhuge case in
> alloc_set_pte().

I vaguely remember Hugh mentioned deadlock of allocation under page-lock vs.
OOM-killer (or something else?).

If the deadlock is still there it would be matter of making preallocation
unconditional to fix the issue.

But what you propose about doesn't make situation any worse. I'm fine with
that.

-- 
 Kirill A. Shutemov
