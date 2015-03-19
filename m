Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBAC41A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 01:10:31 +1100 (AEDT)
Date: Thu, 19 Mar 2015 14:10:22 +0000
From: Mel Gorman <mgorman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
Message-ID: <20150319141022.GD3087@suse.de>
References: <20150312131045.GE3406@suse.de>
 <CA+55aFx=81BGnQFNhnAGu6CetL7yifPsnD-+v7Y6QRqwgH47gQ@mail.gmail.com>
 <20150312184925.GH3406@suse.de> <20150317070655.GB10105@dastard>
 <CA+55aFzdLnFdku-gnm3mGbeS=QauYBNkFQKYXJAGkrMd2jKXhw@mail.gmail.com>
 <20150317205104.GA28621@dastard>
 <CA+55aFzSPcNgxw4GC7aAV1r0P5LniyVVC66COz=3cgMcx73Nag@mail.gmail.com>
 <20150317220840.GC28621@dastard>
 <CA+55aFwne-fe_Gg-_GTUo+iOAbbNpLBa264JqSFkH79EULyAqw@mail.gmail.com>
 <CA+55aFy-Mw74rAdLMMMUgnsG3ZttMWVNGz7CXZJY7q9fqyRYfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <CA+55aFy-Mw74rAdLMMMUgnsG3ZttMWVNGz7CXZJY7q9fqyRYfg@mail.gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2015 at 10:31:28AM -0700, Linus Torvalds wrote:
> >  - something completely different that I am entirely missing
> 
> So I think there's something I'm missing. For non-shared mappings, I
> still have the idea that pte_dirty should be the same as pte_write.
> And yet, your testing of 3.19 shows that it's a big difference.
> There's clearly something I'm completely missing.
> 

Minimally, there is still the window where we clear the PTE to set the
protections. During that window, a fault can occur. In the old code which
was inherently racy and unsafe, the fault might still go ahead deferring
a potential migration for a short period. In the current code, it'll stall
on the lock, notice the PTE is changed and refault so the overhead is very
different but functionally correct.

In the old code, pte_write had complex interactions with background
cleaning and sync in the case of file mappings (not applicable to Dave's
case but still it's unpredictable behaviour). pte_dirty is close but there
are interactions with the application as the timing of writes vs the PTE
scanner matter.

Even if we restored the original behaviour, it would still be very difficult
to understand all the interactions between userspace and kernel.  The patch
below should be tested because it's clearer what the intent is. Using
the VMA flags is coarse but it's not vulnerable to timing artifacts that
behave differently depending on the machine. My preliminary testing shows
it helps but not by much. It does not restore performance to where it was
but it's easier to understand which is important if there are changes in
the scheduler later.

In combination, I also think that slowing PTE scanning when migration fails
is the correct action even if it is unrelated to the patch Dave bisected
to. It's stupid to increase scanning rates and incurs more faults when
migrations are failing so I'll be testing that next.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 626e93db28ba..2f12e9fcf1a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1291,17 +1291,8 @@ int do_huge_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		flags |= TNF_FAULT_LOCAL;
 	}
 
-	/*
-	 * Avoid grouping on DSO/COW pages in specific and RO pages
-	 * in general, RO pages shouldn't hurt as much anyway since
-	 * they can be in shared cache state.
-	 *
-	 * FIXME! This checks "pmd_dirty()" as an approximation of
-	 * "is this a read-only page", since checking "pmd_write()"
-	 * is even more broken. We haven't actually turned this into
-	 * a writable page, so pmd_write() will always be false.
-	 */
-	if (!pmd_dirty(pmd))
+	/* See similar comment in do_numa_page for explanation */
+	if (!(vma->vm_flags & VM_WRITE))
 		flags |= TNF_NO_GROUP;
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 411144f977b1..20beb6647dba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3069,16 +3069,19 @@ static int do_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	/*
-	 * Avoid grouping on DSO/COW pages in specific and RO pages
-	 * in general, RO pages shouldn't hurt as much anyway since
-	 * they can be in shared cache state.
+	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
+	 * much anyway since they can be in shared cache state. This misses
+	 * the case where a mapping is writable but the process never writes
+	 * to it but pte_write gets cleared during protection updates and
+	 * pte_dirty has unpredictable behaviour between PTE scan updates,
+	 * background writeback, dirty balancing and application behaviour.
 	 *
-	 * FIXME! This checks "pmd_dirty()" as an approximation of
-	 * "is this a read-only page", since checking "pmd_write()"
-	 * is even more broken. We haven't actually turned this into
-	 * a writable page, so pmd_write() will always be false.
+	 * TODO: Note that the ideal here would be to avoid a situation where a
+	 * NUMA fault is taken immediately followed by a write fault in
+	 * some cases which would have lower overhead overall but would be
+	 * invasive as the fault paths would need to be unified.
 	 */
-	if (!pte_dirty(pte))
+	if (!(vma->vm_flags & VM_WRITE))
 		flags |= TNF_NO_GROUP;
 
 	/*
