Return-Path: <linuxppc-dev+bounces-18939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648AC10F286F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 20:55:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCZg6d20z2ygK;
	Sat, 28 Mar 2026 07:55:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1249"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774644907;
	cv=none; b=GuEo69JA9EnYPRouRl5LS7U8q4Y4L/tfbpW241xB1Waek+niSm8wmpY8gGGOxyx8ZhpBkrfR0WxubCuIMO50mBsGh31MyI5kOp7QRouT1TI0CbRFjseF37bdWZkY27B5ZF93rGj2mKPJKsWoztTQsx6LuNzvjx5WncolfnkZCVKXwQWHFV7cYoWlqz8LaEOyRPX69nDMngqEQvZIY+EAX13/DzxwujVZiSnDzpYlGrFRFhns9tj/2Qv2fSN+V5CQWKikII0Clwmg/YAJYMzj6DGduREmUaulD6JNaAgh8mDYzJV5BpxvrPvd8hHdtW09MxYuyxQ84LGoiRVNZhs7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774644907; c=relaxed/relaxed;
	bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NVj9rJ6CJ8rkpDoS2H92osmacLsaagZnyj4w0zLa1Pz3VbJNOnKafMxBAtoUdkjyVRHzuePHRFgBJvV0NJic/89spFAhQrQFhZw9cc9dABZF0Ay3ysHjuClEaO2O0hCA/jdNRcfm8eo/2AS/YehMp413tXKJKPZy2vHr63va4pdzC69Ei5KuwJ76XF2biiFZ3JlVZt/iFJHHMSSihd1+0M38A+cjA34H3JMyxIFLOu21X0tNd/Fi8AskTpJDQ3ioHAc5pkdv0rBuAJs26QN3HJoex9DbHwcAYkq5XGjgiWn70ZllNey0P6VIYoP5cXUB+pbscO18H2lBo76rO1yL5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ek+zmIqB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3p-7gaqykdpqoqnajxckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ek+zmIqB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3p-7gaqykdpqoqnajxckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1249.google.com (mail-dl1-x1249.google.com [IPv6:2607:f8b0:4864:20::1249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCZf6vk2z2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 07:55:06 +1100 (AEDT)
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-12711ec96fbso1768264c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644904; x=1775249704; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=Ek+zmIqB76rjtlq/SF9JGgnsObvFLjRc0kr1GBudcLYsCVOaFUKHvgdGfXz7u49714
         v0NiNb1uIi58mEpD/VO5rda8JjXNl5qd4JkxFBng85Z5ZR0tjn7Lyh9NRMJtyk+zRLcS
         b0ADcU7e7y3esu5SHA5GM++68jbZIJVsUQzp4DUcDYmvJuuNi3GCjY918+PBlPctYVIW
         2Oi9GeVwEZvWTQFDDBBqcLonv//bLskY8xz1MvSd9iuKccxeXVwbrL/L1NyN2VPc7rkr
         uD8vxfNx/d74LT5u337mXtRvjBqBCn+7d4rbhbQ5an964xyPfp9uQ8IbAMULohRz/Xh9
         Zy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644904; x=1775249704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=FbgIGhtMOZWIlDi4omgZuO8p8WmE7uFEShkhYtvkc1t/XQHLaFEHQQDnk8P4XBo53j
         rNHtJui/CBEdEoVJngi2jKvxdiPSNS10vfjO18IDfdK59+wevE4tTRoOdlQqWkkN62fj
         nMsgb37ghca9yEZQGLQiaQlajc7zJbIFD8XcQRFcPyS6aGU0Qi7bgBh5TTTaBVbRq07T
         c1QuNxsdttmb++0kgMJ+3EParsyBRzVANK1dbtUdXly3227YCc8FYKuAoIjWiAgTETLs
         cK6p6IHsw/tU+4XauORSsd0bfPIDSOTKoDd4fq9O/VyTVn/jQajESkX5QIsr1AIboNSY
         zwFA==
X-Forwarded-Encrypted: i=1; AJvYcCUgo8jbV+go/QDZeX7IxKC25QZH+3nIUXIj6CPRASVpBpZbj3LTvd9IjIjIEbfyRWq1JQgMYyUv+6Xf6kE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKFKG+QM74SkEGMqf8neMd6j5Htdw2aFFKC/mrh+oweKrUrPms
	6WkBuHeftmIqe9Fz1mAV/g3DPoyGwALiH6PNidUN4gFSbgN2ktiolWVp3G5xpb9lQ53Zi9Q4HAW
	6wnMMwg==
X-Received: from dlbsj11.prod.google.com ([2002:a05:7022:f90b:b0:128:dfaf:10ac])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e982:b0:119:e569:f277
 with SMTP id a92af1059eb24-12ab28f2848mr2382854c88.32.1774644903670; Fri, 27
 Mar 2026 13:55:03 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:52 -0700
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
Message-ID: <20260327205457.604224-2-surenb@google.com>
Subject: [PATCH v6 1/6] mm/vma: cleanup error handling path in vma_expand()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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


