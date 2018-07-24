Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg7y64BvzDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 00:03:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add a checkpatch wrapper with our preferred settings
Date: Wed, 25 Jul 2018 00:03:46 +1000
Message-Id: <20180724140346.10575-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes it easy to run checkpatch with settings that we have agreed
on (bwhahahahah).

Usage is eg:

  $ ./arch/powerpc/tools/checkpatch.sh -g origin/master..

To check all commits since origin/master.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/tools/checkpatch.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 arch/powerpc/tools/checkpatch.sh

diff --git a/arch/powerpc/tools/checkpatch.sh b/arch/powerpc/tools/checkpatch.sh
new file mode 100755
index 000000000000..4c2ac4655e26
--- /dev/null
+++ b/arch/powerpc/tools/checkpatch.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2018, Michael Ellerman, IBM Corporation.
+#
+# Wrapper around checkpatch that uses our preferred settings
+
+script_base=$(realpath $(dirname $0))
+
+exec $script_base/../../../scripts/checkpatch.pl \
+	--subjective \
+	--max-line-length=90 \
+	--show-types \
+	--ignore ARCH_INCLUDE_LINUX \
+	--ignore BIT_MACRO \
+	--ignore COMPARISON_TO_NULL \
+	--ignore EMAIL_SUBJECT \
+	--ignore FILE_PATH_CHANGES \
+	--ignore GLOBAL_INITIALISERS \
+	--ignore LINE_SPACING \
+	--ignore MULTIPLE_ASSIGNMENTS \
+	$@
-- 
2.14.1
