Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJWTv2j1lzDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 08:28:03 +1000 (AEST)
Message-ID: <1464647262.3078.219.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/hash: Fix the reference bit update when
 handling hash fault
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 May 2016 08:27:42 +1000
In-Reply-To: <alpine.LSU.2.11.1605300903270.1076@eggly.anvils>
References: <201605270629.u4R6OCLx014831@mx0a-001b2d01.pphosted.com>
 <alpine.LSU.2.11.1605300903270.1076@eggly.anvils>
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

On Mon, 2016-05-30 at 09:39 -0700, Hugh Dickins wrote:
> I don't mean to be churlish, and subtract from your triumph in tracking
> this down (assuming you have), but that commit log... okay, it's intended
> for powerpc mmu experts, not me, but if it hasn't already gone into git,
> then a rewrite could be very helpful.

Something along these lines:

The powerpc hash table has a R (Referenced) and C (Changed) bits that
somewhat correspond to Linux _PAGE_DIRTY and _PAGE_ACCESSED. However we
don't currently use them.

Moreover, we also require them to never be updated by HW. This is due
to an optimization we have in the hash eviction code, which would be
racy vs. a hardware update as the HW updates are done non-atomically.

Thus it's critical that valid hash PTEs always have R set and writeable
ones have C set. We do this by hashing a non-dirty linux PTE as read-only and always setting _PAGE_ACCESSED (and thus R) when hashing anything else in. Any attempt by Linux at clearing those bits also removes the corresponding hash entry.

The old commit <.....> fixed an issue where we would miss setting C in
the specific case where a Linux PTE was upgraded from read only to
read-write (and appropriately made dirty). The hash code would realize
the hash PTE is already present and would use a different path than the
normal insertion path for updating a hash entry in-place. That path
unfortunately didn't update "C".

That commit however got a bit over zealous and also forced C on any
entry including those that aren't writeable. That was unnecessary.

In commit 89ff725051d1, when converting to C, we mangled that up:

 - We kept the useless part of <....> setting C always instead of
only when _PAGE_DIRTY is set

 - We never set R thus letting the HW do the racy updates.

This fixes it.

Ben.
