Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 54/63] ibmveth: Fix little endian issues
Date: Wed,  7 Aug 2013 02:02:11 +1000
Message-Id: <1375804940-22050-55-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hypervisor is big endian, so little endian kernel builds need
to byteswap.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/net/ethernet/ibm/ibmveth.c |  4 ++--
 drivers/net/ethernet/ibm/ibmveth.h | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 70fd559..5d41aee 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -106,7 +106,7 @@ struct ibmveth_stat ibmveth_stats[] = {
 /* simple methods of getting data from the current rxq entry */
 static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
 {
-	return adapter->rx_queue.queue_addr[adapter->rx_queue.index].flags_off;
+	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].flags_off);
 }
 
 static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
@@ -132,7 +132,7 @@ static inline int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
 {
-	return adapter->rx_queue.queue_addr[adapter->rx_queue.index].length;
+	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
 }
 
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 43a794f..84066ba 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -164,14 +164,26 @@ struct ibmveth_adapter {
     u64 tx_send_failed;
 };
 
+/*
+ * We pass struct ibmveth_buf_desc_fields to the hypervisor in registers,
+ * so we don't need to byteswap the two elements. However since we use
+ * a union (ibmveth_buf_desc) to convert from the struct to a u64 we
+ * do end up with endian specific ordering of the elements and that
+ * needs correcting.
+ */
 struct ibmveth_buf_desc_fields {
+#ifdef __BIG_ENDIAN
+	u32 flags_len;
+	u32 address;
+#else
+	u32 address;
 	u32 flags_len;
+#endif
 #define IBMVETH_BUF_VALID	0x80000000
 #define IBMVETH_BUF_TOGGLE	0x40000000
 #define IBMVETH_BUF_NO_CSUM	0x02000000
 #define IBMVETH_BUF_CSUM_GOOD	0x01000000
 #define IBMVETH_BUF_LEN_MASK	0x00FFFFFF
-	u32 address;
 };
 
 union ibmveth_buf_desc {
@@ -180,7 +192,7 @@ union ibmveth_buf_desc {
 };
 
 struct ibmveth_rx_q_entry {
-	u32 flags_off;
+	__be32 flags_off;
 #define IBMVETH_RXQ_TOGGLE		0x80000000
 #define IBMVETH_RXQ_TOGGLE_SHIFT	31
 #define IBMVETH_RXQ_VALID		0x40000000
@@ -188,7 +200,8 @@ struct ibmveth_rx_q_entry {
 #define IBMVETH_RXQ_CSUM_GOOD		0x01000000
 #define IBMVETH_RXQ_OFF_MASK		0x0000FFFF
 
-	u32 length;
+	__be32 length;
+	/* correlator is only used by the OS, no need to byte swap */
 	u64 correlator;
 };
 
-- 
1.8.1.2
