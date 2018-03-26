Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408pLx2Ld2zF1xf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 20:12:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/10] powerpc/64s: Enhance the information in
 cpu_show_meltdown()
Date: Mon, 26 Mar 2018 20:12:11 +1100
Message-Id: <20180326091215.7784-6-mpe@ellerman.id.au>
In-Reply-To: <20180326091215.7784-1-mpe@ellerman.id.au>
References: <20180326091215.7784-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have the security feature flags we can make the
information displayed in the "meltdown" file more informative.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/security_features.h |  1 +
 arch/powerpc/kernel/security.c               | 30 ++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index db00ad2c72c2..400a9050e035 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -10,6 +10,7 @@
 
 
 extern unsigned long powerpc_security_features;
+extern bool rfi_flush;
 
 static inline void security_ftr_set(unsigned long feature)
 {
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 564e7f182a16..865db6f8bcca 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/seq_buf.h>
 
 #include <asm/security_features.h>
 
@@ -19,8 +20,33 @@ unsigned long powerpc_security_features __read_mostly = \
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (rfi_flush)
-		return sprintf(buf, "Mitigation: RFI Flush\n");
+	bool thread_priv;
+
+	thread_priv = security_ftr_enabled(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (rfi_flush || thread_priv) {
+		struct seq_buf s;
+		seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (rfi_flush)
+			seq_buf_printf(&s, "RFI Flush");
+
+		if (rfi_flush && thread_priv)
+			seq_buf_printf(&s, ", ");
+
+		if (thread_priv)
+			seq_buf_printf(&s, "L1D private per thread");
+
+		seq_buf_printf(&s, "\n");
+
+		return s.len;
+	}
+
+	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
+	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
+		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "Vulnerable\n");
 }
-- 
2.14.1
