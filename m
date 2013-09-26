Return-Path: <robherring2@gmail.com>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99C7D2C0333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 04:51:40 +1000 (EST)
Received: by mail-ie0-f171.google.com with SMTP id at1so1976730iec.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:51:37 -0700 (PDT)
From: Rob Herring <robherring2@gmail.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 17/21] of: move of_translate_dma_address to of_address.h
Date: Thu, 26 Sep 2013 13:50:52 -0500
Message-Id: <1380221456-11192-18-git-send-email-robherring2@gmail.com>
In-Reply-To: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
References: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring <rob.herring@calxeda.com>

of_translate_dma_address is implemented in common code, so move the
declaration there too.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/prom.h | 4 ----
 include/linux/of_address.h      | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 43fe002..b8774bd 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -24,10 +24,6 @@
  * OF address retreival & translation
  */
 
-/* Translate a DMA address from device space to CPU space */
-extern u64 of_translate_dma_address(struct device_node *dev,
-				    const __be32 *in_addr);
-
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
  */
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index e8a1797..5f6ed6b 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -34,6 +34,10 @@ static inline void of_pci_range_to_resource(struct of_pci_range *range,
 	res->name = np->full_name;
 }
 
+/* Translate a DMA address from device space to CPU space */
+extern u64 of_translate_dma_address(struct device_node *dev,
+				    const __be32 *in_addr);
+
 #ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
 extern bool of_can_translate_address(struct device_node *dev);
-- 
1.8.1.2
