Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lMO5030114@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:52 -0700
Cc: akpm@osdl.org, sfr@canb.auug.org.au, boutcher@us.ibm.com,
	linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [patch 37/43] ppc64: make dma_addr_t 64 bits
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Stephen Rothwell <sfr@canb.auug.org.au>

There has been a need expressed for dma_addr_t to be 64 bits on PPC64. 
This patch does that.  I have built it for pSeries and iSeries and booted a
virtual only iSeries partition.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Dave Boutcher <boutcher@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-ppc64/scatterlist.h |    2 +-
 include/asm-ppc64/types.h       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/asm-ppc64/scatterlist.h~ppc64-make-dma_addr_t-64-bits include/asm-ppc64/scatterlist.h
--- devel/include/asm-ppc64/scatterlist.h~ppc64-make-dma_addr_t-64-bits	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/include/asm-ppc64/scatterlist.h	2005-10-28 17:44:04.000000000 -0700
@@ -19,7 +19,7 @@ struct scatterlist {
 	unsigned int length;
 
 	/* For TCE support */
-	u32 dma_address;
+	dma_addr_t dma_address;
 	u32 dma_length;
 };
 
diff -puN include/asm-ppc64/types.h~ppc64-make-dma_addr_t-64-bits include/asm-ppc64/types.h
--- devel/include/asm-ppc64/types.h~ppc64-make-dma_addr_t-64-bits	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/include/asm-ppc64/types.h	2005-10-28 17:44:04.000000000 -0700
@@ -63,7 +63,7 @@ typedef unsigned long u64;
 
 typedef __vector128 vector128;
 
-typedef u32 dma_addr_t;
+typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
 
 typedef struct {
_
