Return-Path: <linuxppc-dev+bounces-28730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD14CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30N4ZGtz3bs5;
	Fri, 02 Oct 2026 19:10:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932228;
	cv=none; b=RU6KQrdRzsltJZfhslKtGJbEQbRaOp/eSvxWuU1A/W0G3vsmbZMa4MlF/lDyjpx7HeSZiJ+l+3SFaLdNHo8QsoZ5HhyGTAmdvAvOiyjq/TbNq9xP9RyGGhwW5eeArILFStIFDYdPot9fQdgkQZCuNMlmasE1taJoydxtIJc/fcTYgZkIDFmZj102pK/rW6GFTnu0idZKsJ48hI3gBy0mbho2tZx0+oUuu59ATBepFBoniVlIYOkT3bewrLAnPrJVQ7lIU4qyDyxGQsTc9eX1I4SlZW2C0XbJat77OzbIlZ+eDOKL/pgspy86BF2SWRYAXgiK3IWGAhV1jWKb1zOttw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932228; c=relaxed/relaxed;
	bh=K+brmQ4g6fgo5Njbplw2vRXkj0/5uqGmn7J2kABfLu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rk/6Eega21QgfrnWZPbOaFIOlfmQlbGcL0DvedBrfFzDrlVX/WZwVA4oiEjSKR1JqbuM9Piu/8yw4JxYpsK+z8PjW12BilPbA1Gh+3G7Y6bYFVJbWu2QiKlzcZME7BHUqU5kzPq1MAf8V9wic1iwJ99Pz8o4GJbXuFv6bd/IIBNkUF3kxRz5hS/z2sp1uUGvIwXdx48SFId2qjI/SJouyf6r002LwFFa3Aj6ETEwF9lljsLDh9wcZ0BE9nNwLo9RGKOOqpJIIhUI3orHP/HW3ivmMKfxKgZKdAI6a7Z6/bz3LBzIW1x0dL1UVIUm1EIA/4CM31OLK/5PEwvvJ2E9Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c18I59rM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c18I59rM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30M65Mfz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:27 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d8fb334e72so30998945ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932226; x=1791537026; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+brmQ4g6fgo5Njbplw2vRXkj0/5uqGmn7J2kABfLu4=;
        b=c18I59rMz1WXEv92zeRNhvL57qa992pgqtIQOfwKaCY+YrfS9rp+N5KqwAtmJ4I5N4
         WoYk7KhT3BaGIhFu7Wi5mh1k6weWhUR4D75Zi/7eD8n6Gj2BexBOSL1AzT4p8TmytUgT
         3e8QwFATOVCFME4snjrJKXGsB1RAvO8NYMIQgGC6kNDCclakkdcjGIAQS0j0WfYsRrpK
         1zWyc8U1GP+s4B0ZxisLy+rIe4ma6T1wtxqsaFFc6fLphGRY1a4rk5smuxWyGFAZ5+2z
         L5XtPNrMN+HaxlVHAoP9qronL+KOBES5IPyGKUj5p2HeB4+RhijCUGvdoLVvsSkhBv5y
         g8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932226; x=1791537026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+brmQ4g6fgo5Njbplw2vRXkj0/5uqGmn7J2kABfLu4=;
        b=uGZgrgJn5IdZLXlRPvdTeBsDa6373u8MUKLROyf65aWvwYcRTurXdoMsSFDlk8YVmx
         NtJWbi+hEJk36LXDAXaFm41eP9Xyr9HGqkzw+Tgg6JUGVCQy9NHkeVR7ntlOFBI7Dmd/
         cjNUYwSqDGdVlYDZbzTwOCpcFYkfVJLL6W9+2WM/aNLWVlbpI17yV+yqRwd214d1fvIE
         Qxpa9hyNRnjzRswQmgxZltNAhgB+NBOVwC+2cUtrRWMhQ+ejWi3lfYIwUC99L8+ZqtrJ
         jCkq+YSOh3SXGlw9sD+IiAixWfAQbx7vvbnlgkttF42pJXGbVSxP9GPcJR2mzf5eI6eF
         6jcQ==
X-Forwarded-Encrypted: i=1; AKwUvBywT8tL58Gah5u8nktEpfm0t4vrHHJ73FN5rlMlYc4pTnTxO/4u0z2iwc2I5fWjzjImBsQ0aSvAbCDwxeI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKBBDfzlLvA3VPaZufm7y3gOuJ6+hSCCf7XeEHQ3wwqs5bQPJAq
	762eiQloXdf4qS7CyDazjcZrtIRXRctL8CROBcwwLcDzHzdvAY9mCezj
X-Gm-Gg: AYBFou0bFD7G/TDnovyd0VI/KKXSIsRbvFQZ/u/2M4MvxWUEseqWP1BtISRoEmGM2R/
	sPj3yndi/Er5ACbEb4ueadFLeaLnI22asIES57XgD27sX7W8hiG2YK2G4e9FYEDQoREQtIn+T1c
	iUaoIZRQhNiJiVX+z71Z+aMcdq4dHOspFmvdY5hbFw+6jG1rYlHv5AAMQf3L45CH7yuEOjwngzI
	4WMxJBQT/ggb3+K/qy0wmxY1vB9Rydp3gBNssMb5GxpVUSIMeqzIOgVfy2J/VYHRYU0ZlGCwMz/
	0sYXcFT+MRYbnF15zZPbU6obN1AyCXUgBn+iZtwk31r70EXbhv7xY8ihzSXlkC64p6/g0wmkut4
	XrDmmjYy4uc+7qtnqfH7Us1P4XOwl1Ze2Hrliuz1GX0DbySHnccDaD6JSA9FXER5N1t1WLL/Qlv
	5R1ixToW2XATy56SED1qi3FB0e/wf9Cbtg6KgfVEcUc1nqRdZsMS3khNnAZ60xKf2BT6tK9Y/uR
	Qz5EonvwC4kIGG1Z3ptpg==
X-Received: by 2002:a17:903:228e:b0:2dd:c100:7cb6 with SMTP id d9443c01a7336-2e49b6b662dmr16609685ad.50.1790932225869;
        Fri, 02 Oct 2026 02:10:25 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:25 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
X-Google-Original-From: Wen Jiang <jiangwen6@xiaomi.com>
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
	ryan.roberts@arm.com
Subject: [PATCH v10 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Date: Fri,  2 Oct 2026 17:09:42 +0800
Message-Id: <20261002090947.869220-6-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002090947.869220-1-jiangwen6@xiaomi.com>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
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

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
blocks, reducing both PTE setup and TLB flush iterations.

Previously the function returned a single CONT_PTE_SIZE for an aligned
range, so the caller mapped one CONT_PTE block per iteration. Now, for a
CONT_PTE_SIZE-aligned range, it returns the largest CONT_PTE-aligned size
that fits within both the remaining range and the caller's max_page_shift,
so a single pte_set_huge() call installs several CONT_PTE blocks at once.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
---
 arch/arm64/include/asm/vmalloc.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 4ec1acd3c1b34..c29704a19e276 100644
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


