Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18520.44515.740845.910077@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jun 2008 16:40:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] Clear sub-page HPTE present bits when demoting page size
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we demote a slice from 64k to 4k, and we are about to insert an
HPTE for a 4k subpage and we notice that there is an existing 64k
HPTE, we first invalidate that HPTE before inserting the new 4k
subpage HPTE.  Since the bits that encode which hash bucket the old
HPTE was in overlap with the bits that encode which of the 16 subpages
have HPTEs, we need to clear out the subpage HPTE-present bits before
starting to insert HPTEs for the 4k subpages.  If we don't do that, we
can erroneously think that a subpage already has an HPTE when it
doesn't.

That in itself wouldn't be such a problem except that when we go to
update the HPTE that we think is present on machines with a
hypervisor, the hypervisor can tell us that the HPTE we think is there
is actually there even though it isn't, which can lead to a process
getting stuck in a loop, continually faulting.  The reason for the
confusion is that the AVPN (abbreviated virtual page number) we are
looking for in the HPTE for a 4k subpage can actually match the AVPN
in a stale HPTE for another 64k page.  For example, the HPTE for
the 4k subpage at 0x84000f000 will be in the same hash bucket and have
the same AVPN as the HPTE for the 64k page at 0x8400f0000.

This fixes the code to clear out the subpage HPTE-present bits.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 21d2484..70f4c83 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -568,6 +568,10 @@ htab_inval_old_hpte:
 	ld	r7,STK_PARM(r9)(r1)	/* ssize */
 	ld	r8,STK_PARM(r8)(r1)	/* local */
 	bl	.flush_hash_page
+	/* Clear out _PAGE_HPTE_SUB bits in the new linux PTE */
+	lis	r0,_PAGE_HPTE_SUB@h
+	ori	r0,r0,_PAGE_HPTE_SUB@l
+	andc	r30,r30,r0
 	b	htab_insert_pte
 	
 htab_bail_ok:
