Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 879901007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 04:40:21 +1100 (EST)
Date: Wed, 30 Dec 2009 20:40:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/swsusp_32: Fix TLB invalidation
Message-ID: <20091230174017.GA32283@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems there is a thinko in the TLB invalidation code that makes the
tlbie in the loop executed just once. The intended check was probably
'gt', not 'lt'.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Btw, 'lis r4,0x1000' seems needlessly too high. e300 core reference
manual says:

  The [...]tlbie[...] instruction invalidates the TLB entry indexed by
  the EA, and operates on both the instruction and data TLBs
  simultaneously invalidating four TLB entries (both sets in each TLB).
  The index corresponds to bits 15-19 of the EA. To invalidate all
  entries within both TLBs, 32 tlbie instructions should be issued,
  incrementing this field by one each time.

So, shouldn't 0x1000 be 0x0002? Are there any classic PowerPCs
for which this wouldn't work?

 arch/powerpc/kernel/swsusp_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/swsusp_32.S b/arch/powerpc/kernel/swsusp_32.S
index b47d8ce..b0754e2 100644
--- a/arch/powerpc/kernel/swsusp_32.S
+++ b/arch/powerpc/kernel/swsusp_32.S
@@ -303,7 +303,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	lis	r4,0x1000
 1:	addic.	r4,r4,-0x1000
 	tlbie	r4
-	blt	1b
+	bgt	1b
 	sync
 
 	/* restore the MSR and turn on the MMU */
-- 
1.6.5.7
