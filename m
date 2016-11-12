Return-Path: <hughd@google.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFzt15JVyzDvhB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 12:37:13 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id c4so2846546pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 17:37:12 -0800 (PST)
Date: Fri, 11 Nov 2016 17:37:03 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] mm: THP page cache support for ppc64
In-Reply-To: <20161111162909.GG19382@node.shutemov.name>
Message-ID: <alpine.LSU.2.11.1611111702170.10776@eggly.anvils>
References: <20161107083441.21901-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161107083441.21901-2-aneesh.kumar@linux.vnet.ibm.com>
 <20161111101439.GB19382@node.shutemov.name>
 <8737iy1ahw.fsf@linux.vnet.ibm.com>
 <20161111162909.GG19382@node.shutemov.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Nov 2016, Kirill A. Shutemov wrote:
> On Fri, Nov 11, 2016 at 05:42:11PM +0530, Aneesh Kumar K.V wrote:
> > 
> > doing this in do_set_pmd keeps this closer to where we set the pmd. Any
> > reason you thing we should move it higher up the stack. We already do
> > pte_alloc() at the same level for a non transhuge case in
> > alloc_set_pte().
> 
> I vaguely remember Hugh mentioned deadlock of allocation under page-lock vs.
> OOM-killer (or something else?).

You remember well.  It was indeed the OOM killer, but in particular due
to the way it used to wait for a current victim to exit, and that exit
could be delayed forever by the way munlock_vma_pages_all() goes to lock
each page in a VM_LOCKED area - a pity if one of them is the page we
hold locked while servicing a fault and need to allocate a pagetable.

> 
> If the deadlock is still there it would be matter of making preallocation
> unconditional to fix the issue.

I think enough has changed at the OOM killer end that the deadlock is
no longer there.  I haven't kept up with all the changes made recently,
but I think we no longer wait for a unique victim to exit before trying
another (reaped mms set MMF_OOM_SKIP); and the OOM reaper skips over
VM_LOCKED areas to avoid just such a deadlock.

It's still silly that munlock_vma_pages_all() should require page lock
on each of those pages; but neither Michal nor I have had time to
revisit our attempts to relieve that requirement - mlock.c is not easy.

> 
> But what you propose about doesn't make situation any worse. I'm fine with
> that.

Yes, I think that's right: if there is a problem, then it would already
be problem since alloc_set_pte() was created; but we've seen no reports.

Hugh
