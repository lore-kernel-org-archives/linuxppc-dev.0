Return-Path: <penberg@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 987D4DDF0A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 06:41:50 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so740552rvf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Mar 2008 11:41:47 -0800 (PST)
Message-ID: <84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
Date: Tue, 4 Mar 2008 21:41:47 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
In-Reply-To: <20080304193532.GC9051@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com>
	<20080304103636.3e7b8fdd.akpm@linux-foundation.org>
	<47CDA081.7070503@cs.helsinki.fi> <20080304193532.GC9051@csn.ul.ie>
Cc: linuxppc-dev@ozlabs.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(adding Christoph as cc)

On Tue, Mar 4, 2008 at 9:35 PM, Mel Gorman <mel@csn.ul.ie> wrote:
>  > >> [c000000009edf5f0] [c0000000000b56e4] .__alloc_pages_internal+0xf8/0x470
>  > >> [c000000009edf6e0] [c0000000000e0458] .kmem_getpages+0x8c/0x194
>  > >> [c000000009edf770] [c0000000000e1050] .fallback_alloc+0x194/0x254
>  > >> [c000000009edf820] [c0000000000e14b0] .kmem_cache_alloc+0xd8/0x144
>  > >> [c000000009edf8c0] [c0000000001fe0f8] .radix_tree_preload+0x50/0xd4
>  > >> [c000000009edf960] [c0000000000ad048] .add_to_page_cache+0x38/0x12c
>  > >> [c000000009edfa00] [c0000000000ad158] .add_to_page_cache_lru+0x1c/0x4c
>  > >> [c000000009edfa90] [c0000000000add58] .find_or_create_page+0x60/0xa8
>  > >> [c000000009edfb30] [c00000000011e478] .__getblk+0x140/0x310
>  > >> [c000000009edfc00] [c0000000001b78c4]
>  > >.journal_get_descriptor_buffer+0x44/0xd8
>  > >> [c000000009edfca0] [c0000000001b236c]
>  > >.journal_commit_transaction+0x948/0x1590
>  > >> [c000000009edfe00] [c0000000001b585c] .kjournald+0xf4/0x2ac
>  > >> [c000000009edff00] [c00000000007ff4c] .kthread+0x84/0xd0
>  > >> [c000000009edff90] [c000000000028900] .kernel_thread+0x4c/0x68
>  > >> Instruction dump:
>  > >> 7dc57378 48009575 60000000 2fa30000 419e0490 56c902d8 3c000018 7dd907b4
>  > >> 7ad2c7e2 7f890000 7c000026 5400fffe <0b000000> e93e8128 3b000000
>  > >80090000
>  > >/* Convert GFP flags to their corresponding migrate type */
>  > >static inline int allocflags_to_migratetype(gfp_t gfp_flags)
>  > >{
>  > >        WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
>  > >
>  > >Mel, Pekka: would you have some head-scratching time for this one please?
>  >
>  > What we have is __getblk() -> __getblk_slow() -> grow_buffers() ->
>  > grow_dev_page() doing find_or_create_page() with __GFP_MOVABLE set. That
>  > path then eventually does radix_tree_preload -> kmem_cache_alloc() to a
>  > cache that has SLAB_RECLAIM_ACCOUNT set which implies __GFP_RECLAIMABLE
>  > (for both SLAB and SLUB). So we oops there.
>  >
>  > I suspect the WARN_ON() is bogus although I really don't know that part
>  > of the code all too well. Mel?
>  >
>
>  The warn-on is valid. A situation should not exist that allows both flags to
>  be set. I suspect  if remove-set_migrateflags.patch was reverted from -mm
>  the warning would not trigger. Christoph, would it be reasonable to always
>  clear __GFP_MOVABLE when __GFP_RECLAIMABLE is set for SLAB_RECLAIM_ACCOUNT.
>
>  --
>  Mel Gorman
>  Part-time Phd Student                          Linux Technology Center
>  University of Limerick                         IBM Dublin Software Lab
>
>
>
>  --
>  To unsubscribe, send a message with 'unsubscribe linux-mm' in
>  the body to majordomo@kvack.org.  For more info on Linux MM,
>  see: http://www.linux-mm.org/ .
>  Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
