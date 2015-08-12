Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04A391A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:08:58 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org,
	axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com,
 egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com,
 monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org,
 alex.williamson@redhat.com, grundler@parisc-linux.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
 linux-media@vger.kernel.org
Subject: [PATCH 01/31] scatterlist: add sg_pfn and sg_has_page helpers
Date: Wed, 12 Aug 2015 09:05:20 +0200
Message-Id: <1439363150-8661-2-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/scatterlist.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 9b1ef0c..b1056bf 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -230,6 +230,16 @@ static inline dma_addr_t sg_phys(struct scatterlist *sg)
 	return page_to_phys(sg_page(sg)) + sg->offset;
 }
 
+static inline unsigned long sg_pfn(struct scatterlist *sg)
+{
+	return page_to_pfn(sg_page(sg));
+}
+
+static inline bool sg_has_page(struct scatterlist *sg)
+{
+	return true;
+}
+
 /**
  * sg_virt - Return virtual address of an sg entry
  * @sg:      SG entry
-- 
1.9.1
