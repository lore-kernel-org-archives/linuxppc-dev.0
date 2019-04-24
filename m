Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EDC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:01:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A7B2084F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+a9eU1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A7B2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q3Rq2XXNzDqRp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:01:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="E+a9eU1w"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q3926vZpzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 00:48:38 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2082D218FE;
 Wed, 24 Apr 2019 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556117307;
 bh=5HDGAh0QbI2VY/kbAiK5FAqvJFcRtvLJDVA3Il/vCuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E+a9eU1wrQsk6nObqZ/8xl7udl4eQ87xlUgJCS1FPmODkgXUSwG97za5zI4KuIsFO
 ZAfm4xKML72RP4P7wz7aO5nCMN10isHOBDOUtXF/SMM13R9sKtUcq+SNR6hiPV79vE
 ioW8LARRKUc43W1i37zX7kfggsng+gBr4vXbUv60=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/35] kmemleak: powerpc: skip scanning holes in
 the .bss section
Date: Wed, 24 Apr 2019 10:47:03 -0400
Message-Id: <20190424144709.30215-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit 298a32b132087550d3fa80641ca58323c5dfd4d9 ]

Commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel.  As the
result, kmemleak scan will trigger a panic when it scans the .bss
section with unmapped pages.

This patch creates dedicated kmemleak objects for the .data, .bss and
potentially .data..ro_after_init sections to allow partial freeing via
the kmemleak_free_part() in the powerpc kvm_free_tmp() function.

Link: http://lkml.kernel.org/r/20190321171917.62049-1-catalin.marinas@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Qian Cai <cai@lca.pw>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Tested-by: Qian Cai <cai@lca.pw>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Avi Kivity <avi@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/kvm.c |  7 +++++++
 mm/kmemleak.c             | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ad37f827a97..7b59cc853abf 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -22,6 +22,7 @@
 #include <linux/kvm_host.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmemleak.h>
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -712,6 +713,12 @@ static void kvm_use_magic_page(void)
 
 static __init void kvm_free_tmp(void)
 {
+	/*
+	 * Inform kmemleak about the hole in the .bss section since the
+	 * corresponding pages will be unmapped with DEBUG_PAGEALLOC=y.
+	 */
+	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
+			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d9e0be2a8189..337be9aacb7a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1492,11 +1492,6 @@ static void kmemleak_scan(void)
 	}
 	rcu_read_unlock();
 
-	/* data/bss scanning */
-	scan_large_block(_sdata, _edata);
-	scan_large_block(__bss_start, __bss_stop);
-	scan_large_block(__start_ro_after_init, __end_ro_after_init);
-
 #ifdef CONFIG_SMP
 	/* per-cpu sections scanning */
 	for_each_possible_cpu(i)
@@ -2027,6 +2022,17 @@ void __init kmemleak_init(void)
 	}
 	local_irq_restore(flags);
 
+	/* register the data/bss sections */
+	create_object((unsigned long)_sdata, _edata - _sdata,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	/* only register .data..ro_after_init if not within .data */
+	if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
+		create_object((unsigned long)__start_ro_after_init,
+			      __end_ro_after_init - __start_ro_after_init,
+			      KMEMLEAK_GREY, GFP_ATOMIC);
+
 	/*
 	 * This is the point where tracking allocations is safe. Automatic
 	 * scanning is started during the late initcall. Add the early logged
-- 
2.19.1

