Return-Path: <horia.geanta@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0089.outbound.protection.outlook.com [207.46.100.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9ZKB0676zDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 01:11:25 +1000 (AEST)
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/8] powerpc: add io{read,write}64 accessors
Date: Thu, 19 May 2016 18:11:10 +0300
Message-ID: <1463670670-2995-1-git-send-email-horia.geanta@nxp.com>
In-Reply-To: <1463670405-1059-1-git-send-email-horia.geanta@nxp.com>
References: <1463670405-1059-1-git-send-email-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will allow device drivers to consistently use io{read,write}XX
also for 64-bit accesses.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/powerpc/kernel/iomap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 12e48d56f771..3963f0b68d52 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -38,6 +38,18 @@ EXPORT_SYMBOL(ioread16);
 EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
+#ifdef __powerpc64__
+u64 ioread64(void __iomem *addr)
+{
+	return readq(addr);
+}
+u64 ioread64be(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+EXPORT_SYMBOL(ioread64);
+EXPORT_SYMBOL(ioread64be);
+#endif /* __powerpc64__ */
 
 void iowrite8(u8 val, void __iomem *addr)
 {
@@ -64,6 +76,18 @@ EXPORT_SYMBOL(iowrite16);
 EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
+#ifdef __powerpc64__
+void iowrite64(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+void iowrite64be(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+EXPORT_SYMBOL(iowrite64);
+EXPORT_SYMBOL(iowrite64be);
+#endif /* __powerpc64__ */
 
 /*
  * These are the "repeat read/write" functions. Note the
-- 
2.4.4
