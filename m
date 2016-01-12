Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A3891A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 11:03:42 +1100 (AEDT)
Message-ID: <1452557022.23317.7.camel@ellerman.id.au>
Subject: Re: [PATCH V2] mm/powerpc: Fix _PAGE_PTE breaking swapoff
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>, Laurent
 Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Date: Tue, 12 Jan 2016 11:03:42 +1100
In-Reply-To: <1452527374-4886-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452527374-4886-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Mon, 2016-01-11 at 21:19 +0530, Aneesh Kumar K.V wrote:

> Core kernel expect swp_entry_t to be consisting of
> only swap type and swap offset. We should not leak pte bits to
> swp_entry_t. This breaks swapoff which use the swap type and offset
> to build a swp_entry_t and later compare that to the swp_entry_t
> obtained from linux page table pte. Leaking pte bits to swp_entry_t
> breaks that comparison and results in us looping in try_to_unuse.
> 
> The stack trace can be anywhere below try_to_unuse() in mm/swapfile.c,
> since swapoff is circling around and around that function, reading from
> each used swap block into a page, then trying to find where that page
> belongs, looking at every non-file pte of every mm that ever swapped.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks. I slightly edited the wording in the change log and added:

Fixes: 6a119eae942c ("powerpc/mm: Add a _PAGE_PTE bit")

cheers
