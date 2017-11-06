Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmby0FPnzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:55:24 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id 8so10006311qtv.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:55:24 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 0/8] powerpc: Free up RPAGE_RSV bits
Date: Mon,  6 Nov 2017 00:50:44 -0800
Message-Id: <1509958252-18302-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RPAGE_RSV0..4 PTE bits are currently used for HPTE slot tracking.
We need these bits for memory-protection keys. Luckily these four
bits are relatively easier to move among all the other candidate
bits.

For 64K linux-PTEs backed by 4k HPTEs, these bits are used for
tracking the validity of the slot value stored in the
second-part-of-the-PTE. We device a new mechanism for tracking
the validity without using those bits. The mechanism is
explained in the first patch.

For 64K linux-PTE backed by 64K HPTEs, we simply move the slot
tracking bits to the second-part-of-the-PTE.

The above mechanism is also used to free the bits for hugetlb
linux-PTEs.

For 4k linux-PTE, we have only 3 free bits available. We swizzle
around the bits and release RPAGE_RSV{2,3,4} for memory protection
keys.

Testing:
--------
has survived kernel compilation on multiple platforms
p8 powernv hash-mode, p9 powernv hash-mode, p7 powervm,
p8-powervm, p8-kvm-guest.

History:
-------
This patchset is a spin-off from the memkey patchset.

version v10:
	(1) hidx value is rotated by one to save
		initialization of the secondary-PTE.
	(2) comments are not anymore right justified.
		-- comment by mpe

version v9:
	(1) rearranged the patch order. First the helper
	routines are defined followed by the
	patches that make use of the helpers.

version v8:
	(1) an additional patch added to free up
	RSV{2,3,4} on 4K linux-PTE.

version v7:
	(1) GIX bit reset change moved to the second
		patch -- noticed by Aneesh.
	(2) Separated this patches from memkey patchset
	(3) merged a bunch of patches, that used the
		helper function, into one.
version v6:
	(1) No changes related to PTE.

version v5:
	(1) No changes related to PTE.

version v4:
	(1) No changes related to PTE.

version v3:
	(1) split the patches into smaller consumable
		patches.
	(2) A bug fix while invalidating a HPTE slot
		in __hash_page_4K()
		-- noticed by Aneesh
version v2:
 	(1) fixed a bug in 4k HPTE backed 64k PTE
		where page invalidation was not
		done correctly, and initialization
		of second-part-of-the-PTE was not
		done correctly if the PTE was not
		yet Hashed with a HPTE.
		--	Reported by Aneesh.
	
version v1: Initial version

Ram Pai (8):
  powerpc: introduce pte_set_hidx() helper
  powerpc: introduce pte_get_hash_gslot() helper
  powerpc: Free up four 64K PTE bits in 4K backed HPTE pages
  powerpc: Free up four 64K PTE bits in 64K backed HPTE pages
  powerpc: shifted-by-one hidx value
  powerpc: Swizzle around 4K PTE bits to free up bit 5 and bit 6
  powerpc: use helper functions to get and set hash slots
  powerpc: capture the PTE format changes in the dump pte report

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   20 ++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   71 ++++++++++----
 arch/powerpc/include/asm/book3s/64/hash.h     |    8 +-
 arch/powerpc/mm/dump_linuxpagetables.c        |    3 +-
 arch/powerpc/mm/hash64_4k.c                   |   14 +--
 arch/powerpc/mm/hash64_64k.c                  |  123 +++++++++++++------------
 arch/powerpc/mm/hash_utils_64.c               |   35 +++++--
 arch/powerpc/mm/hugetlbpage-hash64.c          |   16 +--
 8 files changed, 175 insertions(+), 115 deletions(-)
