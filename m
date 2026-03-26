Return-Path: <linuxppc-dev+bounces-18810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10478106F2F3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhGcw12fVz2yS4;
	Thu, 26 Mar 2026 19:08:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::134a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774512528;
	cv=none; b=hQ0GrFRgdIy6luwLCm+O/oqjSHImJugP5UXKkbrWzIO/EISQFPZJtnmutN1JQj337RYfE448EQwO+qHFY7Gk+wvjTZEZBaHGnX3KcBJsOcMY+57z6X94aB4zfB+FiYScQkO4/Y48yVqjJ8NN8kisxKH/ljeuxX4dM36SKgXEzOjB+skDE98M9m+MgMx1zUNmUknjAJ0aYgVDCCgGC7E3oAlkW56RZCMEfNXocXSnx4XM6bORscth9ZZkzZy50lMyLONzTJwrTPO/IbOlCmx64fpRVpUz41WS/KBDK+v9eMIp4zcBIaw9QKBOTBwq83qGZ1SxbKVn8Drege9gIUek/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774512528; c=relaxed/relaxed;
	bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P8XbcG5Qp9gaaGxqOgezKoxRh9s4dFB9RpxNUl5Jvd9w2/fy8iD8ezVipefHbXCNtTIM7kJOmdFQWISJyxzbdJZXHVArMrEputD62Kv8DKUHqyB0/wlzPyxzvUfeUcd9IHT+p9K/WcXCbXqy3KuRyz38i/mS9tbx/AEK/CwQBPmi85N/iWD5pRVjW1hGvhqfGf6vfPOPUJzqwp14bt6GZ1yGf+4H6uPCtAs7Jvyk42ku/em2aAxbfevDhHpkcHOUZt7FAamPWaT5iN5plicFya5DBjaqHkFrfDU0nL5kAzuKN9Ya6F9m3so31JfgnBiO8bgUcsAolHMOizXtA6w6wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cL8DD0xq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::134a; helo=mail-dy1-x134a.google.com; envelope-from=3i-neaqykdmy463qzns00sxq.o0yxuz6911o-pq7xu454.0bxmn4.03s@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cL8DD0xq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::134a; helo=mail-dy1-x134a.google.com; envelope-from=3i-neaqykdmy463qzns00sxq.o0yxuz6911o-pq7xu454.0bxmn4.03s@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x134a.google.com (mail-dy1-x134a.google.com [IPv6:2607:f8b0:4864:20::134a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhGct1q3Gz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 19:08:45 +1100 (AEDT)
Received: by mail-dy1-x134a.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso609693eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512524; x=1775117324; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=cL8DD0xqjczRdEaOmlmDXtLPtnlBVdJO2+Z8hbwFD9Z+ZomCBjV8hvUsHM0fXhzif6
         K8C+Z9hJLg5+3SQXJ+l7IgDLyYWubfbDQnx1wquj/4Go7tsoZiTCT4EI8ZBb3C97M8q7
         80vYZP7Zg+9dl64eKh4diAhBPBJ6wikhAK3AQfeevHEvunA9MMdKCxxrLuOChejbjDcL
         yb25pWSyEljYQgGqBNQTEysTmvOQ17PyX7r1pmNTPk2PmoB/6GhPwU4NNXz9axUWio07
         i/7nP4OhTew3vlP+9Jd+oPu1P555NfUkOf5su2fi4OdLnwE8DEN5jEXxAB2SqY4dy6Gb
         yuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512524; x=1775117324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=qWyGCNMk+JvI0BeAkF/SF0hnK0QIm6yz+fhKfhZOiSqDw4AUmG3+dYXhofYl3nYQTe
         UqcTlYGa9Ik2G+Rp53i7EJ5bg28AceAKs0KOAdJUlBo6Pi31IOnB83wrAcuMWoj8WFeF
         IKnB60vInvjbZjnlsuC3+iXBaNThyEMTM/5gve1mljwyVNjVyaGLuGZP/mo3drX2tpaE
         1E9GBtGnxd71JZ8LgmO6EJV4HcPyuW+z8Ma8Te3thwFOt7xFX5Hr5X9WPuk6VLo2N4VG
         7FQne7K+IDzhR7lIoa13x25LvgdK0NeC8J2WYOF7iqU0CgEo4lUD9dLvg7L+SRmUDtU2
         VyZg==
X-Forwarded-Encrypted: i=1; AJvYcCWxrMv7dsTcIp1v5RqmkoHx68F6/nmYXAseTfXfpD8/MFzA5uXcuJ3RmrsnULwihMZO9NO5DlHQ/oHoJPg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxT+bDV2qnapwphXn4ORFuSEHIKcfKYgr4Zbg44gGXR2zsTa+nP
	l0A/NK+0w1z29JYqRPeQMiAqaaj732CqkOTPMMh3qMG182jPvQo0mw2COg/rlyjyy1cJmlgm+PT
	WyuyRVw==
X-Received: from dykg12.prod.google.com ([2002:a05:7300:578c:b0:2c0:da3c:9f74])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2c0:f424:b545
 with SMTP id 5a478bee46e88-2c15d350374mr3760721eec.15.1774512523474; Thu, 26
 Mar 2026 01:08:43 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:31 -0700
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
Message-ID: <20260326080836.695207-2-surenb@google.com>
Subject: [PATCH v5 1/6] mm/vma: cleanup error handling path in vma_expand()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.
Change variable name for storing the error code from "ret" to "err".

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 mm/vma.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a43f3c5d4b3d..ba78ab1f397a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1170,7 +1170,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vma_flags_t sticky_flags =
 		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
 	vma_flags_t target_sticky;
-	int ret = 0;
+	int err = 0;
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
@@ -1200,12 +1200,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
-		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
-		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+	if (remove_next) {
+		err = dup_anon_vma(target, next, &anon_dup);
+		if (err)
+			return err;
+	}
+	if (vmg->copied_from) {
+		err = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+		if (err)
+			return err;
+	}
 
 	if (remove_next) {
 		vma_flags_t next_sticky;
-- 
2.53.0.1018.g2bb0e51243-goog


