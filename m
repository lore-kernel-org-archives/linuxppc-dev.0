Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A3AC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 12:59:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF512083B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 12:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF512083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wJKc3yVFzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 23:59:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wJ3g0klPzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 23:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43wJ3f6wlpz9sNJ; Thu,  7 Feb 2019 23:46:54 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wJ3f5VMrz9sNH; Thu,  7 Feb 2019 23:46:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 5/7] powerpc: Add ppc_md.name to dump stack arch description
Date: Thu,  7 Feb 2019 23:46:33 +1100
Message-Id: <20190207124635.3885-5-mpe@ellerman.id.au>
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

As soon as we know the name of the machine description we're using, add
it to the dump stack arch description, which is printed in case of an
oops.

eg: Hardware name: ... machine:pSeries

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb97cf8..00d900b1e584 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
@@ -638,6 +639,8 @@ void probe_machine(void)
 		for (;;);
 	}
 
+	dump_stack_add_arch_desc("machine:%s", ppc_md.name);
+
 	printk(KERN_INFO "Using %s machine description\n", ppc_md.name);
 }
 
-- 
2.20.1

