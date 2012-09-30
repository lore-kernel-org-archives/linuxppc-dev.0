Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A71692C0103
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 09:48:53 +1000 (EST)
Received: from jgg by quartz.orcorp.ca with local (Exim 4.72)
 (envelope-from <jgunthorpe@obsidianresearch.com>) id 1TISwJ-00086u-Kq
 for linuxppc-dev@lists.ozlabs.org; Sun, 30 Sep 2012 17:28:47 -0600
Date: Sun, 30 Sep 2012 17:28:47 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PPC: Correct the tophys/tovirt macros
Message-ID: <20120930232847.GG30637@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

asm/page.h discusses the calculation for v2p and p2v, it should be:
 va = pa + KERNELBASE - PHYSICAL_START
which is the same as:
 va = pa + LOAD_OFFSET

tophys/tovirt were using PAGE_OFFSET, which as page.h says, is almost
always the same thing.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/powerpc/include/asm/ppc_asm.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ea2a86e..44edc3a 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -461,14 +461,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define fromreal(rd)	tovirt(rd,rd)
 
 #define tophys(rd,rs)				\
-0:	addis	rd,rs,-PAGE_OFFSET@h;		\
+0:	addis	rd,rs,-LOAD_OFFSET@h;		\
 	.section ".vtop_fixup","aw";		\
 	.align  1;				\
 	.long   0b;				\
 	.previous
 
 #define tovirt(rd,rs)				\
-0:	addis	rd,rs,PAGE_OFFSET@h;		\
+0:	addis	rd,rs,LOAD_OFFSET@h;		\
 	.section ".ptov_fixup","aw";		\
 	.align  1;				\
 	.long   0b;				\
-- 
1.7.4.1
