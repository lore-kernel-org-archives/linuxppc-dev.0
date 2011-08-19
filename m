Return-Path: <Ian.Campbell@eu.citrix.com>
From: Ian Campbell <ian.campbell@citrix.com>
To: netdev@vger.kernel.org
Subject: [PATCH 40/75] pasemi: convert to SKB paged frag API.
Date: Fri, 19 Aug 2011 14:27:12 +0100
Message-ID: <1313760467-8598-40-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1313760393.5010.356.camel@zakaz.uk.xensource.com>
References: <1313760393.5010.356.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Ian Campbell <ian.campbell@citrix.com>, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 drivers/net/pasemi_mac.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index 9ec112c..3cd2cd3 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -1505,9 +1505,8 @@ static int pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < nfrags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		map[i+1] = pci_map_page(mac->dma_pdev, frag->page,
-					frag->page_offset, frag->size,
-					PCI_DMA_TODEVICE);
+		map[i + 1] = skb_frag_dma_map(&mac->dma_pdev->dev, frag, 0,
+					      frag->size, PCI_DMA_TODEVICE);
 		map_size[i+1] = frag->size;
 		if (pci_dma_mapping_error(mac->dma_pdev, map[i+1])) {
 			nfrags = i;
-- 
1.7.2.5
