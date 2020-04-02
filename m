Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB1C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 12:52:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63DC20784
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 12:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mjsO/yAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63DC20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tNJV0vkTzDrPq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 23:52:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tNDg1cNmzDrFh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2020 23:49:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mjsO/yAU; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48tNDf38Jzz9sQx; Thu,  2 Apr 2020 23:49:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48tNDf0NxVz9sR4; Thu,  2 Apr 2020 23:49:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585831762;
 bh=GGP+0zf9EBTscsgyjDoTx8yOuRiuyPkKJ+KFNkwHTsk=;
 h=From:To:Cc:Subject:Date:From;
 b=mjsO/yAU1kTuX2lOkLXvUlTWozMN9fbJIkpy+YvmOteTUdWb7ux5nT4aQBmnhixPQ
 Xj8xK+hKFgPXG5x//yBTWaqH1f+MRkXIXVrQ7IhMUYAad5dBHYJ615KkQpiJXK4G0u
 Oh1hKXC1P4DQblhDDOd841VmdHXwZLMO5D1/kx/ysB9bj50d5EfYEX+yz0LpUMlYcs
 WIkV8F15NjQSTWi1ssuw+dnk/MKR51R3PVYaGftU7GGclGIwxQvf1La5+ZZZx72fjr
 GO2icX0ODWtjYEoEM4vwrECsKlo6teqfF4VXsJ3tvVjkbH6tpeuI8lXgQWnVeBkXzw
 JUDVfsgBwOJEQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/64: Update Speculation_Store_Bypass in
 /proc/<pid>/status
Date: Thu,  2 Apr 2020 23:49:29 +1100
Message-Id: <20200402124929.3574166-1-mpe@ellerman.id.au>
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
Cc: gwalbon@linux.ibm.com, ricklind@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently we don't report anything useful in /proc/<pid>/status:

  $ grep Speculation_Store_Bypass /proc/self/status
  Speculation_Store_Bypass:       unknown

Our mitigation is currently always a barrier instruction, which
doesn't map that well onto the existing possibilities for the PR_SPEC
values.

However even if we added a "barrier" type PR_SPEC value, userspace
would still need to consult some other source to work out which type
of barrier to use. So reporting "vulnerable" seems sufficient, as
userspace can see that and then consult its source to determine what
barrier to use.

Signed-off-by: Gustavo Walbon <gwalbon@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

v2: Change the logic.

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index bd70f5be1c27..7c0b7b55e969 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/prctl.h>
 #include <linux/seq_buf.h>
 
 #include <asm/asm-prototypes.h>
@@ -353,6 +354,40 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
 	return sprintf(buf, "Vulnerable\n");
 }
 
+static int ssb_prctl_get(struct task_struct *task)
+{
+	if (stf_enabled_flush_types == STF_BARRIER_NONE)
+		/*
+		 * We don't have an explicit signal from firmware that we're
+		 * vulnerable or not, we only have certain CPU revisions that
+		 * are known to be vulnerable.
+		 *
+		 * We assume that if we're on another CPU, where the barrier is
+		 * NONE, then we are not vulnerable.
+		 */
+		return PR_SPEC_NOT_AFFECTED;
+	else
+		/*
+		 * If we do have a barrier type then we are vulnerable. The
+		 * barrier is not a global or per-process mitigation, so the
+		 * only value we can report here is PR_SPEC_ENABLE, which
+		 * appears as "vulnerable" in /proc.
+		 */
+		return PR_SPEC_ENABLE;
+
+	return -EINVAL;
+}
+
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_get(task);
+	default:
+		return -ENODEV;
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int stf_barrier_set(void *data, u64 val)
 {

base-commit: c17eb4dca5a353a9dbbb8ad6934fe57af7165e91
-- 
2.25.1

