Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 25 Oct 2005 16:56:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051025165643.39cac31d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] ppc64: make dma_addr_t 64 bits
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There has been a need expressed for dma_addr_t to be 64 bits on PPC64.
This patch does that.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 drivers/net/ibmveth.c           |    2 +-
 include/asm-powerpc/types.h     |    4 ++++
 include/asm-ppc64/scatterlist.h |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

3be60638aece21cb4ca9b98ffb0ed349ec3e192a
diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -532,7 +532,7 @@ static int ibmveth_open(struct net_devic
 
 	if(lpar_rc != H_Success) {
 		ibmveth_error_printk("h_register_logical_lan failed with %ld\n", lpar_rc);
-		ibmveth_error_printk("buffer TCE:0x%x filter TCE:0x%x rxq desc:0x%lx MAC:0x%lx\n",
+		ibmveth_error_printk("buffer TCE:0x%lx filter TCE:0x%lx rxq desc:0x%lx MAC:0x%lx\n",
 				     adapter->buffer_list_dma,
 				     adapter->filter_list_dma,
 				     rxq_desc.desc,
diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -83,7 +83,11 @@ typedef unsigned long long u64;
 
 typedef __vector128 vector128;
 
+#ifdef __powerpc64__
+typedef u64 dma_addr_t;
+#else
 typedef u32 dma_addr_t;
+#endif
 typedef u64 dma64_addr_t;
 
 typedef struct {
diff --git a/include/asm-ppc64/scatterlist.h b/include/asm-ppc64/scatterlist.h
--- a/include/asm-ppc64/scatterlist.h
+++ b/include/asm-ppc64/scatterlist.h
@@ -19,7 +19,7 @@ struct scatterlist {
 	unsigned int length;
 
 	/* For TCE support */
-	u32 dma_address;
+	dma_addr_t dma_address;
 	u32 dma_length;
 };
 
