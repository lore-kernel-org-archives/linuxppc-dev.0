Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D29C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:58:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA516217F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA516217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g00c6ycKzDqRb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:58:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzl51MVPzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzl36tjRz9s71; Thu, 11 Apr 2019 21:46:39 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzl33Dtjz9sCF; Thu, 11 Apr 2019 21:46:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 04/35] powerpc: Avoid code patching freed init
 sections
Date: Thu, 11 Apr 2019 21:45:59 +1000
Message-Id: <20190411114630.4042-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411114630.4042-1-mpe@ellerman.id.au>
References: <20190411114630.4042-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Neuling <mikey@neuling.org>

commit 51c3c62b58b357e8d35e4cc32f7b4ec907426fe3 upstream.

This stops us from doing code patching in init sections after they've
been freed.

In this chain:
  kvm_guest_init() ->
    kvm_use_magic_page() ->
      fault_in_pages_readable() ->
	 __get_user() ->
	   __get_user_nocheck() ->
	     barrier_nospec();

We have a code patching location at barrier_nospec() and
kvm_guest_init() is an init function. This whole chain gets inlined,
so when we free the init section (hence kvm_guest_init()), this code
goes away and hence should no longer be patched.

We seen this as userspace memory corruption when using a memory
checker while doing partition migration testing on powervm (this
starts the code patching post migration via
/sys/kernel/mobility/migration). In theory, it could also happen when
using /sys/kernel/debug/powerpc/barrier_nospec.

Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h | 1 +
 arch/powerpc/lib/code-patching.c | 8 ++++++++
 arch/powerpc/mm/mem.c            | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 703ddf752516..709f4e739ae8 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -8,6 +8,7 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
+extern bool init_mem_is_free;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 753d591f1b52..c77c486fbf24 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -14,12 +14,20 @@
 #include <asm/page.h>
 #include <asm/code-patching.h>
 #include <asm/uaccess.h>
+#include <asm/setup.h>
+#include <asm/sections.h>
 
 
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
 
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_is_free && init_section_contains(addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
+		return 0;
+	}
+
 	__put_user_size(instr, addr, 4, err);
 	if (err)
 		return err;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5f844337de21..1e93dbc88e80 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -62,6 +62,7 @@
 #endif
 
 unsigned long long memory_limit;
+bool init_mem_is_free;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -396,6 +397,7 @@ void __init mem_init(void)
 void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
+	init_mem_is_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-- 
2.20.1

