Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsr53PFVzDrWB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:29 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id k2so2348348qte.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:29 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 0/7] powerpc: Free up RPAGE_RSV bits
Date: Fri,  8 Sep 2017 15:44:40 -0700
Message-Id: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RPAGE_RSV0..4 pte bits are currently used for hpte slot
tracking. We  need  these bits   for  memory-protection
keys. Luckily these  four bits   are  relatively easier 
to move among all the other candidate bits.

For  64K   linux-ptes   backed  by 4k hptes, these bits
are   used for tracking the  validity of the slot value
stored   in the second-part-of-the-pte. We device a new
mechanism for  tracking   the   validity  without using
those bits. The    mechanism  is explained in the patch.

For 64K  linux-pte  backed by 64K hptes, we simply move
the   slot  tracking bits to the second-part-of-the-pte.

The above  mechanism  is also used to free the bits for
hugetlb linux-ptes.

For 4k linux-pte, we  have only 3 free  bits  available.
We swizzle around the bits and release RPAGE_RSV{2,3,4}
for memory protection keys.

Testing:
--------
has survived  kernel  compilation on multiple platforms
p8 powernv hash-mode, p9 powernv hash-mode,  p7 powervm,
p8-powervm, p8-kvm-guest.

Has survived git-bisect on p8  power-nv  with  64K page
and 4K page.

History:
-------
This patchset  is  a  spin-off from the memkey patchset.

version v9:
	(1) rearranged the patch order. First the helper
		routines are defined followed   by  the
		patches that make use of the helpers.

version v8:
	(1) an  additional  patch   added  to  free  up
             RSV{2,3,4} on 4K linux-pte.

version v7:
	(1) GIX bit reset change  moved  to  the second
		patch  -- noticed by Aneesh.
	(2) Separated this patches from memkey patchset
	(3) merged a  bunch  of  patches, that used the
       		helper function, into one.
version v6:
	(1) No changes related to pte.

version v5:
	(1) No changes related to pte.

version v4:
	(1) No changes related to pte.

version v3:
	(1) split the patches into smaller consumable
		patches.
	(2) A bug fix while  invalidating a hpte slot
		in __hash_page_4K()
       		-- noticed by Aneesh
	

version v2:
 	(1) fixed a  bug  in 4k  hpte  backed 64k pte
       		where  page    invalidation   was not
		done  correctly,  and  initialization
	       	of    second-part-of-the-pte  was not
		done    correctly  if the pte was not
	       	yet Hashed with a hpte.
	       	   --	Reported by Aneesh.
	

version v1: Initial version

Ram Pai (7):
  powerpc: introduce pte_set_hash_slot() helper
  powerpc: introduce pte_get_hash_gslot() helper
  powerpc: Free up four 64K PTE bits in 4K backed HPTE pages
  powerpc: Free up four 64K PTE bits in 64K backed HPTE pages
  powerpc: Swizzle around 4K PTE bits to free up bit 5 and bit 6
  powerpc: use helper functions to get and set hash slots
  powerpc: capture the PTE format changes in the dump pte report

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   21 ++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   61 ++++++++----
 arch/powerpc/include/asm/book3s/64/hash.h     |    8 +-
 arch/powerpc/mm/dump_linuxpagetables.c        |    3 +-
 arch/powerpc/mm/hash64_4k.c                   |   14 +--
 arch/powerpc/mm/hash64_64k.c                  |  131 +++++++++++++------------
 arch/powerpc/mm/hash_utils_64.c               |   35 +++++--
 arch/powerpc/mm/hugetlbpage-hash64.c          |   18 ++--
 8 files changed, 171 insertions(+), 120 deletions(-)
