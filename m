Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5nl407jMzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 21:32:15 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 May 2016 17:02:12 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 48DEBE0072
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 17:05:15 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4DBW7kZ11338004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 17:02:07 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4DBW0vL012536
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 17:02:06 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: devicetree@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 geert@linux-m68k.org, robherring2@gmail.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
 grant.likely@linaro.org, panto@antoniou-consulting.com,
 frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] drivers/of: Fix build warning in populate_node()
Date: Fri, 13 May 2016 21:31:39 +1000
Message-Id: <1463139099-23363-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <CAMuHMdUnsDhTS5-C6_SvrqGb6hVTBZOz00=HBGhtqAQbwYv6hg@mail.gmail.com>
References: <CAMuHMdUnsDhTS5-C6_SvrqGb6hVTBZOz00=HBGhtqAQbwYv6hg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function populate_node() is used to unflatten FDT blob to device
tree. It supports maximal 64 level of device nodes. There is one
array @fpsizes[64] tracking the full name length of last unflattened
device node in the corresponding level (index of element in the
array - 1). Build warning is seen with CONFIG_FRAME_WARN=1024 like
below on ARM64 as Geert reported. The issue can be reproduced on
PPC64 as well.

  $ make drivers/of/fdt.o
  drivers/of/fdt.c:443:1: warning: the frame size of 1136 bytes is \
  larger than 1024 bytes [-Wframe-larger-than=]

This changes the data type of @fpsizes[i] from "unsigned long" to
"unsigned int" to avoid the build warning. The return value type
of populate_node() and its @fpsize argument is adjusted accordingly.
With this applied, 256 bytes saved from the stack frame on ARM64 and
PPC64 platforms and the above warning isn't seen.

Fixes: 9ffa9eb ("drivers/of: Avoid recursively calling unflatten_dt_node()")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c95054c..34344a8 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -264,13 +264,13 @@ static void populate_properties(const void *blob,
 		*pprev = NULL;
 }
 
-static unsigned long populate_node(const void *blob,
-				   int offset,
-				   void **mem,
-				   struct device_node *dad,
-				   unsigned long fpsize,
-				   struct device_node **pnp,
-				   bool dryrun)
+static unsigned int populate_node(const void *blob,
+				  int offset,
+				  void **mem,
+				  struct device_node *dad,
+				  unsigned int fpsize,
+				  struct device_node **pnp,
+				  bool dryrun)
 {
 	struct device_node *np;
 	const char *pathp;
@@ -397,7 +397,7 @@ static int unflatten_dt_nodes(const void *blob,
 	struct device_node *root;
 	int offset = 0, depth = 0;
 #define FDT_MAX_DEPTH	64
-	unsigned long fpsizes[FDT_MAX_DEPTH];
+	unsigned int fpsizes[FDT_MAX_DEPTH];
 	struct device_node *nps[FDT_MAX_DEPTH];
 	void *base = mem;
 	bool dryrun = !base;
-- 
2.1.0
