Return-Path: <linuxppc-dev+bounces-18813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25523106F2F3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:09:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhGcy5llDz2yqt;
	Thu, 26 Mar 2026 19:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774512530;
	cv=none; b=TGRqjwbKDWLy4CyFKeZuqpKzq6IfSmvWCTgZO5eOUeDlklzmG3W80DcHhT4nQaXrCvBNueVfdBeb/BgU81E7g4sen9yh9Xk7OzkOjVFhJ8IKWnZRTUCMbdTAC6yjQdfiSFTcGZi/A9eHAY5hU/Eaj3z3wBZEH7qWyT9qCsHNV7qwnwSdYVJdyajK/w/23Lqer/rpWzx4VW/5WPU0JGD+4z7jjGdh7n4CTH1IsRXWPfzA82RjKPEcEnd85CKe4BJYsBC0Mdy24wK+fWZqcGNhEtUoXPKFoReHrcbxhm1xcbpUX+1QT+yAB8rF6fKMRXOcaolhA19P9YXBLsH0mHPMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774512530; c=relaxed/relaxed;
	bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QY2v1PQQf8L5dFcaJi5BcwoJdaALG7HpPd87xfvf2ymeLbCXSRhr+EL7Xqu00F8BIlqksloLmLpKzc2Qygq+ogJ5S1lLnLfrn9hxZ9tvHghSnu030zOiotp41Kkk/o1Mz9cXYVqED5I4kFVOQLDj7TfqUpOiHzi7C85RAs49BM4Q4mZU2jBO78wOUA0QFdKBsoskKmFHfDb8lHtkXGWCI9YFXfiZ6FQ3+LXd+pQJEPmLjfsfQLYcZxfQ7A52ViEK2nUm6IhUv/9xBeCsljNGwyjMPBiTNRdO3eBSL28ciDz8JfQVsFKLwwXZjIBGNuAS3NDOpaIFJzddcw2N3+AsnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TMaugdGf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3j-neaqykdmo8a7u3rw44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TMaugdGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3j-neaqykdmo8a7u3rw44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com [IPv6:2607:f8b0:4864:20::1349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhGcy045Qz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 19:08:49 +1100 (AEDT)
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2bda35eab74so476603eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512528; x=1775117328; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=TMaugdGfh026dm89OCY8hIY783kdWy1NvUIHy1EbkrKO8uxjbKqJrV0iMj+vhuV7sW
         ycqfy1CQ1G3URzsp859WgajK7HV6VrwyZube9iUONpq5YNHEKg/DgwSbX7gEedsudGVc
         e1A9k6jVXhD95HswOYa4RW4QHgbGq6D1hd5uCLFsAb06jQT2//2R4niZrU4T3srlKg1z
         mg6wuuoL4VXVIRDFGvD86A9ROh5IOLQtHnUCcqwhOYuClUOnJmRMRi/HGhK2lxmpdQRg
         qJkkSU6N+Y+FsnonW3uEIS9s95eqmdBN8z8o4EgaoWr8SyM2G9b7ZYcWYKWYoyUkcchn
         yLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512528; x=1775117328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=OeK6vXCIIpQYxbVPawYkieSegn1URG1TkzFpq6pQ8AhjyywZbMfXmBQKhHFrcyc9Uy
         EvEZa9QrZpRUJz9xGGYoxZ/MFivhKHae0SN8iIHx0G8MwWz/he55U+4c5MWTxUCqvDKu
         o9prH2/quXeyRXH/EZ7WhTg055BtjRkFrynNTWci2BZGd1tQ3jPmcVhXaWpPFL7fJx3C
         bjJfSCUT60Lq9WtfWsu4cCQ+JrdINQYtGvDnQ6zeEdQAPAZXail54zn5T45XhQ5R59QC
         jiGcDquJU/KzQG2fOF4QE3qJRse8p4eEtb1/QR2Oed0ZbrJqwgKzoR1bYvqeD7KdfYyb
         5Q/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWjmICg7zXPbPGuXCEP5pNANd1bVJh9Q4nXJ5lecEvup8F1Y2KjIm9385bZByBwqf+EiBqg63M7BDV66w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YznFzhi80QGtGXou9MZQplhiycCjkrlkCbdEaup8RGRSwFeLbee
	WLXRS2nQ03Ja6AFI3J5XthDRFm2D5r8kfG7JEa6gUyuAYG4tN1zJAzsioC+XDWFfT6C0AurYKwl
	dWRSMFA==
X-Received: from dybvq8.prod.google.com ([2002:a05:7301:77c8:b0:2c1:da8:eab3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:724c:b0:2ba:6f16:10cf
 with SMTP id 5a478bee46e88-2c17726234cmr295020eec.14.1774512527594; Thu, 26
 Mar 2026 01:08:47 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:33 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
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
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-4-surenb@google.com>
Subject: [PATCH v5 3/6] mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
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


