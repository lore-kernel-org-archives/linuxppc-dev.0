Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F400606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mE/KCOK1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkz95hNYz2xXB;
	Tue, 03 Nov 2026 21:17:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701061;
	cv=none; b=jC1vmakSJaeyf9n5Sm7rEVsMiPaD8Nr3Jy1eQEqqt0wmpHJkvhMudLiAhpfwfIFio3snZ27oJvyYi7kcz7WB/tHKIgHAeYMn4KAMq0lPvs0DHEju8f60TnispP/WwJwx+k47WkwIIePmDNDnsudNnUR+5yndMUAb3QvC0c+pUMGeausEgwj6jGXzVpC+pzhbGXrtRJaOJAmv1k+zMBs8Svn+o85ArTnhYlNzI7qLspDISF/zPlnJx8LBXaMZJmdLtea68ER/GfLC/O01vrURIDtAiwBU3MbA0tUZOR+G5X/7WVzfCFNu/TRoS+gHbMnPpXJ2oUe5+zWNnaHRXnpemw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701061; c=relaxed/relaxed;
	bh=LyGJat/C8ooo5bLDM+7UJK/pGeUEXPhrPklQUuKrBbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWh5/UBRDLmFt5fr1olLiQyCmjZpsb3bHpqKYFpPs/NxiqZuHQP5k6m1aWZCkwd48IO0IWqmPbjXiX2+CSZdnWD2BDPGxC0YAZrgDB9LaaBzeaCCnbTlXB9yEBDRxfznhl6jf1PTPfuMpPIyjIPEUSN+Wor66e01x9w3JOql/bcEw32HOFep9Hu44VMIli3W6SviQdKTuNiADeyr2ati0lgNQHw/DYFuuwVfFLSVhh9yKfGSYEEHg/h/sIXHdVjELyrHKMWG0YZ7qj1308ztZNnol3tpgzsd/zxiDTyuHXmwjO1fOyj1MYmkaLxcS5NqykBYE8Aba1VTZn1eXbcQrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mE/KCOK1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mE/KCOK1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkz86SWpz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:17:40 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so7479528eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701058; x=1794305858; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyGJat/C8ooo5bLDM+7UJK/pGeUEXPhrPklQUuKrBbo=;
        b=mE/KCOK1gmcJrdwca3PCANKqqOnpBW98Kd8su9KydVqm9A7OeyEG0b91fpTRk5e5X0
         Z9WXM1DeE9yArT7d/ULTsKt+7eJhvKLDWtJkEaVkVKlb+lb7BpwZFGa1UVRM4YA6QOD0
         ozZRsAveU+o9smDWR2FM6y4mjh7t0EVnGadcoD/LX06EW/bupKmJPni+0lOOYvB4amJ8
         SVgGSU/x1DT/eLhQkDOb+mTN5xoBfkpr0vu+Xi8Swl1e7mPP4faJCHUFA+9G7jh1QpkQ
         r/9E/Z9pRgc/cveIPPmGi9LHie6LTz8hedAsIMZUYL3PdHpUBQGJ3zEAd5JtSixPZaZo
         fGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701058; x=1794305858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LyGJat/C8ooo5bLDM+7UJK/pGeUEXPhrPklQUuKrBbo=;
        b=dpx0BdvcIsWi7JM8hS4JJIkej/DR7NdE/jA95z4B0iSEASZAEQKwijLczg5WTzt73i
         FSE8vpzLw1V9bUI40z5G3L8yCvycLEAxNKoQHUEEKDXo71KK2/2vrwONDHYheCeSaWIv
         DwY4CtYhYqP+9OfXMn2ac0zcpXtL4hBjw0rq4jlqv+KtPW42n0Za7ccmRCChDg55CSEb
         3ZPLHP9EHhKEh8U9DxVVKqqtqjt/5hBnYnoYVjPuAv60e6XyEvSY4q9KxaGY3N3irX09
         LX3KxLH9E8c2H+aBX7L0LS1SDnqXVZ8t8/fl+uCqvOkEiDNGpbiVpbr19FqJf6saxH3x
         Lvkg==
X-Forwarded-Encrypted: i=1; AKwUvByTV0lCpQWQw6oPYmttVHlCZSjjChHNWoNv6EQdf708yuuA9ON32XFj4X6giTO8/Zc29m6U73Evpa0r7U0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8BcON5BKP4dkx74yihv9KpSUm16KdYVNsb/lCAe9BYoZFnYXSy
	kkyd0YwRs4SWX1WA7XuaIfwvx7gCEb0vL6FpK7jpdzRb7hT3DCc5OA8j
X-Gm-Gg: AYBFou2Hxj/KM6RxuKPRRD6BGDxsGNHqGLme7OfEztQCjqEZF0EQxIrRPhx1RZldNrZ
	AchWVQ/3LaUHMDGaPXtJ7lUd6LkMTVx/+Yb9z8dzs5ijPF+9PmVvWQNNvI0ari4Te9rlU+FUOgH
	zPoZ66I7N1M6/NfpE8m2Uzh8kb6YvGz21ubhNBxjbyY2O467i0JD2cDC46vszj4LjM6sNrUci6i
	5KEYOPrc963hFjt7iptfB5NF4MWOVTliOisdX2sXR+vAb5+hxd8yQIPNSbQfdqVS0067/FHKjgz
	kLMcPxUk4/TITjCQBTqBY86Qi8OVxjUmYvvHaHKmQFzM7kdfkp0Cvk5xqde9fZ5GrAPlSv8ULmq
	aT3D9pbp4r3UCa97peQ1ODu0LPJXWb0mvQCph+xb5QTYENbUESD/6xvz9nge96o27rK5jH/iN8W
	jDuhm6Yk6+SK8HByEcHSfXdMxaxNgwceP+yLu0i8cvi+ooDNWcrPISjoz1yhd/nNJZQvLTxohQH
	v4HKGHtb605S4h/WBRokmW6SDym1TNf4eVcTx5oADnE1jO2IaHl3DfKDzbJGkXZ5Sg6tw/7/cko
	Ftl6igfiQjhdDMss5oXiMR9Te7pGRg==
X-Received: by 2002:a05:693c:638c:10b0:369:d8e1:7bb6 with SMTP id 5a478bee46e88-36a423c2ef8mr19548958eec.25.1793701058355;
        Tue, 03 Nov 2026 02:17:38 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:17:37 -0800 (PST)
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
	ryan.roberts@arm.com
Subject: [PATCH v11 04/10] arm64/hugetlb: drop the init_mm special case in clear_flush()
Date: Tue,  3 Nov 2026 18:16:52 +0800
Message-Id: <20261103101658.766905-5-jiangwenxiaomi@gmail.com>
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

From: Wen Jiang <jiangwen6@xiaomi.com>

clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).

Now that vmap uses vmap_pte_set_huge()/vmap_pte_clear_huge(),
mm/vmalloc.c is no longer a caller of set_huge_pte_at() on arm64. The
only remaining callers passing &init_mm are in arch/powerpc, which uses
its own implementation. Remove the dead branch.

No functional change.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 8e799c1fe0aa..ce247b06fe03 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -206,10 +206,7 @@ static void clear_flush(struct mm_struct *mm,
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
 
-	if (mm == &init_mm)
-		flush_tlb_kernel_range(saddr, addr);
-	else
-		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
+	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.34.1


