Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F826606A33D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tF15i4UA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkzJ2YGtz2xb9;
	Tue, 03 Nov 2026 21:17:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701068;
	cv=none; b=MW0OeUtHJBKNFLydYiAqINHtDZ4qC2XZ2JF1qzfX2DZvZFCBZ0yd7DxOxE2F+QLPRDZ2x1G7QHu4nP1p2PGq60Mba3OQjBXogsPlxmEcrbqFLgUM0vnqQx4q/h15zOL005lF3cleGWsoq+Exfht43w01Sihk15lXaJVbKfdoaUyrUq2QCfOOXuNJ1ITm+QYu8lNIZSu2lb1g/stnoM4nVKp7Q3YktNmCE8Fh5sPH3ZD5Jcu6JaIUnhUV6v4Z9NXWfgOFUbE8onTXDefpBdiK+yhs2DCGWvS8teiaEfsg8KZXlCBj43lEmfApRduRnqXG7Yt9QrpjohVigxrZ8PbGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701068; c=relaxed/relaxed;
	bh=SEyHpuH65RtgAfPnavKG94t3MsEPEX7xZ6UjOz6FFS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IljFolPhG6SePGMdA6tDl0O783cFHoaUCi0hggxYNBozotknwDUnxitRM2tVPXgoI9NEHvC9v0NxMvmv2VVQ2gs0eZ5N+YT01QwAr4RGxwBf6ScKWalsMR6vWQ2n2q9Ltit9z0+HotL6aSBD/kKkwI7ssM2RPo/F8B9W8RUvgsVm5zOVOJfl3yjNJd4JuZ14gqTJtd0ZXkRLR79WsIf0q4QU+l22mixVbs8lgz4f97M9gEgSIabvsH615cWIU38NmeglAZWr5YLX/FJfoTHuhY/Vl5O6bX3gaiuZhHP77+OwxM71Mq4PnOktY/1VKsiP91vdOwNhEjBCs4WIWKoqTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tF15i4UA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tF15i4UA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkzH4fx5z2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:17:47 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1adbf62dd31so4336818c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701065; x=1794305865; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEyHpuH65RtgAfPnavKG94t3MsEPEX7xZ6UjOz6FFS4=;
        b=tF15i4UAISk6zU+oPM7psP3UcAYd9RcpUkVmGh1P2lAOD2Cie6GKgE1VB3BRmnCGHN
         +Xm076EhdCIKBYV/DbQGtMLUliuOCrgXNklUloJZ/lnjJkLNvpinx5lLoFAbCpVpTsqP
         wnSKZnmXewzzU3nSpzgonNFk2qjmnULqxwxr+e42QpoAq7QM9P7nHNmSZMp2VvMdNS8Y
         8k2eEJwULtr2hgPQ6pfYtoDvH9KktcCGGRty/VgfdsbqPpWMKZFpw68W0i7zwz0crsGo
         CCGTI/wmxa+E8a+TavL8OhEtmgu1B3B43XYUUg4ye3zDj6pqQ6cI7dRNxJvXOzx5iTrT
         TmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701065; x=1794305865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SEyHpuH65RtgAfPnavKG94t3MsEPEX7xZ6UjOz6FFS4=;
        b=khBk/DaYHVb4xAbb92gATId7KPMarOIHyrr2uSlUTqvYQ0UbDec/JrLbHVZ5rqcTGV
         gkbPJpixZWZa+W4TXuWlih1f/4Clg2JfeKAA7SGEd53TSZLeUwO9tgzhz8Ns1SadjeD4
         1qZ0VA8weP955cZ/sb/zObmJcDIrGzHWa9cL+HE44BoP3Rmu9tSgpn3UBpgOiYsBoTa0
         YYlKARIS0wkuDKpIm5qUI1blLUu3r4aCLTETjAqKlCaITzhC1Rs9i7jEjh4F7VSAuwwQ
         6ZCc0VGROHPRcS1JdqZjzOvwbsnMY59A84DcsYKSQQy2VyJMAOyCwn3HCiZ3MdqGrI7j
         wYag==
X-Forwarded-Encrypted: i=1; AKwUvBxl3kyNUi8BP5aq/u7uIGsRB/JKuGyzcHbE8s7L5kEwZPNOv+ZVe43/W1IqHUr5deUgZS52CcajfQW4cJo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/+kRSge8BGy8iDsd+e+wYJmH1sbKsdXmKkw6/yoKYZ+Oh84GEw
	kIjD6cWycms7/tZ7rf6+9FuXOX77DH9DEYUp1jZMhZJ1qJPYrdxTFoKx
X-Gm-Gg: AYBFou066tXoCQI2pJNVn0xrIm7RvTmruKYYIVySX+DT3a6UriMoy4LLjVVr/j3ZUCd
	xJgd0qyqggrlBgcYHJ6qFj6q46kscfkMi//9jXfono1BEsemIZicQuC0t1xq3uQNnV+UO16A8NB
	F1gSKRG99rXWkQB59ymzi/8Lh8ClHcyEe3Dy1j4YgsO42BKhCmt05nzeqeB7GEqTvhZMJ5YWvXd
	MDARMi5kmjM9liBecj2ZEc4dFZo354j03nhkgPkbzT+0sOB4aH4pbMm0AQmTQm9HcJ7chpr7rnZ
	DdSOcJzizR8d2fE00zfc8ezncPh99ng8bjRtBG3RDr7sSNcYZ91uWwFm8tpVdvALwp94qQpUh2T
	FVciLP3I8QDllClK9Cxrqb2DoT9Mvm75LYb7KL+OTfjzWwCCGRe9HW+vxLpGhc+JQmdPogtAvtx
	NkBIrnakWlF1RfYrYJYufdBp9cP8UIgGsKt6vmh0XvflAqsSPg0Qth8VWGHGSdzo/eF1fVZ1fCU
	cBu9utiUU1q5ISIsdRugeuelsghJW/VhGTPi3uXdQU9uPHnwJmgbKo3Ea+LKELoZW2cLgrpMw9i
	MJqUqosV4/eFXI+vUDUZkgBs+MHv4w==
X-Received: by 2002:a05:7022:7f13:b0:18d:5988:8d3 with SMTP id a92af1059eb24-1ad106817d8mr18115510c88.3.1793701065267;
        Tue, 03 Nov 2026 02:17:45 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:17:44 -0800 (PST)
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
Subject: [PATCH v11 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Date: Tue,  3 Nov 2026 18:16:53 +0800
Message-Id: <20261103101658.766905-6-jiangwenxiaomi@gmail.com>
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

Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
blocks, reducing both PTE setup and TLB flush iterations.

Previously the function returned a single CONT_PTE_SIZE for an aligned
range, so the caller mapped one CONT_PTE block per iteration. Now, for a
CONT_PTE_SIZE-aligned range, it returns the largest CONT_PTE-aligned size
that fits within both the remaining range and the caller's max_page_shift,
so a single vmap_pte_set_huge() call installs several CONT_PTE blocks at
once.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/include/asm/vmalloc.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 4ec1acd3c1b3..c29704a19e27 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -23,10 +23,12 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
 						unsigned long end, u64 pfn,
 						unsigned int max_page_shift)
 {
+	unsigned long size;
+
 	/*
-	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
-	 * aligned in both virtual and physical space, then we can pte-map the
-	 * block using the PTE_CONT bit for more efficient use of the TLB.
+	 * If the range is at least CONT_PTE_SIZE and naturally aligned in both
+	 * virtual and physical space, return the largest CONT_PTE-aligned size
+	 * that fits, for more efficient use of the TLB.
 	 */
 	if (max_page_shift < CONT_PTE_SHIFT)
 		return PAGE_SIZE;
@@ -40,7 +42,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
 	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
 		return PAGE_SIZE;
 
-	return CONT_PTE_SIZE;
+	size = min(end - addr, 1UL << max_page_shift);
+	size = round_down(size, CONT_PTE_SIZE);
+	return size;
 }
 
 #define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
-- 
2.34.1


