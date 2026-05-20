Return-Path: <linuxppc-dev+bounces-21236-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794BBCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 12:13:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL9Rx0yRKz2xqv;
	Wed, 20 May 2026 22:13:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779262500;
	cv=none; b=Lqy6yAZyncAvIuhi25hoCiqmRKoQHm/SbDzXwN+n7D+drkQnrCFj4JBJQ4+WdWoY/5DYOP0YHbGES1vZ3Y6DZ0fbelFLgl7skqqktGXdt/GfZE248ukqp1R2acx6/mzzm+etkEsehyA88BIkOXP9tAy2cU2LKoFPLKp5MLtTkfSPy3hx6Esv7UjZyScpXYsT+hQaQtMUr+bnvFyuA9Zl4J6SuvM6/s2dt+IBBO9RWBm2qqrun9Dh5DIR+KXvh26KYKSXpvEAivJQsECtJsA4YKhzUSmMou35K4cGnBgPpeZNjUcPtaVcRUOkhX8s3kmHYLZ+MKEiSfwiRU7eB86eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779262500; c=relaxed/relaxed;
	bh=TBfrHUM4K+Fvnf6VLbbC+7tqRoLbh8+kTigJR63RjPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KQv5icNW6OdnL7RAPzWiZ6ihXX2edQqhPg+hd3PAHml7lf4bfDqoNo6LXulf6BmEGwpdkPQRlP+T/2Ne5Rv7rOsXicF+2fBvKSkzHjxOtspmAWi+KEZZmT2hyUhHOaJW5bPjp31/p8a4Zx5pDzxfOnEPEngrCVdvSUU8eAEIm6CjYU15/oQukYsa4/8F7t7f/FauPyN9YgBOgOFS+4tcrb0IotBQVEzGS/SQxbjYFer627FeA585LOQfzjVSKcBma9mwHXmIK8JIZ2IhUddfsY0pM2aosASwgwx7MmBf+YIX6qWexysJLrDYmpsA/aFcxdyrVJPXlrofz1pNmzBrWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fdlECA2t; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3hmqnaggkdhmrius+xzkxffxcv.tfdczeloggt-uvmczjkj.fqcrsj.fix@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fdlECA2t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3hmqnaggkdhmrius+xzkxffxcv.tfdczeloggt-uvmczjkj.fqcrsj.fix@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL3GV4w1rz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 17:34:58 +1000 (AEST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so3707539f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779262495; x=1779867295; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBfrHUM4K+Fvnf6VLbbC+7tqRoLbh8+kTigJR63RjPw=;
        b=fdlECA2tSxA4XJYcSx4Ct4MZCDn0fAiHdk+8TGUeaAQTXzUeR6sNRJXQfto/tiIKib
         T/5szE2T94x4OL44Is2w5e3qSVq4y7YOv0bCfbqyFjZ7V5mdDtsKJCoZpNBYoQqzZ48t
         yJHGHFQcidwdzw8b9/A7wUA38d2rbenMJU7k5f3E7dHMXWit8tB3bCcC+/x/fiDlUY4F
         Ke6jBCRIcm8XiAmzQhYx+O7PN6Dx37tiMdcwHFASp1IkixSiSqRE0ucF4kqVYIwxw7ws
         5Qh92vV55t82OJVSJnYbYBixbAVmA6C8gtRFWzwU7eBf5JBeUIRRJbp+OvWuE1GuAMXt
         zniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262495; x=1779867295;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBfrHUM4K+Fvnf6VLbbC+7tqRoLbh8+kTigJR63RjPw=;
        b=Eq8CglIXSNntDUm11BcOLDFZFg8ZaBN2L+V0bhiBl3s6lHJfch9Z87HPINhdkLW4TK
         V8rznCCyd2jbNuYbPJJCbwo93h0Tk1FBGIS7+NqPzOlEp5BCsOOerZQBJgjFEFbMhuv8
         r7ztbQL3X5dhYRXsI2VrFJ6+gbAiCzQhg1myXGNl7poysxwNyTL6rEaPjFtvUwYD+ruk
         U6P0UayVy0C7iYdUuJYMmQwEXw0SIQRaEJobbzS5swhzeHi0NTGlyDEAtW880RWkynoT
         /BPGp71jcfMyeCnUTBWTSkmubBWDd3/Epl8s3LHEU+wk53YtIFZvGVQMi0gB/oHR4DJp
         UVLg==
X-Gm-Message-State: AOJu0YwfULeCO8yPriuNJpbUCMEK3Mk7W0t7F4yAQ/O7HKUJqY1xg7wB
	RFUF+ig9EWI8am7puPFmmzZe2aSwECuMBMcJbTiY4se62AkVPLnUIWQ/sor9msWbQYKAk8KqQw=
	=
X-Received: from wmxb16-n2.prod.google.com ([2002:a05:600d:8450:20b0:488:e192:6fb1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8210:b0:48a:5c23:cab
 with SMTP id 5b1f17b1804b1-48fe6322447mr327485535e9.19.1779262494439; Wed, 20
 May 2026 00:34:54 -0700 (PDT)
Date: Wed, 20 May 2026 09:34:40 +0200
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
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=ardb@kernel.org;
 h=from:subject; bh=oY6gtKVWNTBx6UhZYZ8J5F7bWJKDdqkgNGPUoOyRHTg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYs3RWD7P9O9sip+nxa8t3i22u1c9+ypXxduWjaj6mv8v
 Ad5y6codpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJhBox/M94/XbBEb45a0sm
 T0iw2eXcuyKvVOt/YIzwzZp7x18VHdrC8E/zmjyPpZ+xlEKMw/TfJ/4sXjvrUTTvgvztfF9NHeL uS7ECAA==
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520073439.3279874-2-ardb+git@google.com>
Subject: [PATCH] powerpc/code-patching: Avoid r/w mapping of the zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining use of map_patch_area() is mapping the zero page, and
immediately unmapping it again so that the intermediate page table
levels are all guaranteed to be populated.

The use of the zero page here is completely arbitrary, and not harmful
per se, but currently, it creates a writable mapping, and does so in a
manner that requires that the empty_zero_page[] symbol is not
const-qualified.

Given that this is about to change, and that map_patch_area() now never
maps anything other than the zero page, let's simplify the code and
- take the PA of empty_zero_page directly
- create a read-only temporary mapping.

This allows empty_zero_page[] to be repainted as const u8[] in a
subsequent patch, without making substantial changes to this code
patching logic.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Build tested only (Clang)

 arch/powerpc/lib/code-patching.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f84e0337cc02..13a8acf851f1 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -60,7 +60,7 @@ struct patch_context {
 
 static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
 
-static int map_patch_area(void *addr, unsigned long text_poke_addr);
+static int map_patch_area(unsigned long text_poke_addr);
 static void unmap_patch_area(unsigned long addr);
 
 static bool mm_patch_enabled(void)
@@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
 
 	// Map/unmap the area to ensure all page tables are pre-allocated
 	addr = (unsigned long)area->addr;
-	err = map_patch_area(empty_zero_page, addr);
+	err = map_patch_area(addr);
 	if (err)
 		return err;
 
@@ -236,11 +236,10 @@ static unsigned long get_patch_pfn(void *addr)
 /*
  * This can be called for kernel text or a module.
  */
-static int map_patch_area(void *addr, unsigned long text_poke_addr)
+static int map_patch_area(unsigned long text_poke_addr)
 {
-	unsigned long pfn = get_patch_pfn(addr);
-
-	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
+	return map_kernel_page(text_poke_addr, __pa_symbol(empty_zero_page),
+			       PAGE_KERNEL_RO);
 }
 
 static void unmap_patch_area(unsigned long addr)
-- 
2.54.0.631.ge1b05301d1-goog


