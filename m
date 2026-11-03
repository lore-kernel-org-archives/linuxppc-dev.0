Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FD606A834
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngjnvLAI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJl0031xBz2xwP;
	Tue, 03 Nov 2026 21:18:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701104;
	cv=none; b=CVuPILTqfH/2VjfwbN0XO1+CtxK4zBt/CAAYpgRkPIzGOMWFQgdJF/Z97qKrXAwPb/MENle21T+KM808xw+N/s94PW5BaivnVXVTD2ZOmoGhXMrMOczUSmN87u/jYxkN7Rb0Mse8NoLvFIW/5nfIfxTKY2rN7UumHUvAqHuau9mF6mlg/kT4kqg/1X9bNnq5hze0SI8o1Bu+jRn+1MtGKzbuM65Zc/MvM5sXQFAayOpIV8glfOYPmyzuZLQ3BeaiQWfqVjTQpwnnXxPnovY3vF3mZLBRMCHQaQOjzq3fjG7Xc4ZrMPrHX7WJZq3lSb5QqbVoiVQABN5kqIdhkw7eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701104; c=relaxed/relaxed;
	bh=2UxkzZOuXMzEW1DRxwfP1Y2akfSOt2A5NGCydHJqRyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQYp1CiErVQDTGjxdo/CD1j5umFRrwrmK+bnNB/5dWT3vpLxbEpsQmt5ia1LNIoDBy+7QH4jf81pZ3byfGJpj2oZT+Qs2N3AJ1AHGbyXkhDd0jmBCe2EynQZFGK4aJH46DSCsr9n1Y7Z7nEVdQPSRzRdqHuZg/VP18/to5gClN6ze5ZtA0SyWZHsBGpEKkpTmrouoHmKJa/x4PqsZvHWi1DqUDJ9Evg2UOtjG8uhca277O0uL2Yp/58H4sfC4u038J2kzCjx+2VxcsbFZ/NPP4CmHBQ2KPto3FCeafv9LXWEDbOMY8ssmy+1F3/mqsk2pMIVzXJdmb28op+qvbHhBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngjnvLAI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngjnvLAI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkzz4kkcz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:18:23 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-36661f953e4so6082185eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701101; x=1794305901; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UxkzZOuXMzEW1DRxwfP1Y2akfSOt2A5NGCydHJqRyY=;
        b=ngjnvLAIboGyKS+eXJOqC4ae6IJD1eImXwidMJ5+ixpQNC4m9PTjHsFxrOx66WwCTD
         JMhcRQBs4+wZ0UkOMggz6CE9WYMluSmkywqAVtCHHFWa4PGM7xfePvwLEePk9u+O773e
         xahvq9TU4fR+2HJhvZLfCj8wPj1kky78O9S29Q+YmYz3vBx/LBbGgYNTlqhm0ckMCuoa
         GU1kdOW31EQmsZUytdK28m2m37cvsiWDBu/dQK7yz8fzeXy+9Sqiyee3YIZI5xUMLIS+
         CQaee6v7WE/RYR9mgYWRkqT2knyhpIBNkDwgXa4ucu/aFYwWGCLo6i3IZcVxfjg6L6ql
         3mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701101; x=1794305901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UxkzZOuXMzEW1DRxwfP1Y2akfSOt2A5NGCydHJqRyY=;
        b=fuiKQngPe9Dc7GPQzXCXm2OHX21N0DKtpi5lu6Z3gnMW9Z9eX9v0ZhmdfUx5i+QSYi
         WhkUItE4e8crTQWpFcoP+dSuWMCB2vTD3JlwPpvaR+qBnaWGb2eyE0rrQc9QEht7Qom9
         xrtCTjXSAKIhEtxlMXajwnCzaNpazHS/6MrAGfq98aAX9qgkOo+sNFR83TeTG/1G25Sb
         WUdlc2NXWd60aJWeD9YITSpy36kHHOdaIrBK4I4hLONgXndyZd0TXcwmB2ifeBKWSc4k
         ZFFlgoAD4vIAn41uIpjboIxnhg2txkOS3qy84wgcaxC31xRLtlb8O2DYynlgDEx7DHZw
         7vGg==
X-Forwarded-Encrypted: i=1; AKwUvBzPg+bz8VJPmv25WkHeKbOFZPVLX0Jo9oQ/9GZSTiuozsKreBu2a4tnqVWq4fT1F6wKQpdt5j6GBMFDplc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/6zj8cWFQV7E+bxt7flZQ2RGl8OQy6yNSf0i380Hr2g1oEGB9T
	FHtnUjNzG1avtzpSFC2bRAi9slImlRsEyYMg4+Ht5f7PPIW4jCoqBDQ/
X-Gm-Gg: AYBFou3ozLdXbhTW0HQiCO7kAotMDJMmjUiP7Y7dN/cdRqvM+xMc+86AmbrBbTfbQCk
	zpN7KOcoqYr7dx6eQCz370P92DcfHnLedOD7lypaSVUeIQn+QrJNW77l/zkhoskgjqejgG9QgK4
	062ZRC+jwVsFjIO+3hMNtdVfYob/ZI2b6UJ2DXCv0TnHDCboSAUmcJGQePsA8xXxZvdoq/EyJnx
	Eq5VekeC2axoPaFMp7NWXq7hCIgRT/BjbNT4wmD1hWLcSs6SkBEORaJEKZz13qISjVBMIOrj/zP
	8OzdhNZi+GcofgC8cOkcs0Haz1JqBh44iSFGE0RUmBVaShfEpboTwaf1h6Kx5lfTOFf9e+Gq72H
	KFTKhtlKK4DtHxq3IpPd95kllDisJArMkVO2MCaWfBc2rtytfuKCmniAsE4x+GbvtOgOyyojcxT
	r/yT1Me23R8FHk9TE5XWV8tFGAYs78rL/TAnbGxxtL+osS4Tt7iQ3bk1+l9jn6T4BbBNqO+BTbN
	qABU7peqANb+I41r8F68pFbjI8XIPk5uy9GLfyGWphY37NR2j/8UnzurGbfUU9eQ1Q3Fg9ioX4y
	OTwp7YwEDrttuiqCQvNGP8TIkRFg/w==
X-Received: by 2002:a05:7300:c019:20b0:36b:f09f:924a with SMTP id 5a478bee46e88-36bf09fa41emr1926474eec.14.1793701101482;
        Tue, 03 Nov 2026 02:18:21 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:18:20 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v11 10/10] mm/vmalloc: align vm_area so vmap() can batch mappings
Date: Tue,  3 Nov 2026 18:16:58 +0800
Message-Id: <20261103101658.766905-11-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

Try to align the vmap virtual address to PMD_SHIFT or a
larger PTE mapping size hinted by the architecture, so
contiguous pages can be batch-mapped when setting PMD or
PTE entries. We do not expect any significant overhead for
this.

Add __get_vm_area_node_aligned_caller() as a wrapper over
__get_vm_area_node() to simplify repeated calls with fixed
arguments.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---

Sashiko review: raised two concerns:

- Hardcoding GFP_KERNEL in __get_vm_area_node_aligned_caller() strips the
  caller's ability to prevent blocking, reclaim, or warnings.

- The speculative PMD-aligned allocation, on failure, could trigger
  spurious vmalloc purges (reclaim_and_purge_vmap_areas(), synchronous
  TLB flushes, shrinker storms), a possible DoS for vmap() >= PMD_SIZE.

Both follow existing behavior: GFP_KERNEL matches the adjacent
get_vm_area_caller(), which hardcodes it the same way. The purge concern
is not new -- __vmalloc_node_range() already attempts PMD-aligned
allocation in __get_vm_area_node() with the same fallback through
alloc_vmap_area() overflow/purge, so vmap_get_aligned_vm_area() adds no
new purge behavior.

 mm/vmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 42b3addd20f9..e15bcef804fc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3361,6 +3361,14 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
+static struct vm_struct *__get_vm_area_node_aligned_caller(unsigned long size,
+		unsigned long align, unsigned long flags, const void *caller)
+{
+	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
+				  NUMA_NO_NODE, GFP_KERNEL, caller);
+}
+
 /**
  * find_vm_area - find a continuous kernel virtual area
  * @addr:	  base address
@@ -3692,6 +3700,30 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 	return err;
 }
 
+static struct vm_struct *vmap_get_aligned_vm_area(unsigned long size,
+		unsigned long flags, pgprot_t prot, const void *caller)
+{
+	struct vm_struct *vm_area;
+	unsigned int shift;
+
+	if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE) {
+		vm_area = __get_vm_area_node_aligned_caller(size, PMD_SIZE,
+				flags, caller);
+		if (vm_area)
+			return vm_area;
+	}
+
+	shift = arch_vmap_pte_supported_shift(size);
+	if (shift > PAGE_SHIFT) {
+		vm_area = __get_vm_area_node_aligned_caller(size, 1UL << shift,
+				flags, caller);
+		if (vm_area)
+			return vm_area;
+	}
+
+	return __get_vm_area_node_aligned_caller(size, PAGE_SIZE, flags, caller);
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers
@@ -3730,7 +3762,8 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	size = (unsigned long)count << PAGE_SHIFT;
-	area = get_vm_area_caller(size, flags, __builtin_return_address(0));
+	area = vmap_get_aligned_vm_area(size, flags, prot,
+				__builtin_return_address(0));
 	if (!area)
 		return NULL;
 
-- 
2.34.1


