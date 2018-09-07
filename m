Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426SWk0nLzzF3CS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 05:42:25 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id k5-v6so15999583wre.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 12:42:25 -0700 (PDT)
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
Subject: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
Date: Fri,  7 Sep 2018 19:41:45 +0000
Message-Id: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
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

This patch add a spatch which convert all open coded of setbits32/clrbits32/clrsetbits32
and their 64 bits counterparts.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 scripts/coccinelle/misc/setbits.cocci | 423 ++++++++++++++++++++++++++++++++++
 1 file changed, 423 insertions(+)
 create mode 100644 scripts/coccinelle/misc/setbits.cocci

diff --git a/scripts/coccinelle/misc/setbits.cocci b/scripts/coccinelle/misc/setbits.cocci
new file mode 100644
index 000000000000..c01ab6d75eb4
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits.cocci
@@ -0,0 +1,423 @@
+virtual context
+
+@pclrsetbits32a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@pclrsetbits32b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@pclrbits32@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr &= ~clear;
+- writel(rr, reg);
++ clrbits32(reg, clear);
+
+@psetbits32@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set;
+- writel(rr, reg);
++ setbits32(reg, set);
+
+@psetbits32b@
+identifier rr;
+expression reg;
+expression set1;
+expression set2;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set1;
+- rr |= set2;
+- writel(rr, reg);
++ setbits32(reg, set1 | set2);
+
+@pclrsetbits64a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@pclrsetbits64b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@pclrbits64@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrbits64(reg, clear);
+
+@psetbits64@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr |= set;
+- writeq(rr, reg);
++ setbits64(reg, set);
+
+@@
+expression dwmac;
+expression reg;
+expression mask;
+expression value;
+@@
+
+- meson8b_dwmac_mask_bits(dwmac, reg, mask, value);
++ clrsetbits32(dwmac->regs + reg, mask, value);
+
+@ppclrsetbits32a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@ppclrsetbits32b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@ppclrbits32@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr &= ~clear;
+- writel(rr, reg);
++ clrbits32(reg, clear);
+
+@ppsetbits32@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+- u32 rr = readl(reg);
+- rr |= set;
+- writel(rr, reg);
++ setbits32(reg, set);
+
+@ppclrsetbits64a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@ppclrsetbits64b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@ppclrbits64@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrbits64(reg, clear);
+
+@ppsetbits64@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+- u64 rr = readq(reg);
+- rr |= set;
+- writeq(rr, reg);
++ setbits64(reg, set);
+
+@pif_set_clr@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+  if (...)
+- rr |= set;
++ setbits32(reg, set);
+  else
+- rr &= ~clear;
++ clrbits32(reg, clear);
+- writel(rr, reg);
+
+@pifclrset@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+  if (...)
+- rr &= ~clear;
++ clrbits32(reg, clear);
+  else
+- rr |= set;
++ setbits32(reg, set);
+- writel(rr, reg);
+
+@pif_set_clr64@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+  if (...)
+- rr |= set;
++ setbits64(reg, set);
+  else
+- rr &= ~clear;
++ clrbits64(reg, clear);
+- writeq(rr, reg);
+
+@pif_clr_set64@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+  if (...)
+- rr &= ~clear;
++ clrbits64(reg, clear);
+  else
+- rr |= set;
++ setbits32(reg, set);
+- writeq(rr, reg);
+
+
+@p_setbits32_m2@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- writel(rr | set, reg);
++ setbits32(reg, set);
+
+@p_clrbits32_m2@
+identifier rr;
+expression reg;
+expression mask;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- writel(rr & ~mask, reg);
++ clrbits32(reg, mask);
+
+
+@p_setbits_oneliner@
+expression addr;
+expression set;
+@@
+- writel(readl(addr) | set, addr);
++ setbits32(addr, set);
+
+@p_clrbits_oneliner@
+expression addr;
+expression mask;
+@@
+- writel(readl(addr) & ~mask, addr);
++ clrbits32(addr, mask);
+
+@p_clrsetbits_oneliner_a@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel(readl(addr) | set & ~mask, addr);
++ clrsetbits32(addr, mask, set);
+
+@p_clrsetbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel(readl(addr) & ~mask | set, addr);
++ clrsetbits32(addr, mask, set);
+
+@p_clrsetbits_oneliner_a2@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel((readl(addr) | set) & ~mask, addr);
++ clrsetbits32(addr, mask, set);
+
+@p_clrsetbits_oneliner_b2@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel((readl(addr) & ~mask) | set, addr);
++ clrsetbits32(addr, mask, set);
+
+
+
+
+
+
+
+
+
+
+
+// sub optimal way to add header
+@header1 depends on psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b@
+@@
+  #include <linux/io.h>
++ #include <linux/setbits.h>
+
+@header2 depends on (psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b) && !header1@
+@@
+  #include <linux/interrupt.h>
++ #include <linux/setbits.h>
+
+@header3 depends on (psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b) && !header2@
+@@
+  #include <linux/of.h>
++ #include <linux/setbits.h>
+
+@@
+expression base;
+expression offset;
+expression value;
+@@
+
+- mtu3_setbits(base, offset, value);
++ setbits32(base + offset, value);
+
+@@
+expression base;
+expression offset;
+expression mask;
+@@
+
+- mtu3_clrbits(base, offset, mask);
++ clrbits32(base + offset, mask);
+
-- 
2.16.4
