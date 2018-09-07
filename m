Return-Path: <clabbe@baylibre.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426SWl0TYWzF3TT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 05:42:23 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id j192-v6so15733799wmj.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 12:42:23 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org,
 carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org,
 joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
 Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
Date: Fri,  7 Sep 2018 19:41:44 +0000
Message-Id: <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds setbits32/clrbits32/clrsetbits32 and
setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/setbits.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/linux/setbits.h

diff --git a/include/linux/setbits.h b/include/linux/setbits.h
new file mode 100644
index 000000000000..3e1e273551bb
--- /dev/null
+++ b/include/linux/setbits.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SETBITS_H
+#define __LINUX_SETBITS_H
+
+#include <linux/io.h>
+
+#define __setbits(readfunction, writefunction, addr, set) \
+	writefunction((readfunction(addr) | (set)), addr)
+#define __clrbits(readfunction, writefunction, addr, mask) \
+	writefunction((readfunction(addr) & ~(mask)), addr)
+#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
+	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
+#define __setclrbits(readfunction, writefunction, addr, mask, set) \
+	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
+
+#define setbits32(addr, set) __setbits(readl, writel, addr, set)
+#define setbits32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
+					       addr, set)
+
+#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
+#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
+						addr, mask)
+
+#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
+#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+
+#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
+#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+
+/* We cannot use CONFIG_64BIT as some x86 drivers use writeq */
+#if defined(writeq) && defined(readq)
+#define setbits64(addr, set) __setbits(readq, writeq, addr, set)
+#define setbits64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
+					       addr, set)
+
+#define clrbits64(addr, mask) __clrbits(readq, writeq, addr, mask)
+#define clrbits64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
+						addr, mask)
+
+#define clrsetbits64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
+#define clrsetbits64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+
+#define setclrbits64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
+#define setclrbits64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif /* writeq/readq */
+
+#endif /* __LINUX_SETBITS_H */
-- 
2.16.4
