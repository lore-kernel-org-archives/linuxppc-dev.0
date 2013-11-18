Return-Path: <anton@samba.org>
Date: Mon, 18 Nov 2013 14:55:28 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, walken@google.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc: ppc64 address space capped at 32TB, mmap
 randomisation disabled
Message-ID: <20131118145528.2329a1ab@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Commit fba2369e6ceb (mm: use vm_unmapped_area() on powerpc architecture)
has a bug in slice_scan_available() where we compare an unsigned long
(high_slices) against a shifted int. As a result, comparisons against
the top 32 bits of high_slices (representing the top 32TB) always
returns 0 and the top of our mmap region is clamped at 32TB

This also breaks mmap randomisation since the randomised address is
always up near the top of the address space and it gets clamped down
to 32TB.

Cc: stable@vger.kernel.org # v3.10+
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 3e99c14..7ce9cf3 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -258,7 +258,7 @@ static bool slice_scan_available(unsigned long addr,
 		slice = GET_HIGH_SLICE_INDEX(addr);
 		*boundary_addr = (slice + end) ?
 			((slice + end) << SLICE_HIGH_SHIFT) : SLICE_LOW_TOP;
-		return !!(available.high_slices & (1u << slice));
+		return !!(available.high_slices & (1ul << slice));
 	}
 }
 
