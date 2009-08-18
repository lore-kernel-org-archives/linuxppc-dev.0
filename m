Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3DC34B7ECB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:04:20 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 66436DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:04:19 +1000 (EST)
Date: Wed, 19 Aug 2009 02:04:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
	non-QE/CPM builds
Message-ID: <20090818220418.GD25090@oksana.dev.rtsoft.ru>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is needed to avoid ugly #ifdefs in drivers. Also update fsl_qe_udc
driver so that now it doesn't define its own versions that cause build
breakage when the generic stubs are used.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/cpm.h  |   44 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/qe.h   |   11 ++++++++-
 drivers/usb/gadget/fsl_qe_udc.h |   15 -------------
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index ea3fdb9..0835eb9 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -3,6 +3,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/errno.h>
 #include <linux/of.h>
 
 /*
@@ -131,13 +132,56 @@ typedef struct cpm_buf_desc {
 #define BD_I2C_START		(0x0400)
 
 int cpm_muram_init(void);
+
+#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
 unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
 int cpm_muram_free(unsigned long offset);
 unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
 unsigned long cpm_muram_offset(void __iomem *addr);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
+#else
+static inline unsigned long cpm_muram_alloc(unsigned long size,
+					    unsigned long align)
+{
+	return -ENOSYS;
+}
+
+static inline int cpm_muram_free(unsigned long offset)
+{
+	return -ENOSYS;
+}
+
+static inline unsigned long cpm_muram_alloc_fixed(unsigned long offset,
+						  unsigned long size)
+{
+	return -ENOSYS;
+}
+
+static inline void __iomem *cpm_muram_addr(unsigned long offset)
+{
+	return NULL;
+}
+
+static inline unsigned long cpm_muram_offset(void __iomem *addr)
+{
+	return -ENOSYS;
+}
+
+static inline dma_addr_t cpm_muram_dma(void __iomem *addr)
+{
+	return 0;
+}
+#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */
+
+#ifdef CONFIG_CPM
 int cpm_command(u32 command, u8 opcode);
+#else
+static inline int cpm_command(u32 command, u8 opcode)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_CPM */
 
 int cpm2_gpiochip_add32(struct device_node *np);
 
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 157c5ca..791c67a 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -145,8 +145,17 @@ static inline void qe_pin_set_gpio(struct qe_pin *qe_pin) {}
 static inline void qe_pin_set_dedicated(struct qe_pin *pin) {}
 #endif /* CONFIG_QE_GPIO */
 
-/* QE internal API */
+#ifdef CONFIG_QUICC_ENGINE
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
+#else
+static inline int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol,
+			       u32 cmd_input)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_QUICC_ENGINE */
+
+/* QE internal API */
 enum qe_clock qe_clock_source(const char *source);
 unsigned int qe_get_brg_clk(void);
 int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
diff --git a/drivers/usb/gadget/fsl_qe_udc.h b/drivers/usb/gadget/fsl_qe_udc.h
index 31b2710..bea5b82 100644
--- a/drivers/usb/gadget/fsl_qe_udc.h
+++ b/drivers/usb/gadget/fsl_qe_udc.h
@@ -419,19 +419,4 @@ struct qe_udc {
 #define CPM_USB_RESTART_TX_OPCODE 0x0b
 #define CPM_USB_EP_SHIFT 5
 
-#ifndef CONFIG_CPM
-inline int cpm_command(u32 command, u8 opcode)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
-#ifndef CONFIG_QUICC_ENGINE
-inline int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol,
-	u32 cmd_input)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 #endif  /* __FSL_QE_UDC_H */
-- 
1.6.3.3
