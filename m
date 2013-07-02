Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B03862C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 12:23:48 +1000 (EST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] powerpc/msi: Fix compile error on mpc83xx
Date: Tue, 2 Jul 2013 09:34:52 +0800
Message-ID: <1372728892-31501-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_get_primary_version() is not defined when not using MPIC.
The compile error log like:

arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
fsl_msi.c:(.text+0x150c): undefined reference to `fsl_mpic_primary_get_version'

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/include/asm/mpic.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index ea6bf72..97b5a63 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -394,7 +394,14 @@ struct mpic
 #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
 
 /* Get the version of primary MPIC */
+#ifdef CONFIG_MPIC
 extern u32 fsl_mpic_primary_get_version(void);
+#else
+static inline u32 fsl_mpic_primary_get_version(void)
+{
+	return 0;
+}
+#endif
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
-- 
1.8.0
