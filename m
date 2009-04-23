Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7F256DE067
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 22:56:12 +1000 (EST)
Date: Thu, 23 Apr 2009 22:56:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: [PATCH v2] powerpc: fix for long standing bug noticed by gcc 4.4.0
Message-Id: <20090423225611.d569764c.sfr@canb.auug.org.au>
In-Reply-To: <20090423103336.GA3825@zod.rchland.ibm.com>
References: <20090423160656.fac84e3f.sfr@canb.auug.org.au>
	<20090423103336.GA3825@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previous gcc versions didn't notice this because one of the preceding
#ifs always evaluated to true.

gcc 4.4.0 produced this error:

arch/powerpc/mm/tlb_nohash_low.S:206:6: error: #elif with no expression

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb_nohash_low.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

v2: fixed up commit message, added Josh'd Ack.

diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 45fed36..21e1b9a 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -203,6 +203,6 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	isync
 1:	wrtee	r10
 	blr
-#elif
+#else
 #error Unsupported processor type !
 #endif
-- 
1.6.2.3


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
