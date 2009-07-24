Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CABAFB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 13:27:16 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] add set_dma_mask hook to struct dma_map_ops
Date: Fri, 24 Jul 2009 12:24:13 +0900
Message-Id: <1248405855-15546-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWERPC needs this hook. SPARC could use it too.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 include/linux/dma-mapping.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c0f6c3c..91b7618 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -58,6 +58,7 @@ struct dma_map_ops {
 				   enum dma_data_direction dir);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
+	int (*set_dma_mask)(struct device *dev, u64 mask);
 	int is_phys;
 };
 
-- 
1.6.0.6
