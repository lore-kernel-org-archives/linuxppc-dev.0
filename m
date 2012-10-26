Return-Path: <shuah.khan@hp.com>
Received: from g5t0008.atlanta.hp.com (g5t0008.atlanta.hp.com [15.192.0.45])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0E8F2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2012 03:18:43 +1100 (EST)
Message-ID: <1351267705.4013.18.camel@lorien2>
Subject: [PATCH RFT RESEND linux-next] powerpc: dma-mapping: support
 debug_dma_mapping_error
From: Shuah Khan <shuah.khan@hp.com>
To: benh@kernel.crashing.org, kyungmin.park@samsung.com, paulus@samba.org,
 m.szyprowski@samsung.com, david@gibson.dropbear.id.au, arnd@arndb.de,
 andrzej.p@samsung.com
Date: Fri, 26 Oct 2012 10:08:25 -0600
In-Reply-To: <1351210584.6851.21.camel@lorien2>
References: <1351210584.6851.21.camel@lorien2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 shuahkhan@gmail.com
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 arch/powerpc/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 7816087..e27e9ad 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -172,6 +172,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
+	debug_dma_mapping_error(dev, dma_addr);
 	if (dma_ops->mapping_error)
 		return dma_ops->mapping_error(dev, dma_addr);
 
-- 
1.7.9.5
