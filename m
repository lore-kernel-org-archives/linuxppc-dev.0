Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5D7B8DDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 12:00:52 +1000 (EST)
Date: Mon, 23 Jul 2007 12:01:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Klein <osstklei@de.ibm.com>, Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH] ehea: silence some warnings
Message-Id: <20070723120110.eaf77203.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/net/ehea/ehea_main.c: In function 'write_swqe2_TSO':
drivers/net/ehea/ehea_main.c:1335: warning: passing argument 1 of 'ehea_map_vaddr' makes pointer from integer without a cast
drivers/net/ehea/ehea_main.c: In function 'write_swqe2_nonTSO':
drivers/net/ehea/ehea_main.c:1366: warning: passing argument 1 of 'ehea_map_vaddr' makes pointer from integer without a cast
drivers/net/ehea/ehea_main.c: In function 'write_swqe2_data':
drivers/net/ehea/ehea_main.c:1405: warning: passing argument 1 of 'ehea_map_vaddr' makes pointer from integer without a cast
drivers/net/ehea/ehea_main.c:1420: warning: passing argument 1 of 'ehea_map_vaddr' makes pointer from integer without a cast

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ehea/ehea_main.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 4c70a93..8adcd6f 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -1309,7 +1309,6 @@ static void write_swqe2_TSO(struct sk_buff *skb,
 	u8 *imm_data = &swqe->u.immdata_desc.immediate_data[0];
 	int skb_data_size = skb->len - skb->data_len;
 	int headersize;
-	u64 tmp_addr;
 
 	/* Packet is TCP with TSO enabled */
 	swqe->tx_control |= EHEA_SWQE_TSO;
@@ -1331,8 +1330,8 @@ static void write_swqe2_TSO(struct sk_buff *skb,
 			sg1entry->l_key = lkey;
 			sg1entry->len = skb_data_size - headersize;
 
-			tmp_addr = (u64)(skb->data + headersize);
-			sg1entry->vaddr = ehea_map_vaddr(tmp_addr);
+			sg1entry->vaddr =
+				ehea_map_vaddr(skb->data + headersize);
 			swqe->descriptors++;
 		}
 	} else
@@ -1345,7 +1344,6 @@ static void write_swqe2_nonTSO(struct sk_buff *skb,
 	int skb_data_size = skb->len - skb->data_len;
 	u8 *imm_data = &swqe->u.immdata_desc.immediate_data[0];
 	struct ehea_vsgentry *sg1entry = &swqe->u.immdata_desc.sg_entry;
-	u64 tmp_addr;
 
 	/* Packet is any nonTSO type
 	 *
@@ -1362,8 +1360,8 @@ static void write_swqe2_nonTSO(struct sk_buff *skb,
 			/* copy sg1entry data */
 			sg1entry->l_key = lkey;
 			sg1entry->len = skb_data_size - SWQE2_MAX_IMM;
-			tmp_addr = (u64)(skb->data + SWQE2_MAX_IMM);
-			sg1entry->vaddr = ehea_map_vaddr(tmp_addr);
+			sg1entry->vaddr =
+				ehea_map_vaddr(skb->data + SWQE2_MAX_IMM);
 			swqe->descriptors++;
 		}
 	} else {
@@ -1378,7 +1376,6 @@ static inline void write_swqe2_data(struct sk_buff *skb, struct net_device *dev,
 	struct ehea_vsgentry *sg_list, *sg1entry, *sgentry;
 	skb_frag_t *frag;
 	int nfrags, sg1entry_contains_frag_data, i;
-	u64 tmp_addr;
 
 	nfrags = skb_shinfo(skb)->nr_frags;
 	sg1entry = &swqe->u.immdata_desc.sg_entry;
@@ -1400,9 +1397,9 @@ static inline void write_swqe2_data(struct sk_buff *skb, struct net_device *dev,
 			/* copy sg1entry data */
 			sg1entry->l_key = lkey;
 			sg1entry->len = frag->size;
-			tmp_addr =  (u64)(page_address(frag->page)
+			sg1entry->vaddr =
+				ehea_map_vaddr(page_address(frag->page)
 					  + frag->page_offset);
-			sg1entry->vaddr = ehea_map_vaddr(tmp_addr);
 			swqe->descriptors++;
 			sg1entry_contains_frag_data = 1;
 		}
@@ -1415,9 +1412,8 @@ static inline void write_swqe2_data(struct sk_buff *skb, struct net_device *dev,
 			sgentry->l_key = lkey;
 			sgentry->len = frag->size;
 
-			tmp_addr = (u64)(page_address(frag->page)
-					 + frag->page_offset);
-			sgentry->vaddr = ehea_map_vaddr(tmp_addr);
+			sgentry->vaddr = ehea_map_vaddr(page_address(frag->page)
+						+ frag->page_offset);
 			swqe->descriptors++;
 		}
 	}
-- 
1.5.2.3
