Return-Path: <kirill@shutemov.name>
Received: from mail-wj0-x241.google.com (mail-wj0-x241.google.com
 [IPv6:2a00:1450:400c:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txZHZ3MBLzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 10:29:12 +1100 (AEDT)
Received: by mail-wj0-x241.google.com with SMTP id kp2so83376563wjc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jan 2017 15:29:12 -0800 (PST)
Date: Mon, 9 Jan 2017 02:29:04 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: stop leaking PageTables
Message-ID: <20170108232904.GA17681@node.shutemov.name>
References: <alpine.LSU.2.11.1701071526090.1130@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.11.1701071526090.1130@eggly.anvils>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 07, 2017 at 03:37:31PM -0800, Hugh Dickins wrote:
> 4.10-rc loadtest (even on x86, even without THPCache) fails with
> "fork: Cannot allocate memory" or some such; and /proc/meminfo
> shows PageTables growing.
> 
> rc1 removed the freeing of an unused preallocated pagetable after
> do_fault_around() has called map_pages(): which is usually a good
> optimization, so that the followup doesn't have to reallocate one;
> but it's not sufficient to shift the freeing into alloc_set_pte(),
> since there are failure cases (most commonly VM_FAULT_RETRY) which
> never reach finish_fault().
> 
> Check and free it at the outer level in do_fault(), then we don't
> need to worry in alloc_set_pte(), and can restore that to how it was
> (I cannot find any reason to pte_free() under lock as it was doing).
> 
> And fix a separate pagetable leak, or crash, introduced by the same
> change, that could only show up on some ppc64: why does do_set_pmd()'s
> failure case attempt to withdraw a pagetable when it never deposited
> one, at the same time overwriting (so leaking) the vmf->prealloc_pte?
> Residue of an earlier implementation, perhaps?  Delete it.
> 
> Fixes: 953c66c2b22a ("mm: THP page cache support for ppc64")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Sorry, that I missed this initially.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
