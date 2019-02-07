Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA3C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 12:51:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB9720823
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 12:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB9720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wJ8p0nPGzDqSN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 23:51:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wJ3c2PpHzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 23:46:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43wJ3c07s1z9s4V; Thu,  7 Feb 2019 23:46:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wJ3b6Jzkz9s6w; Thu,  7 Feb 2019 23:46:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/7] powerpc: Add PVR & CPU name to dump stack arch
 description
Date: Thu,  7 Feb 2019 23:46:30 +1100
Message-Id: <20190207124635.3885-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, pmladek@suse.com, linux-kernel@vger.kernel.org,
 sergey.senozhatsky@gmail.com, tj@kernel.org, akpm@linux-foundation.org,
 dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As soon as we've done some basic setup, add the PVR and CPU name to
the dump stack arch description, which is printed in case of an oops.

eg: Hardware name: ... POWER8E (raw) pvr:0x4b0201

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c | 1 +
 arch/powerpc/kernel/prom.c     | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1eab54bc6ee9..8b4520a84612 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
+#include <linux/printk.h>
 
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4181ec715f88..ea2c3498067d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -761,6 +761,10 @@ void __init early_init_devtree(void *params)
 
 	dt_cpu_ftrs_scan();
 
+	/* We can now set the CPU name & PVR for the oops output */
+	dump_stack_add_arch_desc("%s pvr:0x%04lx", cur_cpu_spec->cpu_name,
+				 mfspr(SPRN_PVR));
+
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
 	 */
-- 
2.20.1

