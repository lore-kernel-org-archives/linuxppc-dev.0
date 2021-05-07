Return-Path: <SRS0=iVLG=KC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7BDC433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 06:43:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8984B613C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 06:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8984B613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fc19G5F6Fz2yZM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 16:42:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JJsFu92l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JJsFu92l; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fc18p6Jk4z2yR7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 May 2021 16:42:34 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fc18h0M8Zz9sxS; Fri,  7 May 2021 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1620369748;
 bh=o0ryrURf9gQo7UBFJN9lVLEVAi82dROiQK+svY877wg=;
 h=From:To:Subject:Date:From;
 b=JJsFu92lJ8K/Kg4DUaNFkTx38jRoV1gj/C0qAojKOJsV5Wzcq33dZMXTg/uNV08vY
 N2Tzt1/tVhcOnnjETTHMVNpHNkqJZ4LDt72ENt3M87+Hg94ZINN28KHaOd3MMHfmm1
 LumVfDxAzfHofJBhJQ1oxomSJZ0Gm+jY9riaZDVMcZhMNANHPD+79mCXBhg1TPXX9m
 hSGtRt3olLy6eKh/JHGWcUSx5ZwZYi1WXEmAmRAkyWwP8/eUr5xgFzfbVG4UFMKCWo
 M6wuiCIk0o5tQrighjAx/xz+pv4Ii8Tq8/eeQrXhRa2amyDPPFum2n9kwsBHDeKL0O
 YLPPcjTZIy4+Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: Add test of mitigation patching
Date: Fri,  7 May 2021 16:42:25 +1000
Message-Id: <20210507064225.1556312-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We recently discovered some of our mitigation patching was not safe
against other CPUs running concurrently.

Add a test which enable/disables all mitigations in a tight loop while
also running some stress load. On an unpatched system this almost always
leads to an oops and panic/reboot, but we also check if the kernel
becomes tainted in case we have a non-fatal oops.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/security/Makefile       |  2 +
 .../powerpc/security/mitigation-patching.sh   | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tools/testing/selftests/powerpc/security/mitigation-patching.sh

diff --git a/tools/testing/selftests/powerpc/security/Makefile b/tools/testing/selftests/powerpc/security/Makefile
index 844d18cd5f93..7488315fd847 100644
--- a/tools/testing/selftests/powerpc/security/Makefile
+++ b/tools/testing/selftests/powerpc/security/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 TEST_GEN_PROGS := rfi_flush entry_flush uaccess_flush spectre_v2
+TEST_PROGS := mitigation-patching.sh
+
 top_srcdir = ../../../../..
 
 CFLAGS += -I../../../../../usr/include
diff --git a/tools/testing/selftests/powerpc/security/mitigation-patching.sh b/tools/testing/selftests/powerpc/security/mitigation-patching.sh
new file mode 100755
index 000000000000..00197acb7ff1
--- /dev/null
+++ b/tools/testing/selftests/powerpc/security/mitigation-patching.sh
@@ -0,0 +1,75 @@
+#!/usr/bin/env bash
+
+set -euo pipefail
+
+TIMEOUT=10
+
+function do_one
+{
+    local mitigation="$1"
+    local orig
+    local start
+    local now
+
+    orig=$(cat "$mitigation")
+
+    start=$EPOCHSECONDS
+    now=$start
+
+    while [[ $((now-start)) -lt "$TIMEOUT" ]]
+    do
+        echo 0 > "$mitigation"
+        echo 1 > "$mitigation"
+
+        now=$EPOCHSECONDS
+    done
+
+    echo "$orig" > "$mitigation"
+}
+
+rc=0
+cd /sys/kernel/debug/powerpc || rc=1
+if [[ "$rc" -ne 0 ]]; then
+    echo "Error: couldn't cd to /sys/kernel/debug/powerpc" >&2
+    exit 1
+fi
+
+tainted=$(cat /proc/sys/kernel/tainted)
+if [[ "$tainted" -ne 0 ]]; then
+    echo "Error: kernel already tainted!" >&2
+    exit 1
+fi
+
+mitigations="barrier_nospec stf_barrier count_cache_flush rfi_flush entry_flush uaccess_flush"
+
+for m in $mitigations
+do
+    do_one "$m" &
+done
+
+echo "Spawned threads enabling/disabling mitigations ..."
+
+if stress-ng > /dev/null 2>&1; then
+    stress="stress-ng"
+elif stress > /dev/null 2>&1; then
+    stress="stress"
+else
+    stress=""
+fi
+
+if [[ -n "$stress" ]]; then
+    "$stress" -m "$(nproc)" -t "$TIMEOUT" &
+    echo "Spawned VM stressors ..."
+fi
+
+echo "Waiting for timeout ..."
+wait
+
+tainted=$(cat /proc/sys/kernel/tainted)
+if [[ "$tainted" -ne 0 ]]; then
+    echo "Error: kernel became tainted!" >&2
+    exit 1
+fi
+
+echo "OK"
+exit 0
-- 
2.25.1

