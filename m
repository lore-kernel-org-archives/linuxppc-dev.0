Return-Path: <linuxppc-dev+bounces-18552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ED5FC72AD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 05:43:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdlZt6cVBz2yWy;
	Sun, 22 Mar 2026 16:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774158198;
	cv=none; b=kF+VQ0mPM4vuj/0jffrLFyf6KaHAw+qf+kYm1UpjarA9K1f7jJftHBju8fBVquAW2ZofnivOAZ88AdtwmT40A4IGVlF1WdVtVQ+Ici/OH+rC2rin1ar1wcormg+bpEy4o53oTxAU2xmovfnVJDhRnwwxb6XRKrNa20/BLvJLeGEREvM0gb5mIFStYTOWKPf6M8vtKPleQZltJ88AGXroi5+WycWQA6tJrcorlF8KUgvswbNYZMEVw6AJnY3b3Ni+FycGKUrs0E8SC8uuCVX6NV6MKGjDY208cWU+0sazwJijlgeT18JoSKnIiGp7mIX+W61kuY9Y3CBK7mirUAUbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774158198; c=relaxed/relaxed;
	bh=NCLfYASgT0jKid/tJ2FF95GlZkyQeWGLzgzFGOQGNX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxzOaiqr7qImcdNalGx/Pz0251zXdVCxLkoUH5vipN5y12RYBXEGgnzJRHT/E2BzPkfY60fXyEdYLm9sYEQJWepnXPeRJUhczLuj+aWwHPdxtXHd8oscF7D+X/VdEoMhIwJ6VJfr1zd9G3Y9hLUXl2qs+qE+S9XrbeoMobjRagXFjnVaYNVtTXXkc0JQCOaMyBtDg476fbFqw6W7m/f62q0U4AepbzGuVg+xc4HpPPijzlRrXA22J31wpA2GIGeb3V8pXkdkxmtaV/KwCIroTWdFSO47E//w6uclKyKfh/gFI9RtTVjy1srEH44cKUBmkYRyhzoY0GxqDCHdzaPeLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=njUTAWdu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3cog_aqykdmc574r0ot11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=njUTAWdu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3cog_aqykdmc574r0ot11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdlZs5Tzqz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 16:43:17 +1100 (AEDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82a6c70f1f8so2500195b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158195; x=1774762995; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCLfYASgT0jKid/tJ2FF95GlZkyQeWGLzgzFGOQGNX4=;
        b=njUTAWdugmll6vq1IJ3IWAD6L2+5o0fHi3eOWbzX1X9P/IAiPArW0eC5h/XPZalO8R
         Ur7k5+KR8/l2iRhWvcCxFlL8BbXyJ6aTCzwwDvAG3dOJddBvP+02r9578/Km9ri0B1wC
         o8noLeQjznRkZE3ejX2ItJyFF00x/PkqyB4G349vhU/N/URDkz58AZZWhs4J0t5PHBa1
         3bOR5eXATkmCRSNjsYll0Xj+IaKAeuwju0bqfVQHwe6OpRXdUoDXMtb+kScnq/2y8idw
         mLDS+WHuGRtNXWhRb+r+3Fz4tSRNN+GpgveMJFfsypxFA5cLzYYPOxqbzMaR2f2kWNp7
         lLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158195; x=1774762995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCLfYASgT0jKid/tJ2FF95GlZkyQeWGLzgzFGOQGNX4=;
        b=lV5IoILKOVQwt8aKEuBKS6Zwvw/NzMN9KFGT+TP0+d016k0yHhKcvuAT540/esZsxr
         d0PvNqdNUY7zXKOvbIGXWhWEpPF10RTrmaaa63gbWo/N9Vjo5MIs+21JWDSuED8Y7rac
         OjsdKZ9rmB63hLg+CeQ+m0GoviftqpX0psPOmAzRKqqEEbZ9AfWrq/mSnLswePVV0sYf
         FhJ/zVGxT+ccU9JaaUYLtKFv04iftwlFAAJjNNTKGiiKpXK3rrzFSfmOH43qiSIGklCj
         NH4mnUxiqWaoL5VHs45U4LVnNO6YIAR50FowRqIWhq7uKQo/4EPo7lPnW75cJK3RHmnY
         ZsDA==
X-Forwarded-Encrypted: i=1; AJvYcCXupH4wI9MEMR+YOnqMfTvgO2l3kQ450X05RCg9NFG/38HSG1hIovwY4+JWggptqLud3jr+/0EtD00JgLI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyeie1c8ekMjChuqV96WYVUwA3Lnz6wVdvJ1WDLX2MKe5+SVkU0
	S4EStv8k6x6WlyZJkaXlUKpN1GomJuEgE2ETVoarca266Z2ga9ZLTrRXtYp6C4hr/8VOb/zIm/x
	cb9KiFA==
X-Received: from pfbfb12.prod.google.com ([2002:a05:6a00:2d8c:b0:829:769a:a81])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4191:b0:829:809e:8977
 with SMTP id d2e1a72fcca58-82a8c346979mr6884137b3a.49.1774158194950; Sat, 21
 Mar 2026 22:43:14 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:05 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
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
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-2-surenb@google.com>
Subject: [PATCH v4 1/4] mm/vma: cleanup error handling path in vma_expand()
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


