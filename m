Return-Path: <linuxppc-dev+bounces-17256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B893FC5933
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:35:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8WC6bQLz30hP;
	Thu, 26 Feb 2026 22:34:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::bc"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105671;
	cv=none; b=SqEdCjRN0xjHmej3Lxe7qEiEV/fpQsSPGXpwoyweXKwK1atgMIsXCTnyhtoROIkm2RVh1UbhmVmwTlnN72X+R8apX9xAZXaAGu+44/rLVGxzoGZ46hyPzXdyoUJ9fCIHutTYuPVfK+5E+fqYuR/vRpuE899vIMjfkJhJZflKlpw54HOCewKx8ovMTRuglIOJtL6aU1PR3rZcZTfnoHP25yHC4IjGz8rSqZ4AF7riWL4mR8zZAUKRl6+shMXC1vW3vvMQixboyDvWqoNVB0gPBEnyg0YhmPbVywIsT6wjU/bSoO2D47CsT6rssRnowaR/ZUw0zoWa5lu8Tzxn3xma8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105671; c=relaxed/relaxed;
	bh=S0H8ygH+YlO4CNCx03qcK3DVZPCm8qVQiV1k1Y2d+/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMHAJsfe6NkhN/NqIn/14Qqug6IV1D8xDzxrp8IIWC0DmiayV3fKlG9V9N8YCOyOtCmYJiKtZhvK549pU5FEHSz4RVdPsx3afXy/YQtFwpF1sK9df8oKz1TNML8pKjTsjKxfJyesUXWxks9KJdKP/LDU08Drwzki2zT/Q8HbPR5iXhcndlJrJsgxiU/whh7nc/mnwk39zFkFqmqlc6nqFA0RhSY8b8Qd4YVH+qxYprWYumBr3zyGjgCZrpfQ0mJLun7+me6IRih6xdfeKMx6+ryKu/7clZWKxAXtGiMkphrv6zUiMcI+FQ3xfNMrUW+jPUQD9+Jqls2r/hKsK28dxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WE+bzrYN; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::bc; helo=out-188.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WE+bzrYN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::bc; helo=out-188.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Thu, 26 Feb 2026 22:34:31 AEDT
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8WC1fWWz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:34:31 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0H8ygH+YlO4CNCx03qcK3DVZPCm8qVQiV1k1Y2d+/k=;
	b=WE+bzrYNxkX7rkOvVYIotj0P/HNDg7dgr5BIyKjoWK6c/gNQyNgdKm5vkjTkfoZRMJ11uG
	7YnOvlg6mRw5/v+qJxjjYm2FpSYphCBWmhfAjo9Kp1SB7EoIDR3aW2hScwzOCQc+oLE42l
	nXUPqt58pVi3eC52uFA6Yk2oOf9BZZA=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC v2 13/21] mm: huge_mm: Make sure all split_huge_pmd calls are checked
Date: Thu, 26 Feb 2026 03:23:42 -0800
Message-ID: <20260226113233.3987674-14-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Mark __split_huge_pmd(), split_huge_pmd() and split_huge_pmd_address()
with __must_check so the compiler warns if any caller ignores the return
value. Not checking return value and operating on the basis that the pmd
is split could result in a kernel bug. The possibility of an order-0
allocation failing for page table allocation is very low, but it should
be handled correctly.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/huge_mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 207bf7cd95c78..b4c2fd4252097 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -419,7 +419,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped);
 void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 #endif
 
-int __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
+int __must_check __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
 
 /**
@@ -448,7 +448,7 @@ static inline bool pmd_is_huge(pmd_t pmd)
 	return false;
 }
 
-static inline int split_huge_pmd(struct vm_area_struct *vma,
+static inline int __must_check split_huge_pmd(struct vm_area_struct *vma,
 					     pmd_t *pmd, unsigned long address)
 {
 	if (pmd_is_huge(*pmd))
@@ -456,7 +456,7 @@ static inline int split_huge_pmd(struct vm_area_struct *vma,
 	return 0;
 }
 
-int split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
+int __must_check split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 		bool freeze);
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-- 
2.47.3


