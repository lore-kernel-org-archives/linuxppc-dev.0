Return-Path: <linuxppc-dev+bounces-18941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B581110F2865
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 20:55:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCZl1wlkz2yjV;
	Sat, 28 Mar 2026 07:55:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::124a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774644911;
	cv=none; b=GVQFNeptc9OMPox3vRX5ZYNRp3tDapEsO2YVijiikmoUO216VJ6MEgJSEQYSM/cLzKFStCie3ZK6GgNRv+XowPf56vAEReX6XIhc9emStqt48Eg3V8fA5yLTJhi3j+BAH4ryp5mRgIxHrHBXivMfF+IIvU4gdtaAd3UdA5T+L4nfKnI7qyPvJxMZJs9UGabcBqbAnUq+NUsAlHFm9AGFUF/IJReMfmzJbgGs7LAVtWM+8/zeaBEtF3aoBur6EdtRZ74n0C8Kfhn18p2n7KnDYVCs4FNUZSouVTw5jEOEPxcL6jdUkXMhMdTHueEJDapqmbj1/3vCq6TjuDzx6Tz9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774644911; c=relaxed/relaxed;
	bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AuaHIm5/DSBA6zxUkHU/5wKRbNuJzSnXGdDO2CHYGw0p6a984q8+NjxLUvuTqSvnpTt/ew5Lgjkr2AEUKswtCnpL5n5InYoySSCVYKaezJjWcvb2xX4f9msmEXEk8ccKxc1HvqGhmSiux831BWbbqnNhp2gCOKeD33lbUas7istEx3rEy9hmDNNWl0n9DLvlZv22++EOmu0XWHYqfcRce7Zes1SBpAhKHJqQUe9iQ7CE9xstJLtJNwEKZNU6Y9Yiwmm+3+jftKJoDuz34ZatXA9KiIXxC2cMQDeM3TY9CwgtlZ2GojM7B5+Zjq+ONWxnjbHJwINel5Ma+ytKrF90Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=M2DSWmqj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::124a; helo=mail-dl1-x124a.google.com; envelope-from=3ro7gaqykdpktvsfochpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=M2DSWmqj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::124a; helo=mail-dl1-x124a.google.com; envelope-from=3ro7gaqykdpktvsfochpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x124a.google.com (mail-dl1-x124a.google.com [IPv6:2607:f8b0:4864:20::124a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCZk3wY5z2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 07:55:10 +1100 (AEDT)
Received: by mail-dl1-x124a.google.com with SMTP id a92af1059eb24-1273dfdaf5dso1689825c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644908; x=1775249708; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=M2DSWmqj9ebI/r2UAVHds9PC536DiFjKnV/imZ3/9PKzOZ9q6E4jNYdDgjw48pVGG+
         bFW1qm9Q4PIeOrsdIvm1UNZbBAY6sEO9qCKmSCjj59dLhCPjNSVYBe1ICsR5X3nYTmd5
         rgM20U8pijqmR3aQOA0eROGQP/XPxjjQV5yiDW1qybBAR1ow+eOB9I9MPVyQhKvmqMyc
         /IJ1eS9RXis1LpGzGh7sV9QnnMotW/kiOsQXKSShLfcbuve3dLz7t2qzVeVjhY1khnAM
         BTbsjapFZFGD4uBUxW9U+BDYodLL6nRXVYJWTW8b5cwpd0OnYOVHlC7hdEyfngND4uw2
         IH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644908; x=1775249708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=fI10+dZzaoJKvb87Fq1LL7cP2AHONF/2eqbUiF/Ii6BrABs3nSDbrYlneW7RWbg3wH
         zHAZ/pqB1B7SlUOCy+UnC1id9XjUoIR0b8h+j1b9qn79LnOPwmYXxXaXuZpP3LRzh8JD
         muaUZEnbi+XNblXK17A6J3pxN7g2fLxSEGUWV3CJTatHUnVZ+2kr5O4G/IYSkopIK2zh
         r0MtyhnUfEF78w5MoE3lTw7o/x9P0ipZRvJVXerev4ZR79GEo+lWRmOAlQsBRHV/YgfL
         Zp3aKCS+8yc7Fv340QC3spdxzQlZnEG+xTimiPtBDCyRkzJ44gh7ev9lvLQ0/J+b6teP
         ujng==
X-Forwarded-Encrypted: i=1; AJvYcCWsGWiPeAjFTMA7LxPRgHs4LRCIEceIPZDWGBQTGl5qRl0uhOSW8wYxDGGpEDBR1TdO8ehPhO2XfS/IGtA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIDK6ik7tVVBf4XBd/6Ly61JTeMTvIPwnIzvU5soBD6R7yP4pW
	/apOgQbFFcbfEhEF/qUg+Bjfa3Wr7Q4T7/cbySvCnowknuY6rd5nhHFElsQd9Iwp3KEcI4yi9be
	gChecfA==
X-Received: from dyz2.prod.google.com ([2002:a05:693c:4082:b0:2c1:2155:75eb])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6981:b0:12a:80f2:89a4
 with SMTP id a92af1059eb24-12aabb97edamr3324672c88.10.1774644908020; Fri, 27
 Mar 2026 13:55:08 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:54 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
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
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-4-surenb@google.com>
Subject: [PATCH v6 3/6] mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() in collapse_huge_page().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/khugepaged.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d06d84219e1b..a1825a4dec8b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1166,7 +1166,10 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma)) {
+		result = SCAN_FAIL;
+		goto out_up_write;
+	}
 	result = check_pmd_still_valid(mm, address, pmd);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
-- 
2.53.0.1018.g2bb0e51243-goog


