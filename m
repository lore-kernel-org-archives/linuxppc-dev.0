Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41w4HD1dMNzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 07:55:35 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so34828907oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:55:35 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powerpc: enable building all dtbs
Date: Tue, 21 Aug 2018 16:55:23 -0500
Message-Id: <20180821215524.23040-8-robh@kernel.org>
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the 'dtbs' target for powerpc. This allows building all the dts
files in arch/powerpc/boot/dts/ when COMPILE_TEST and OF_ALL_DTBS are
enabled.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/boot/dts/Makefile     | 5 +++++
 arch/powerpc/boot/dts/fsl/Makefile | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index f66554cd5c45..fb335d05aae8 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -1 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+
+subdir-y += fsl
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
new file mode 100644
index 000000000000..3bae982641e9
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.17.1
