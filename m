Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66724C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 14:59:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21AA20854
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 14:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IxW5mbW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21AA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KFNt3w16zDqLB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 01:59:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="IxW5mbW8"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KFLz5k6VzDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 01:57:46 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id v20so2196020qtv.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Un1Wj5GPEV4DDdwQhW14uochoQcu3HXcwsxXJUzPAR4=;
 b=IxW5mbW8OXhWYBl5olTK0B4P4DCUucECOk4BS6ZorrPhOInBXBY8Ll0COS9gSTZgjc
 W42sTm9x9tH3qiNfjLBfVuCc63CEIutI4JDGjggyTlcovacih/UCrW/erEvpQYwiTvU0
 dxNBramECvQraogjqbu1WQJP5xCmW5sy5ZRXyxEStYJ7R49ZNkdEke86Rebr6B5VQkgS
 aUZIrQXhpoiCg63BuS56GnFtuB/VMLt+c7L6Hy0bfYht0GQLci1aUVfzT8UYDS7sL0dU
 vc0hruN0qK6Nc5F7nnTlpyQJABDow6oCBb3jBb2Zj+FWGm9JqYaYIjNSv94DE9+DUs2B
 HFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Un1Wj5GPEV4DDdwQhW14uochoQcu3HXcwsxXJUzPAR4=;
 b=PFEoCs+M+y2gr36Ix8N0wV/kqXeKvSAsj2SSVIcD5uuQ2ViL8Haey+H95/dBKLeKUk
 LiGX/gTm0LGRp0+jNdtt1gmOdjaAmjPg4l84qn3XPMmQE2/tQFwvZkh+MKXPICo0D+OO
 N9W19F6E5VnDyUq0VwIJ6zg++I3QtLjWu1CJyHZfuKhdXtiFvyp1vk48HHmeq4ce5MTE
 Lb2CUFYZLHySqcOyhU8Sp1a2GYEB/LWa3/VZ9y4cxyApshKuA+HBt1efLVhzedTfyR5P
 8DsWwSD6eVy8b0+GitoDd17tXc4gVrWZWLUnujfYhedApeNVa5gvDZukHCJaKnACDPYy
 cHag==
X-Gm-Message-State: APjAAAUMTlczq3BnNxOv974zvZOoCcqp0RxEhNJdQJ09JxgXKiUHRgY8
 U88YkeDVW+qy2wtngkGYFDW/3g==
X-Google-Smtp-Source: APXvYqytxb63jyMnDlJeptDoovBqtzEN/GpsodLxiXOb+sB9nGXC86ZavBMJf5o3MI71ggxndlF0+A==
X-Received: by 2002:ac8:371d:: with SMTP id o29mr4020271qtb.389.1552489063708; 
 Wed, 13 Mar 2019 07:57:43 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id a43sm8172501qta.54.2019.03.13.07.57.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Mar 2019 07:57:42 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: akpm@linux-foundation.org
Subject: [PATCH v2] kmemleak: skip scanning holes in the .bss section
Date: Wed, 13 Mar 2019 10:57:17 -0400
Message-Id: <20190313145717.46369-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, Qian Cai <cai@lca.pw>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel. As the
result, kmemleak scan will trigger a panic below when it scans the .bss
section with unmapped pages.

Since this is done way before the first kmemleak_scan(), just go
lockless to make the implementation simple and skip those pages when
scanning the .bss section. Later, those pages could be tracked by
kmemleak again once allocated by the page allocator. Overall, this is
such a special case, so no need to make it a generic to let kmemleak
gain an ability to skip blocks in scan_large_block() for now.

BUG: Unable to handle kernel data access at 0xc000000001610000
Faulting instruction address: 0xc0000000003cc178
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA pSeries
CPU: 3 PID: 130 Comm: kmemleak Kdump: loaded Not tainted 5.0.0+ #9
REGS: c0000004b05bf940 TRAP: 0300   Not tainted  (5.0.0+)
NIP [c0000000003cc178] scan_block+0xa8/0x190
LR [c0000000003cc170] scan_block+0xa0/0x190
Call Trace:
[c0000004b05bfbd0] [c0000000003cc170] scan_block+0xa0/0x190 (unreliable)
[c0000004b05bfc30] [c0000000003cc2c0] scan_large_block+0x60/0xa0
[c0000004b05bfc70] [c0000000003ccc64] kmemleak_scan+0x254/0x960
[c0000004b05bfd40] [c0000000003cdd50] kmemleak_scan_thread+0xec/0x12c
[c0000004b05bfdb0] [c000000000104388] kthread+0x1b8/0x1c0
[c0000004b05bfe20] [c00000000000b364] ret_from_kernel_thread+0x5c/0x78
Instruction dump:
7fa3eb78 4844667d 60000000 60000000 60000000 60000000 3bff0008 7fbcf840
409d00b8 4bfffeed 2fa30000 409e00ac <e87f0000> e93e0128 7fa91840
419dffdc

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: make the function __init per Andrew.

 arch/powerpc/kernel/kvm.c |  3 +++
 include/linux/kmemleak.h  |  4 ++++
 mm/kmemleak.c             | 25 ++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 683b5b3805bd..5cddc8fc56bb 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
+#include <linux/kmemleak.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -712,6 +713,8 @@ static void kvm_use_magic_page(void)
 
 static __init void kvm_free_tmp(void)
 {
+	kmemleak_bss_hole(&kvm_tmp[kvm_tmp_index],
+			  &kvm_tmp[ARRAY_SIZE(kvm_tmp)]);
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 5ac416e2d339..17d3684e81ab 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -46,6 +46,7 @@ extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
 extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
 extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
+extern void kmemleak_bss_hole(void *start, void *stop) __init;
 
 static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
 					    int min_count, slab_flags_t flags,
@@ -131,6 +132,9 @@ static inline void kmemleak_not_leak_phys(phys_addr_t phys)
 static inline void kmemleak_ignore_phys(phys_addr_t phys)
 {
 }
+static inline void kmemleak_bss_hole(void *start, void *stop)
+{
+}
 
 #endif	/* CONFIG_DEBUG_KMEMLEAK */
 
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 707fa5579f66..a2d894d3de07 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -237,6 +237,10 @@ static int kmemleak_skip_disable;
 /* If there are leaks that can be reported */
 static bool kmemleak_found_leaks;
 
+/* Skip scanning of a range in the .bss section. */
+static void *bss_hole_start;
+static void *bss_hole_stop;
+
 static bool kmemleak_verbose;
 module_param_named(verbose, kmemleak_verbose, bool, 0600);
 
@@ -1265,6 +1269,18 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
+/**
+ * kmemleak_bss_hole - skip scanning a range in the .bss section
+ *
+ * @start:	start of the range
+ * @stop:	end of the range
+ */
+void __init kmemleak_bss_hole(void *start, void *stop)
+{
+	bss_hole_start = start;
+	bss_hole_stop = stop;
+}
+
 /*
  * Update an object's checksum and return true if it was modified.
  */
@@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
 
 	/* data/bss scanning */
 	scan_large_block(_sdata, _edata);
-	scan_large_block(__bss_start, __bss_stop);
+
+	if (bss_hole_start) {
+		scan_large_block(__bss_start, bss_hole_start);
+		scan_large_block(bss_hole_stop, __bss_stop);
+	} else {
+		scan_large_block(__bss_start, __bss_stop);
+	}
+
 	scan_large_block(__start_ro_after_init, __end_ro_after_init);
 
 #ifdef CONFIG_SMP
-- 
2.17.2 (Apple Git-113)

