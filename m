Return-Path: <siccegge@cs.fau.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29641B7D68
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:09:48 +1000 (EST)
Date: Wed, 9 Jun 2010 12:00:21 +0200
From: Christoph Egger <siccegge@cs.fau.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Removing dead CONFIG_SMP_750
Message-ID: <8bf8cfaf47590e1a85f9510bb546ca35e3458bf8.1275925219.git.siccegge@cs.fau.de>
References: <cover.1275925219.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1275925219.git.siccegge@cs.fau.de>
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_SMP_750 doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/powerpc/mm/tlb_hash32.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index 8aaa8b7..925fecb 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -94,11 +94,7 @@ void tlb_flush(struct mmu_gather *tlb)
  * the cache operations on the bus.  Hence we need to use an IPI
  * to get the other CPU(s) to invalidate their TLBs.
  */
-#ifdef CONFIG_SMP_750
-#define FINISH_FLUSH	smp_send_tlb_invalidate(0)
-#else
 #define FINISH_FLUSH	do { } while (0)
-#endif
 
 static void flush_range(struct mm_struct *mm, unsigned long start,
 			unsigned long end)
-- 
1.6.3.3
