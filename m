Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jtt92SbnzF3Hk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:04:33 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id n11-v6so9581421wro.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:04:33 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/7] coccinelle: add xxxsetbitsXX converting spatch
Date: Mon, 24 Sep 2018 19:04:12 +0000
Message-Id: <1537815856-31728-4-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
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

Note that 64 and 32_relaxed are generated via
cp scripts/coccinelle/misc/setbits32.cocci scripts/coccinelle/misc/setbits32_relaxed.cocci
sed -i 's,readl,readl_relaxed,' scripts/coccinelle/misc/setbits32_relaxed.cocci
sed -i 's,writel,writel_relaxed,' scripts/coccinelle/misc/setbits32_relaxed.cocci
sed -i 's,setbits_le32,setbits_le32_relaxed,g' scripts/coccinelle/misc/setbits32_relaxed.cocci
sed -i 's,clrbits_le32,clrbits_le32_relaxed,g' scripts/coccinelle/misc/setbits32_relaxed.cocci
cp scripts/coccinelle/misc/setbits32.cocci scripts/coccinelle/misc/setbits64.cocci
sed -i 's,readl,readq,' scripts/coccinelle/misc/setbits64.cocci
sed -i 's,writel,writeq,' scripts/coccinelle/misc/setbits64.cocci
sed -i 's,le32,le64,' scripts/coccinelle/misc/setbits64.cocci

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 scripts/add_new_include_in_source.py            |  61 +++
 scripts/coccinelle/misc/setbits32.cocci         | 487 ++++++++++++++++++++++++
 scripts/coccinelle/misc/setbits32_relaxed.cocci | 487 ++++++++++++++++++++++++
 scripts/coccinelle/misc/setbits64.cocci         | 487 ++++++++++++++++++++++++
 scripts/coccinelle/misc/setbits_dev.cocci       | 235 ++++++++++++
 5 files changed, 1757 insertions(+)
 create mode 100755 scripts/add_new_include_in_source.py
 create mode 100644 scripts/coccinelle/misc/setbits32.cocci
 create mode 100644 scripts/coccinelle/misc/setbits32_relaxed.cocci
 create mode 100644 scripts/coccinelle/misc/setbits64.cocci
 create mode 100644 scripts/coccinelle/misc/setbits_dev.cocci

diff --git a/scripts/add_new_include_in_source.py b/scripts/add_new_include_in_source.py
new file mode 100755
index 000000000000..a43ccfbf9921
--- /dev/null
+++ b/scripts/add_new_include_in_source.py
@@ -0,0 +1,61 @@
+#!/usr/bin/env python
+
+# add <linux/setbits.h>
+
+import os, sys
+import re
+import shutil
+
+if len(sys.argv) < 2:
+    print("Usage: %s pathtosourcefile" % (sys.argv[0]))
+    sys.exit(1)
+
+found_global_headers = False
+found_local_headers = False
+#first check it does already here
+with open(sys.argv[1], 'r') as fp:
+    for line in fp:
+        if re.search("#include <linux/setbits.h>\n", line):
+            print("INFO: header already here")
+            sys.exit(0)
+        if re.search("^#include <", line):
+            found_global_headers = True
+        if re.search("^#include \"", line):
+            found_local_headers = True
+    fp.close()
+
+if not found_global_headers and not found_local_headers:
+    print("No header included do it at hand")
+    sys.exit(1)
+
+if found_global_headers:
+    done = False
+    inheader = False
+    with open("%s.new" % sys.argv[1], 'w') as fw:
+        with open(sys.argv[1], 'r') as fp:
+            for line in fp:
+                if re.search("^#include <linux/", line):
+                    inheader = True
+                    if (not done and line[16] >= "s" and line[17] >= "e" and line[18] >= "t" and line[19] >= 'b'):
+                        done = True
+                        fw.write("#include <linux/setbits.h>\n")
+                if not done and not re.search("^#include <linux/", line) and inheader:
+                    done = True
+                    fw.write("#include <linux/setbits.h>\n")
+                fw.write(line)
+    fw.close()
+    fp.close()
+else:
+    done = False
+    with open("%s.new" % sys.argv[1], 'w') as fw:
+        with open(sys.argv[1], 'r') as fp:
+            for line in fp:
+                if not done and re.search("^#include \"", line):
+                    fw.write("#include <linux/setbits.h>\n")
+                    done = True
+                fw.write(line)
+    fw.close()
+    fp.close()
+
+shutil.move("%s.new" % sys.argv[1], sys.argv[1])
+print("%s done" % sys.argv[1])
diff --git a/scripts/coccinelle/misc/setbits32.cocci b/scripts/coccinelle/misc/setbits32.cocci
new file mode 100644
index 000000000000..71400cac6830
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits32.cocci
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+// Confidence: High
+// Copyright: (c) 2018 Corentin LABBE
+
+virtual patch
+
+@p_clrsetbits_le32_l4@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, addr);
++ clrsetbits_le32(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrsetbits_le32_l4@
+p1 << p_clrsetbits_le32_l4.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrsetbits_le32_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr &= ~clear | set;
+- writel(rr, addr);
++ clrsetbits_le32(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrsetbits_le32_l3@
+p1 << p_clrsetbits_le32_l3.p;
+@@
+list.append(p1[0].file)
+
+
+
+@p_clrsetbits_oneliner@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel@p(readl(addr) & ~mask | set, addr);
++ clrsetbits_le32(addr, mask, set);
+
+@script:python depends on p_clrsetbits_oneliner@
+p1 << p_clrsetbits_oneliner.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrsetbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel@p((readl(addr) & ~mask) | set, addr);
++ clrsetbits_le32(addr, mask, set);
+
+@script:python depends on p_clrsetbits_oneliner_b@
+p1 << p_clrsetbits_oneliner_b.p;
+@@
+list.append(p1[0].file)
+
+
+
+// setclrbits ==========================
+
+
+
+@p_setclrbits_le32_l4@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, addr);
++ setclrbits_le32(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setclrbits_le32_l4@
+p1 << p_setclrbits_le32_l4.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setclrbits_le32_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr |= set & ~clear;
+- writel(rr, addr);
++ setclrbits_le32(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setclrbits_le32_l3@
+p1 << p_setclrbits_le32_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setclrbits_oneliner@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel@p(readl(addr) | set & ~mask, addr);
++ setclrbits_le32(addr, mask, set);
+
+@script:python depends on p_setclrbits_oneliner@
+p1 << p_setclrbits_oneliner.p;
+@@
+list.append(p1[0].file)
+
+@p_setclrbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel@p((readl(addr) | set) & ~mask, addr);
++ setclrbits_le32(addr, mask, set);
+
+@script:python depends on p_setclrbits_oneliner_b@
+p1 << p_setclrbits_oneliner_b.p;
+@@
+list.append(p1[0].file)
+
+
+// clr bits ===============================================
+
+@p_clrbits_le32_l3@
+local idexpression rr;
+expression addr;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr &= ~clear;
+- writel(rr, addr);
++ clrbits_le32(addr, clear);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le32_l3@
+p1 << p_clrbits_le32_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le32_l2_a@
+local idexpression rr;
+expression addr;
+expression mask;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- writel(rr & ~mask, addr);
++ clrbits_le32(addr, mask);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le32_l2_a@
+p1 << p_clrbits_le32_l2_a.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le32_l2_b@
+local idexpression rr;
+expression addr;
+expression mask;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr) & ~mask;
+- writel(rr, addr);
++ clrbits_le32(addr, mask);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le32_l2_b@
+p1 << p_clrbits_le32_l2_b.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le32_oneliner@
+expression addr;
+expression mask;
+position p;
+@@
+- writel@p(readl(addr) & ~mask, addr);
++ clrbits_le32(addr, mask);
+
+@script:python depends on p_clrbits_le32_oneliner@
+p1 << p_clrbits_le32_oneliner.p;
+@@
+list.append(p1[0].file)
+
+
+
+
+
+
+
+// set bits ======================================
+
+@p_setbits_le32_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr |= set;
+- writel(rr, addr);
++ setbits_le32(addr, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setbits_le32_l3@
+p1 << p_setbits_le32_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setbits_le32_l4@
+local idexpression rr;
+expression addr;
+expression set1;
+expression set2;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr |= set1;
+- rr |= set2;
+- writel(rr, addr);
++ setbits_le32(addr, set1 | set2);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setbits_le32_l4@
+p1 << p_setbits_le32_l4.p;
+@@
+list.append(p1[0].file)
+
+
+
+
+
+@ppsetbits_le32@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readl(addr);
+- rr |= set;
+- writel(rr, addr);
++ setbits_le32(addr, set);
+  ... when != rr
+? rr = e
+
+
+@p_setbits_le32_m2@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readl(addr);
+- writel(rr | set, addr);
++ setbits_le32(addr, set);
+  ... when != rr
+? rr = e
+
+@p_setbits_le32_l2@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readl(addr) | set;
+- writel(rr, addr);
++ setbits_le32(addr, set);
+  ... when != rr
+? rr = e
+
+
+@p_setbits_oneliner@
+expression addr;
+expression set;
+@@
+- writel(readl(addr) | set, addr);
++ setbits_le32(addr, set);
+
+
+
+
+
+// misc pattern ======================================
+
+
+@p_if_set_clr@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+  if (...)
+- rr |= set;
++ setbits_le32(addr, set);
+  else
+- rr &= ~clear;
++ clrbits_le32(addr, clear);
+- writel(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_set_clr@
+p1 << p_if_set_clr.p;
+@@
+//import subprocess
+list.append(p1[0].file)
+//file = p1[0].file
+//print("Add setbits header in %s" % file)
+//subprocess.call(["./add_header.py", file])
+
+
+@p_if_clr_set@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+  if (...)
+- rr &= ~clear;
++ clrbits_le32(addr, clear);
+  else
+- rr |= set;
++ setbits_le32(addr, set);
+- writel(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set@
+p1 << p_if_clr_set.p;
+@@
+list.append(p1[0].file)
+
+
+
+@p_if_clr_set_b@
+local idexpression rr;
+expression addr;
+expression set1;
+expression set2;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr &= ~clear;
+  if (...)
+- rr |= set1;
++ clrsetbits_le32(addr, clear, set1);
+  else
+- rr |= set2;
++ clrsetbits_le32(addr, clear, set2);
+- writel(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set_b@
+p1 << p_if_clr_set_b.p;
+@@
+list.append(p1[0].file)
+
+
+@p_if_clr_set_c@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl(addr);
+- rr &= ~clear;
+  if (...)
+- rr |= set;
++ clrsetbits_le32(addr, clear, set);
++ else
++ setbits_le32(addr, set);
+- writel(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set_c@
+p1 << p_if_clr_set_c.p;
+@@
+list.append(p1[0].file)
+
+
+
+// to check decon_set_bits
+//@p_setmask_a@
+//local idexpression rr;
+//expression addr;
+//expression set;
+//expression mask;
+//@@
+//- rr = (set & mask) | (readl(addr) & ~mask);
+//- writel(rr, addr);
+//+ setmask_le32(addr, set, mask);
+
+
+
+
+
+@initialize:python@
+@@
+list = []
+
+//@finalize:python depends on addr@
+@finalize:python@
+@@
+import subprocess
+for file in list:
+	print("Add setbits header in %s" % file)
+	subprocess.call(["./scripts/add_new_include_in_source.py", file])
+
diff --git a/scripts/coccinelle/misc/setbits32_relaxed.cocci b/scripts/coccinelle/misc/setbits32_relaxed.cocci
new file mode 100644
index 000000000000..edf8c39e939e
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits32_relaxed.cocci
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+// Confidence: High
+// Copyright: (c) 2018 Corentin LABBE
+
+virtual patch
+
+@p_clrsetbits_le32_relaxed_l4@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr &= ~clear;
+- rr |= set;
+- writel_relaxed(rr, addr);
++ clrsetbits_le32_relaxed(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrsetbits_le32_relaxed_l4@
+p1 << p_clrsetbits_le32_relaxed_l4.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrsetbits_le32_relaxed_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr &= ~clear | set;
+- writel_relaxed(rr, addr);
++ clrsetbits_le32_relaxed(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrsetbits_le32_relaxed_l3@
+p1 << p_clrsetbits_le32_relaxed_l3.p;
+@@
+list.append(p1[0].file)
+
+
+
+@p_clrsetbits_oneliner@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel_relaxed@p(readl_relaxed(addr) & ~mask | set, addr);
++ clrsetbits_le32_relaxed(addr, mask, set);
+
+@script:python depends on p_clrsetbits_oneliner@
+p1 << p_clrsetbits_oneliner.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrsetbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel_relaxed@p((readl_relaxed(addr) & ~mask) | set, addr);
++ clrsetbits_le32_relaxed(addr, mask, set);
+
+@script:python depends on p_clrsetbits_oneliner_b@
+p1 << p_clrsetbits_oneliner_b.p;
+@@
+list.append(p1[0].file)
+
+
+
+// setclrbits ==========================
+
+
+
+@p_setclrbits_le32_relaxed_l4@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr |= set;
+- rr &= ~clear;
+- writel_relaxed(rr, addr);
++ setclrbits_le32_relaxed(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setclrbits_le32_relaxed_l4@
+p1 << p_setclrbits_le32_relaxed_l4.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setclrbits_le32_relaxed_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr |= set & ~clear;
+- writel_relaxed(rr, addr);
++ setclrbits_le32_relaxed(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setclrbits_le32_relaxed_l3@
+p1 << p_setclrbits_le32_relaxed_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setclrbits_oneliner@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel_relaxed@p(readl_relaxed(addr) | set & ~mask, addr);
++ setclrbits_le32_relaxed(addr, mask, set);
+
+@script:python depends on p_setclrbits_oneliner@
+p1 << p_setclrbits_oneliner.p;
+@@
+list.append(p1[0].file)
+
+@p_setclrbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writel_relaxed@p((readl_relaxed(addr) | set) & ~mask, addr);
++ setclrbits_le32_relaxed(addr, mask, set);
+
+@script:python depends on p_setclrbits_oneliner_b@
+p1 << p_setclrbits_oneliner_b.p;
+@@
+list.append(p1[0].file)
+
+
+// clr bits ===============================================
+
+@p_clrbits_le32_relaxed_l3@
+local idexpression rr;
+expression addr;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr &= ~clear;
+- writel_relaxed(rr, addr);
++ clrbits_le32_relaxed(addr, clear);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le32_relaxed_l3@
+p1 << p_clrbits_le32_relaxed_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le32_relaxed_l2_a@
+local idexpression rr;
+expression addr;
+expression mask;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- writel_relaxed(rr & ~mask, addr);
++ clrbits_le32_relaxed(addr, mask);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le32_relaxed_l2_a@
+p1 << p_clrbits_le32_relaxed_l2_a.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le32_relaxed_l2_b@
+local idexpression rr;
+expression addr;
+expression mask;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr) & ~mask;
+- writel_relaxed(rr, addr);
++ clrbits_le32_relaxed(addr, mask);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le32_relaxed_l2_b@
+p1 << p_clrbits_le32_relaxed_l2_b.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le32_relaxed_oneliner@
+expression addr;
+expression mask;
+position p;
+@@
+- writel_relaxed@p(readl_relaxed(addr) & ~mask, addr);
++ clrbits_le32_relaxed(addr, mask);
+
+@script:python depends on p_clrbits_le32_relaxed_oneliner@
+p1 << p_clrbits_le32_relaxed_oneliner.p;
+@@
+list.append(p1[0].file)
+
+
+
+
+
+
+
+// set bits ======================================
+
+@p_setbits_le32_relaxed_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr |= set;
+- writel_relaxed(rr, addr);
++ setbits_le32_relaxed(addr, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setbits_le32_relaxed_l3@
+p1 << p_setbits_le32_relaxed_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setbits_le32_relaxed_l4@
+local idexpression rr;
+expression addr;
+expression set1;
+expression set2;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr |= set1;
+- rr |= set2;
+- writel_relaxed(rr, addr);
++ setbits_le32_relaxed(addr, set1 | set2);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setbits_le32_relaxed_l4@
+p1 << p_setbits_le32_relaxed_l4.p;
+@@
+list.append(p1[0].file)
+
+
+
+
+
+@ppsetbits_le32_relaxed@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readl_relaxed(addr);
+- rr |= set;
+- writel_relaxed(rr, addr);
++ setbits_le32_relaxed(addr, set);
+  ... when != rr
+? rr = e
+
+
+@p_setbits_le32_relaxed_m2@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readl_relaxed(addr);
+- writel_relaxed(rr | set, addr);
++ setbits_le32_relaxed(addr, set);
+  ... when != rr
+? rr = e
+
+@p_setbits_le32_relaxed_l2@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readl_relaxed(addr) | set;
+- writel_relaxed(rr, addr);
++ setbits_le32_relaxed(addr, set);
+  ... when != rr
+? rr = e
+
+
+@p_setbits_oneliner@
+expression addr;
+expression set;
+@@
+- writel_relaxed(readl_relaxed(addr) | set, addr);
++ setbits_le32_relaxed(addr, set);
+
+
+
+
+
+// misc pattern ======================================
+
+
+@p_if_set_clr@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+  if (...)
+- rr |= set;
++ setbits_le32_relaxed(addr, set);
+  else
+- rr &= ~clear;
++ clrbits_le32_relaxed(addr, clear);
+- writel_relaxed(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_set_clr@
+p1 << p_if_set_clr.p;
+@@
+//import subprocess
+list.append(p1[0].file)
+//file = p1[0].file
+//print("Add setbits header in %s" % file)
+//subprocess.call(["./add_header.py", file])
+
+
+@p_if_clr_set@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+  if (...)
+- rr &= ~clear;
++ clrbits_le32_relaxed(addr, clear);
+  else
+- rr |= set;
++ setbits_le32_relaxed(addr, set);
+- writel_relaxed(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set@
+p1 << p_if_clr_set.p;
+@@
+list.append(p1[0].file)
+
+
+
+@p_if_clr_set_b@
+local idexpression rr;
+expression addr;
+expression set1;
+expression set2;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr &= ~clear;
+  if (...)
+- rr |= set1;
++ clrsetbits_le32_relaxed(addr, clear, set1);
+  else
+- rr |= set2;
++ clrsetbits_le32_relaxed(addr, clear, set2);
+- writel_relaxed(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set_b@
+p1 << p_if_clr_set_b.p;
+@@
+list.append(p1[0].file)
+
+
+@p_if_clr_set_c@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readl_relaxed(addr);
+- rr &= ~clear;
+  if (...)
+- rr |= set;
++ clrsetbits_le32_relaxed(addr, clear, set);
++ else
++ setbits_le32_relaxed(addr, set);
+- writel_relaxed(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set_c@
+p1 << p_if_clr_set_c.p;
+@@
+list.append(p1[0].file)
+
+
+
+// to check decon_set_bits
+//@p_setmask_a@
+//local idexpression rr;
+//expression addr;
+//expression set;
+//expression mask;
+//@@
+//- rr = (set & mask) | (readl_relaxed(addr) & ~mask);
+//- writel_relaxed(rr, addr);
+//+ setmask_le32(addr, set, mask);
+
+
+
+
+
+@initialize:python@
+@@
+list = []
+
+//@finalize:python depends on addr@
+@finalize:python@
+@@
+import subprocess
+for file in list:
+	print("Add setbits header in %s" % file)
+	subprocess.call(["./scripts/add_new_include_in_source.py", file])
+
diff --git a/scripts/coccinelle/misc/setbits64.cocci b/scripts/coccinelle/misc/setbits64.cocci
new file mode 100644
index 000000000000..00df21005b18
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits64.cocci
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+// Confidence: High
+// Copyright: (c) 2018 Corentin LABBE
+
+virtual patch
+
+@p_clrsetbits_le64_l4@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, addr);
++ clrsetbits_le64(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrsetbits_le64_l4@
+p1 << p_clrsetbits_le64_l4.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrsetbits_le64_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr &= ~clear | set;
+- writeq(rr, addr);
++ clrsetbits_le64(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrsetbits_le64_l3@
+p1 << p_clrsetbits_le64_l3.p;
+@@
+list.append(p1[0].file)
+
+
+
+@p_clrsetbits_oneliner@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writeq@p(readq(addr) & ~mask | set, addr);
++ clrsetbits_le64(addr, mask, set);
+
+@script:python depends on p_clrsetbits_oneliner@
+p1 << p_clrsetbits_oneliner.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrsetbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writeq@p((readq(addr) & ~mask) | set, addr);
++ clrsetbits_le64(addr, mask, set);
+
+@script:python depends on p_clrsetbits_oneliner_b@
+p1 << p_clrsetbits_oneliner_b.p;
+@@
+list.append(p1[0].file)
+
+
+
+// setclrbits ==========================
+
+
+
+@p_setclrbits_le64_l4@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, addr);
++ setclrbits_le64(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setclrbits_le64_l4@
+p1 << p_setclrbits_le64_l4.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setclrbits_le64_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr |= set & ~clear;
+- writeq(rr, addr);
++ setclrbits_le64(addr, clear, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setclrbits_le64_l3@
+p1 << p_setclrbits_le64_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setclrbits_oneliner@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writeq@p(readq(addr) | set & ~mask, addr);
++ setclrbits_le64(addr, mask, set);
+
+@script:python depends on p_setclrbits_oneliner@
+p1 << p_setclrbits_oneliner.p;
+@@
+list.append(p1[0].file)
+
+@p_setclrbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+position p;
+@@
+- writeq@p((readq(addr) | set) & ~mask, addr);
++ setclrbits_le64(addr, mask, set);
+
+@script:python depends on p_setclrbits_oneliner_b@
+p1 << p_setclrbits_oneliner_b.p;
+@@
+list.append(p1[0].file)
+
+
+// clr bits ===============================================
+
+@p_clrbits_le64_l3@
+local idexpression rr;
+expression addr;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr &= ~clear;
+- writeq(rr, addr);
++ clrbits_le64(addr, clear);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le64_l3@
+p1 << p_clrbits_le64_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le64_l2_a@
+local idexpression rr;
+expression addr;
+expression mask;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- writeq(rr & ~mask, addr);
++ clrbits_le64(addr, mask);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le64_l2_a@
+p1 << p_clrbits_le64_l2_a.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le64_l2_b@
+local idexpression rr;
+expression addr;
+expression mask;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr) & ~mask;
+- writeq(rr, addr);
++ clrbits_le64(addr, mask);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_clrbits_le64_l2_b@
+p1 << p_clrbits_le64_l2_b.p;
+@@
+list.append(p1[0].file)
+
+
+@p_clrbits_le64_oneliner@
+expression addr;
+expression mask;
+position p;
+@@
+- writeq@p(readq(addr) & ~mask, addr);
++ clrbits_le64(addr, mask);
+
+@script:python depends on p_clrbits_le64_oneliner@
+p1 << p_clrbits_le64_oneliner.p;
+@@
+list.append(p1[0].file)
+
+
+
+
+
+
+
+// set bits ======================================
+
+@p_setbits_le64_l3@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr |= set;
+- writeq(rr, addr);
++ setbits_le64(addr, set);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setbits_le64_l3@
+p1 << p_setbits_le64_l3.p;
+@@
+list.append(p1[0].file)
+
+
+@p_setbits_le64_l4@
+local idexpression rr;
+expression addr;
+expression set1;
+expression set2;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr |= set1;
+- rr |= set2;
+- writeq(rr, addr);
++ setbits_le64(addr, set1 | set2);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_setbits_le64_l4@
+p1 << p_setbits_le64_l4.p;
+@@
+list.append(p1[0].file)
+
+
+
+
+
+@ppsetbits_le64@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readq(addr);
+- rr |= set;
+- writeq(rr, addr);
++ setbits_le64(addr, set);
+  ... when != rr
+? rr = e
+
+
+@p_setbits_le64_m2@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readq(addr);
+- writeq(rr | set, addr);
++ setbits_le64(addr, set);
+  ... when != rr
+? rr = e
+
+@p_setbits_le64_l2@
+local idexpression rr;
+expression addr;
+expression set;
+expression e;
+@@
+
+- rr = readq(addr) | set;
+- writeq(rr, addr);
++ setbits_le64(addr, set);
+  ... when != rr
+? rr = e
+
+
+@p_setbits_oneliner@
+expression addr;
+expression set;
+@@
+- writeq(readq(addr) | set, addr);
++ setbits_le64(addr, set);
+
+
+
+
+
+// misc pattern ======================================
+
+
+@p_if_set_clr@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+  if (...)
+- rr |= set;
++ setbits_le64(addr, set);
+  else
+- rr &= ~clear;
++ clrbits_le64(addr, clear);
+- writeq(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_set_clr@
+p1 << p_if_set_clr.p;
+@@
+//import subprocess
+list.append(p1[0].file)
+//file = p1[0].file
+//print("Add setbits header in %s" % file)
+//subprocess.call(["./add_header.py", file])
+
+
+@p_if_clr_set@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+  if (...)
+- rr &= ~clear;
++ clrbits_le64(addr, clear);
+  else
+- rr |= set;
++ setbits_le64(addr, set);
+- writeq(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set@
+p1 << p_if_clr_set.p;
+@@
+list.append(p1[0].file)
+
+
+
+@p_if_clr_set_b@
+local idexpression rr;
+expression addr;
+expression set1;
+expression set2;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr &= ~clear;
+  if (...)
+- rr |= set1;
++ clrsetbits_le64(addr, clear, set1);
+  else
+- rr |= set2;
++ clrsetbits_le64(addr, clear, set2);
+- writeq(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set_b@
+p1 << p_if_clr_set_b.p;
+@@
+list.append(p1[0].file)
+
+
+@p_if_clr_set_c@
+local idexpression rr;
+expression addr;
+expression set;
+expression clear;
+expression e;
+position p;
+@@
+
+- rr@p = readq(addr);
+- rr &= ~clear;
+  if (...)
+- rr |= set;
++ clrsetbits_le64(addr, clear, set);
++ else
++ setbits_le64(addr, set);
+- writeq(rr, addr);
+  ... when != rr
+? rr = e
+
+@script:python depends on p_if_clr_set_c@
+p1 << p_if_clr_set_c.p;
+@@
+list.append(p1[0].file)
+
+
+
+// to check decon_set_bits
+//@p_setmask_a@
+//local idexpression rr;
+//expression addr;
+//expression set;
+//expression mask;
+//@@
+//- rr = (set & mask) | (readq(addr) & ~mask);
+//- writeq(rr, addr);
+//+ setmask_le64(addr, set, mask);
+
+
+
+
+
+@initialize:python@
+@@
+list = []
+
+//@finalize:python depends on addr@
+@finalize:python@
+@@
+import subprocess
+for file in list:
+	print("Add setbits header in %s" % file)
+	subprocess.call(["./scripts/add_new_include_in_source.py", file])
+
diff --git a/scripts/coccinelle/misc/setbits_dev.cocci b/scripts/coccinelle/misc/setbits_dev.cocci
new file mode 100644
index 000000000000..859bd0526fcc
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits_dev.cocci
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+// Confidence: High
+// Copyright: (c) 2018 Corentin LABBE
+
+virtual patch
+
+// ========================================================================
+// driver specific changes
+// to be removed after conversion
+
+
+// mtk_hdmi_phy_mask
+@p_setmask_b@
+local idexpression rr;
+expression addr;
+expression set;
+expression mask;
+@@
+- rr = readl(addr);
+- rr = (rr & ~mask) | (set & mask);
+- writel(rr, addr);
++ setmask_le32(addr, set, mask);
+
+@p_setmask_c@
+local idexpression rr;
+expression addr;
+expression set;
+expression mask;
+@@
+- rr = readl(addr);
+- rr = (set & mask) | (rr & ~mask);
+- writel(rr, addr);
++ setmask_le32(addr, set, mask);
+
+
+@p_net_meson_clean@
+@@
+- meson8b_dwmac_mask_bits(...) {
+- ...
+- }
+
+@p_net_meson@
+expression dwmac;
+expression addr;
+expression mask;
+expression value;
+@@
+
+- meson8b_dwmac_mask_bits(dwmac, addr, mask, value);
++ clrsetbits_le32(dwmac->regs + addr, mask, value);
+
+// meson DRM
+@p_meson_drm_writel@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel_bits_relaxed(mask, set, addr);
++ clrsetbits_le32_relaxed(addr, mask, set);
+
+@p_mtu3_setbits@
+expression base;
+expression offset;
+expression value;
+@@
+
+- mtu3_setbits(base, offset, value);
++ setbits_le32(base + offset, value);
+
+@p_mtu3_clrbits@
+expression base;
+expression offset;
+expression mask;
+@@
+
+- mtu3_clrbits(base, offset, mask);
++ clrbits_le32(base + offset, mask);
+
+//
+@p_fimc_clean_set@
+@@
+- static void fimc_set_bits(...) {
+- ...
+- }
+
+@p_fimc_clean_clrt@
+@@
+- static void fimc_clear_bits(...) {
+- ...
+- }
+
+@p_fimc_setbits@
+expression fimc;
+expression offset;
+expression value;
+@@
+
+- fimc_set_bits(fimc, offset, value);
++ setbits_le32(fimc->regs + offset, value);
+
+@p_fimc_clrbits@
+expression fimc;
+expression offset;
+expression mask;
+@@
+
+- fimc_clear_bits(fimc, offset, mask);
++ clrbits_le32(fimc->regs + offset, mask);
+
+//
+@p_sif_clean_clr@
+@@
+- static void sif_clr_bit(...) {
+- ...
+- }
+
+@p_sif_clean_set@
+@@
+- static void sif_set_bit(...) {
+- ...
+- }
+
+@p_sif_setbits@
+expression sif;
+expression offset;
+expression value;
+@@
+
+- sif_set_bit(sif, offset, value);
++ setbits_le32(sif->regs + offset, value);
+
+@p_sif_clrbits@
+expression sif;
+expression offset;
+expression mask;
+@@
+
+- sif_clr_bit(sif, offset, mask);
++ clrbits_le32(sif->regs + offset, mask);
+
+// mediatek
+@p_mtk_clean_clr@
+@@
+- static void mtk_cec_clear_bits(...) {
+- ...
+- }
+
+@p_mtk_clean_set@
+@@
+- static void mtk_cec_set_bits(...) {
+- ...
+- }
+
+@p_mtk_setbits@
+expression mtk;
+expression offset;
+expression value;
+@@
+
+- mtk_cec_set_bits(mtk, offset, value);
++ setbits_le32(mtk->regs + offset, value);
+
+@p_mtk_clrbits@
+expression mtk;
+expression offset;
+expression mask;
+@@
+
+- mtk_cec_clear_bits(mtk, offset, mask);
++ clrbits_le32(mtk->regs + offset, mask);
+
+// mediatek HDMI
+@p_mtk_hdmi_clean_set@
+@@
+- static void mtk_hdmi_set_bits(...) {
+- ...
+- }
+
+@p_mtk_hdmi_clean_clr@
+@@
+- static void mtk_hdmi_clear_bits(...) {
+- ...
+- }
+
+@p_mtk_hdmi_setbits@
+expression mtk;
+expression offset;
+expression value;
+@@
+
+- mtk_hdmi_set_bits(mtk, offset, value);
++ setbits_le32(mtk->regs + offset, value);
+
+@p_mtk_hdmi_clrbits@
+expression mtk;
+expression offset;
+expression mask;
+@@
+
+- mtk_hdmi_clear_bits(mtk, offset, mask);
++ clrbits_le32(mtk->regs + offset, mask);
+
+// mediatek HDMI
+@p_mtk_hdmi_phy_clean_set@
+@@
+- static void mtk_hdmi_phy_set_bits(...) {
+- ...
+- }
+
+@p_mtk_hdmi_phy_clean_clr@
+@@
+- static void mtk_hdmi_phy_clear_bits(...) {
+- ...
+- }
+
+@p_mtk_hdmi_phy_setbits@
+expression mtk;
+expression offset;
+expression value;
+@@
+
+- mtk_hdmi_phy_set_bits(mtk, offset, value);
++ setbits_le32(mtk->regs + offset, value);
+
+@p_mtk_hdmi_phy_clrbits@
+expression mtk;
+expression offset;
+expression mask;
+@@
+
+- mtk_hdmi_phy_clear_bits(mtk, offset, mask);
++ clrbits_le32(mtk->regs + offset, mask);
+
+
+
-- 
2.16.4
