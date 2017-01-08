Return-Path: <hughd@google.com>
Received: from mail-pg0-x22d.google.com (mail-pg0-x22d.google.com
 [IPv6:2607:f8b0:400e:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txV6v6DJwzDqW4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 07:21:27 +1100 (AEDT)
Received: by mail-pg0-x22d.google.com with SMTP id 204so14861060pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jan 2017 12:21:27 -0800 (PST)
Date: Sun, 8 Jan 2017 12:21:16 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Hugh Dickins <hughd@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: stop leaking PageTables
In-Reply-To: <87mvf2kpfa.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1701081209550.3615@eggly.anvils>
References: <alpine.LSU.2.11.1701071526090.1130@eggly.anvils>
 <87mvf2kpfa.fsf@linux.vnet.ibm.com>
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

On Sun, 8 Jan 2017, Aneesh Kumar K.V wrote:
> Hugh Dickins <hughd@google.com> writes:
> 
> > And fix a separate pagetable leak, or crash, introduced by the same
> > change, that could only show up on some ppc64: why does do_set_pmd()'s
> > failure case attempt to withdraw a pagetable when it never deposited
> > one, at the same time overwriting (so leaking) the vmf->prealloc_pte?
> > Residue of an earlier implementation, perhaps?  Delete it.
> 
> That change is part of -mm tree.
> 
> https://lkml.kernel.org/r/20161212163428.6780-1-aneesh.kumar@linux.vnet.ibm.com

Ah, so it is, I hadn't looked there.  That's reassuring,
I'm glad to know you reached the same conclusion on that piece of code.

It still worried me that the fix is languishing in mmotm, but it looks
not lost: akpm would have sent it in a couple of days anyway, and only
affected ppc64 (like the related khugepaged patch you have queued there).

> 
> >
> > Fixes: 953c66c2b22a ("mm: THP page cache support for ppc64")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, and to Linus, who already has this in for -rc3: so akpm can drop
mm-thp-pagecache-only-withdraw-page-table-after-a-successful-deposit.patch
and then later send in your
mm-thp-pagecache-collapse-free-the-pte-page-table-on-collapse-for-thp-page-cache.patch

Hugh
