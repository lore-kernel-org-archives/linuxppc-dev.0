Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CFC65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:47:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26DD20849
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26DD20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FkkS5VfnzDr8q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:47:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Fk5f2b7gzDqck
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 17:18:46 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 562DEAE807CB;
 Thu, 13 Dec 2018 01:18:42 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v5 17/20] powerpc/powernv/npu: Fault user page into the
 hypervisor's pagetable
Date: Thu, 13 Dec 2018 17:17:31 +1100
Message-Id: <20181213061734.16651-18-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213061734.16651-1-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When a page fault happens in a GPU, the GPU signals the OS and the GPU
driver calls the fault handler which populated a page table; this allows
the GPU to complete an ATS request.

On the bare metal get_user_pages() is enough as it adds a pte to
the kernel page table but under KVM the partition scope tree does not get
updated so ATS will still fail.

This reads a byte from an effective address which causes HV storage
interrupt and KVM updates the partition scope tree.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2c405a4..ed81426 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1133,6 +1133,8 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 	u64 rc = 0, result = 0;
 	int i, is_write;
 	struct page *page[1];
+	const char __user *u;
+	char c;
 
 	/* mmap_sem should be held so the struct_mm must be present */
 	struct mm_struct *mm = context->mm;
@@ -1145,18 +1147,17 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 					is_write ? FOLL_WRITE : 0,
 					page, NULL, NULL);
 
-		/*
-		 * To support virtualised environments we will have to do an
-		 * access to the page to ensure it gets faulted into the
-		 * hypervisor. For the moment virtualisation is not supported in
-		 * other areas so leave the access out.
-		 */
 		if (rc != 1) {
 			status[i] = rc;
 			result = -EFAULT;
 			continue;
 		}
 
+		/* Make sure partition scoped tree gets a pte */
+		u = page_address(page[0]);
+		if (__get_user(c, u))
+			result = -EFAULT;
+
 		status[i] = 0;
 		put_page(page[0]);
 	}
-- 
2.17.1

