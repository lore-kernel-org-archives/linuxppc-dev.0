Return-Path: <linuxppc-dev+bounces-29686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6731CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:09:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7V8l4Przz2yhP;
	Mon, 19 Oct 2026 20:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792400935;
	cv=none; b=FePmX/MBZE0lqQs9raoEjm/cssvQl6wSahsnnZmVU9rW8+VUT0feCH/NYK3eZ3XWdgTR1YcE1cvq8YPCJPH+mjvQOiPofh8N6iLh6JiP5onA2h7faKw9SRyaHRfYgIp4NGQO49xeQcmJWLYi63j+HKWwq+B14LC6fpqwPKzWpk7ILL5pzAJ34j8bXICRwGW3uzsWJEyo2X4Pw+dTXS8LwYNvg4kjk9FombMXGgeJ8fMmyyjHurXrRJh7UlNWUpAYiVxKepTIwK5GJRA1OC0M1gF6DApd1e0w18Xy/ryYCKW+KIN+m7bKP7LgiS4ofJ6sqhUFCeblqkLj/NCLSTkLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792400935; c=relaxed/relaxed;
	bh=PvZO54TWJTuQkZMeWHo+KL3t3yCuPUOF5hA+fz0b8nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgZAuFbP06dKfOaDqk4WXGJ0NNizONNXRHzEF9v0ErrOyurG1+Rr2C2nv57grqc6SKAdkfDpsj64q0/jDfEqTIXaftqrtQ31DwZdOJzdsPLuj5jhreQpXmgdeRf5cbqbPsuBVkNAE0VPEedwdtAzRxlky7zFTMaFDKLgtTwFimeMpjxXOnuIpRrLxM6sLbVg88drHbyxkGa/slo4JOXhb0PuaVn5p3t0TPNriW5WERAnnHSKscgdHgDPZTnxGvFj0+NxJ534m1L7QI7LTVr86YwxUV91TFv9aKsj3pwlPA4RA1xJ9zXj9A3WlPOnYrvAxdu3LTbTyhy9jw0F8DTGdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hxtDdGIv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hxtDdGIv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7V8k3Njdz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:08:54 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e942864693so8337015ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792400932; x=1793005732; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvZO54TWJTuQkZMeWHo+KL3t3yCuPUOF5hA+fz0b8nk=;
        b=hxtDdGIv8h1tpI2aDk/iZxnTjxk6fZYJJ8RkQsdXo95V98M9IjILsjiS+7/FxnDk+A
         X7DKl7T/6a6cWlHGMl91/5H8z1xnhp0nW5Vr9kSA3ZPOkQGB+1LuiYzTGjG8i2nXr1gy
         Al4WlM8vjBH82Bnop9iB1x7y64KHt8vqFLLtbkKQI3D87ttku8cM+o06BGjuUJG/oAcR
         r8lNzZ2fDic1j/XQAtcVTU4XuYRcEwGhvw9exOZopmna0C3iSrzl/ztguRKvq0tpe4BY
         EI50RakXWYcG05saHOF7wvjC3f5G8iz0stVzZVMyGSMIK1iY+/Vko+SjZRqh/OQstD8n
         n1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400932; x=1793005732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvZO54TWJTuQkZMeWHo+KL3t3yCuPUOF5hA+fz0b8nk=;
        b=S4Q2WUCWyh/hhEDU4bDxHjozNh56QM3/NkQVR7Xtd0C+8lojx9bmJsnbvn5FGKmHHe
         evKajZ4jSb3JMpgkhFEWoqEDuzBKp+Vn81ihn5Gcl/FBiH6nyJz50xvLbQCliPw/mNMD
         j1o8IEznGuxIywvqh6DsjYiDook72fvYMDT2bEOWa/9dXIMJxyLgb9N0XZTjRrpqXGwY
         IOji8dR1CyqBr7Xqb5edFE60h+F2e7+ghMLAo16+jzjTX8KcqRX1Xg4vemaIz+52ysPT
         gM/8Ent5FOhO9Pw1tAExadNVi+Ms+daBVYMq/96rrHjVPlDeYDsfvxTVg78WnR//R5x5
         DIXg==
X-Forwarded-Encrypted: i=1; AKwUvBxeMYrYQ7+B00Ta9kL2Dt2v/1BdyVXU2ps+izK23iLHNmeNbMMFYzBfK3z4knHVKb5FzHyBTOCYZfBeWVE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ2LHmZ/yVrLxTTIqL7xYbVvwuTJT2V4hw6fltRrabMkge+kFij
	YDMfODg4l4cluWFvECsjr2JjaVncFpjNyyejXHqv6LLjFzjPuUOfYfmvFi6k35kW7Do=
X-Gm-Gg: AYBFou2ArgmqB4v8/YaAr3yqLI/nIHFuCZIFvPxat9cLNeVRlOrNK1+GbsM0TQ7Qo2J
	peG3OUDGN4qxLGjs3ufz4EqbuW6Xmh+y5NYoVgfmLJeSlv5zj9czgGta+qqZo5g/mdcQ71xC3Ex
	HYd5wbMgW8yJITJdXGHblAagzWMHE+qyQdUT5vQkss//4J16a5GWLiBWg7RHra4W+HqGRxTi64v
	YmlQMFgwrRcqm53bUIVR41jEN+Gs58q0UQDl/kOGzb1wxqjCcq7f4tIWzbXzok0N8J3INW67ziC
	tZW906aiCHNGHw/ZnkZ4Guo1j0TfCfrvvq/jObev+FhvV8bCXCTwEh7S/mj9rhrrCoJaHswBLdt
	lMifRLP0xV5V/JDU4/pfLdIa9AfRzuVvxhL4tK1qO0glqTrEcmtEvyvTfn5nhwCjuAi/axFwMGF
	s0gO9OHA5b/Yyoa14/levsm33lInqKUdtW7XSPUJS+nMn0iKFQLfMupfibNzvUuG/XvkqhOKRj6
	StjJ7ArVrzlS+9oZdtt
X-Received: by 2002:a17:902:e5cc:b0:2e9:4e83:1961 with SMTP id d9443c01a7336-2e9a6a0283dmr60030985ad.22.1792400932347;
        Mon, 19 Oct 2026 02:08:52 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e305f1dsm36707595ad.0.2026.10.19.02.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:08:51 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/4] powerpc/mm: map shared vmemmap tail pages as read-only
Date: Mon, 19 Oct 2026 17:08:28 +0800
Message-ID: <20261019090830.1917657-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019090830.1917657-1-songmuchun@bytedance.com>
References: <20261019090830.1917657-1-songmuchun@bytedance.com>
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

PowerPC radix uses an architecture-specific vmemmap population path for
shared tail mappings, so it does not inherit the read-only protection added
to the common path.

Protect these mappings as well so illegal writes fault instead of
corrupting metadata shared by multiple tail pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 44868b62b14e..ebac5f9058f6 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1059,6 +1059,9 @@ static pte_t * __meminit radix__vmemmap_pte_populate(pmd_t *pmdp, unsigned long
 
 		VM_BUG_ON(!PAGE_ALIGNED(addr));
 		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
+		/* Map the shared tail page as read-only to catch illegal writes. */
+		if (reuse)
+			entry = pte_wrprotect(entry);
 		set_pte_at(&init_mm, addr, pte, entry);
 		asm volatile("ptesync": : :"memory");
 	}
-- 
2.54.0


