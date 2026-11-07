Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF12606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ig004Afg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHWc6TPnz2yMn;
	Sun, 08 Nov 2026 00:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059468;
	cv=none; b=fF9gZ6sbN/HsJjHzS9qFVcG4Qp8PfzPWqDFJkgvXJqggUKqF7Qm8INYHLwEFFcEh/7OmuooXANRCIXiX1k+371PslDjVw3Fbhg4R9OYRjsNIzugvF2+9pi/+nULY2XeMD30o3pg4H8q0ZCEY5XMqXVYSrNDeSGPJLUie6IwoOJdUExBSifPftM+PeUfqorMLI0Vsd/N0cGW+ezkOYarDMOfsOczeltexUov0ixlV9kNw0KOhgYgyJ5HUDsgqKpimIiAfZaLFByygZ4CFCkkKY5GQVG0+Tzl/vzgw9577r/O2IHmsLJVio/auMhrAeJ/b6PvXySemH0tgbebusKpggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059468; c=relaxed/relaxed;
	bh=baZEbrhbhDEpq9QKIXgzBR/d0LlM+jrSsgwjy5hT7Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKyf9AS8N6or9C0mNg+easc8GupYGelAx0T+BKknJAjcCXxwRSeBrFSPw8YALGKFVwhA993RA460XcB2QZ/N2v2XRRz+zGuVzNJgauEyCnFxA/bqidXkpGF+vFXF0rvvdgK+9Cfo7FRMGaY7WXtbKR9w3/pibbhjL0eyMgohiI+U9so9j+vhfbT+t8m2BRjVLugQx7JL66cjFpvQtlnhx0rcdM2RXSqw1ARgcdbJMWAK3UWJ9sH7C5Mv2Zz2GMic/fNFocgb3VwRiLESC+8g8EtRWHJdCMJ8mg3bWUQEa3zl8xQfBJ9QmEL04NiyHX2828ZAajRjjBGlQndTE/omIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ig004Afg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ig004Afg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHWc27vnz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:51:08 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2552102eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059466; x=1794664266; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=baZEbrhbhDEpq9QKIXgzBR/d0LlM+jrSsgwjy5hT7Ro=;
        b=ig004Afg9vezA559rl/pQwHdeNfLU1oHvcOI3+brxMclZAKLSL0Kxm8E65m3gRcmmk
         FLsYZt6C67q0xqEOX8w/SSJHpoTw67YlrA5aE/LcUDI44OdssbPeQkfkGXCwm3VUOJBm
         WmY+BhiDKOWilOTo+/RTAo9zUXe13BDsQ0wpqa3idtr3/Zkj82YZj7ZODnKhOoUrb/Tp
         6TLU3tzE18h2TTLFLoD86Nv4ClQfTjct70O2m1jFzLLy0Jqdwl6WJvQw/6ZBsR4Kzke+
         wXlsw23mngfk21wPuEjhSdLsi4CCLkmP7a67HLQkaeUfVz03sieA1KFhDUJ5GfxWKUvn
         UiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059466; x=1794664266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=baZEbrhbhDEpq9QKIXgzBR/d0LlM+jrSsgwjy5hT7Ro=;
        b=GhAcv3NTxO5Blhh3KjWgNJ8YmWFtjI/V3UZrJmVaPFKa/63Q5CmHmivrJoKBoHIQ21
         s9fRvz1JUO3VkA3Ekr9mrTBU2XU+FqEfGjguzU2iGZ2HYoA98SWCxWElGxMzug0yjzJR
         F5Ma3Ul6dlJbT+grGIUFiu3kd9mREhc+bny0auRx2y7Cu8WOk0ViLfOhfZHHizYgkJkO
         b21dgQvrPPe23k84acdEtVGRtu+X+m8k0j5MMJviaUEHs/JCJLV/qZdkRVo6wMKieHOV
         Cc0ck2K78AppvCxHbs8T3v4WmoyUIXmbt9YYSZkRka0Y0zRfYYq/P1Okmzl3MgfdRQAa
         m35w==
X-Forwarded-Encrypted: i=1; AL+hErHZ+EjRacAP6F4euRwnP9EEmwYHSXOqgNqjVx3AGPRlDY1XAa8yJ3cHmJE8lsdpKRFAdidwPqBFcF8ZnA8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/o4dQX95mWuelLkVIxfai1eIdzs7HZPFjXq0UElcsbNsIV4kNS
	cl47lNQn1QPoWsy7l1JIiGJUCaT0IF78/YVNzOB9lMMLNKYE3TUB0bp/b4vmmTwChTo=
X-Gm-Gg: AYBFou0NpyzzsSB11AWtPW4FEo260G5lC7AHzDtU1jJVrVpEKKNW5oqc/9ltjkS/tNF
	d5kmsAZzjr0NAC0WqlP4K3k6xjlRhbIwRakZx1okr8VNwIPWRqkRkWOtBIhlQx9S2lMiH56XfP3
	XTaqK2q2n17pmqZEeV2FyF1qTaa9Wtohl7+8RompHDr1mVkrbmslmxr5OauY8fqJvb4kqXG/BFJ
	kRFITynuxH2LiGloJZMdnJkytPbPC/4TXpQgq8lE9KYMC8r0CLOnFSYVETyqSolLdYNuO+kDAOd
	XGXjRbcoTVqNEESVI4v0Q//Gpwy6BbK11zY6kwrK1nHGTaq0v7ry24Edgob0ZtvMO4PuPN9TRMJ
	/qxvaGXNgDjWIuYvmqoZ6ngcVV7wIqkkSlWszu3ZE8hvIsPhDB9EaMYJHG/ZoPBhVVg45sszoLq
	ik9rz+1tFAAesCxH4QG55k7Tm/qyfN2oO9X/tRa4J53s97TGqe3CuFEEspuPQzwMOgFyP/wxGrj
	AEBIjgKTYfU8JVFRPliHLP0AidOyD9fen52n484Dyg3X4oqyfnD1AI9cQMB/etUrEG5eI11fFjZ
	wxQiQ8UBO7qaw9kxC6nONk+gj8/Egg5q2TPVmhLfiwZGWG42CqhU0cWWDQ==
X-Received: by 2002:a05:7301:6486:b0:36e:97b4:1071 with SMTP id 5a478bee46e88-36f75b1f828mr7447409eec.14.1794059466185;
        Sat, 07 Nov 2026 05:51:06 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:51:05 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 10/10] mm/vmalloc: align vm_area so vmap() can batch mappings
Date: Sat,  7 Nov 2026 21:49:53 +0800
Message-Id: <20261107134953.748622-11-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
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
 mm/vmalloc.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5b898da0826ad..6a150b11261a3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3365,6 +3365,14 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
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
@@ -3696,6 +3704,30 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
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
@@ -3734,8 +3766,8 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	size = (unsigned long)count << PAGE_SHIFT;
-	area = get_vm_area_caller(size, flags | VM_UNINITIALIZED,
-				  __builtin_return_address(0));
+	area = vmap_get_aligned_vm_area(size, flags | VM_UNINITIALIZED, prot,
+					__builtin_return_address(0));
 	if (!area)
 		return NULL;
 
-- 
2.34.1


