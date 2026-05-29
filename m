Return-Path: <linuxppc-dev+bounces-21739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F44CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:04:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmms5nRNz3c6f;
	Sat, 30 May 2026 01:02:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066957;
	cv=none; b=lykubnwLTplSPC2tkobNzuIQRkHQr9TPpCQfdO02zCT9l/iQ6AJcFIB8Y3+ZS9nbBk8LxbaQhcgl/TCClYITEOiAkabXjiXhNEOojNiy652Uvd/Hish7tYN2lJ1MPp/gAbAHe1XWwBEzeFhCWhhsywgPM3/yUEp3zdLP3QI/087QQpbf2QWFaAUdpoworvHL71zSCwXr6fRg8CU9Lukq6x7wRm3MewAYG9JFnx+sfNrRg1RBuzLmh4QDVNy1+bxYwlnxW0gmXbvNDgKW31yT7hINaBwlBozhehzjIPe/wcpEijSdznK8n17oYnmV8mUMjB9Q0zvwT6jOfFYoNKoSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066957; c=relaxed/relaxed;
	bh=kuldBekegH9n0W4LLX2RtMOFJe4Z/6YrXjIgxtYQaL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0HR+tRP43EEIiGj9AqmkFxw42cPAjDEI0MUly+9SKvWMYba1xKycf9h1f96FbQTN/Pi7MxhXCFSNwR5mZ0Rfs1dPnSWvP3u5BVFM6Z5nF7wqiTiIePUaUjgSkdmW1Yegr6DEAneReIfxd0d5DX0ey610lFd193/vOIIMLh6R5rnUfod6kjon/GmC3lMgXbKPRm9eYAuJj1MEru/ygjw0U7ebDUn2mzxucOVMuz+WC8/IoRUnNKXEfDIrUf76379jE7CS+aHoxR2VG/NjulXoP4nngPyK1agZDvEgJR2lyLMIfGK+c1ehMqEscYleyFP0Brnsybc899QcmDj9QFCXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I2grgjtL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3iaozaggkdjw6n97+cepckkcha.8kihejqtll8-9arheopo.kvh67o.knc@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I2grgjtL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3iaozaggkdjw6n97+cepckkcha.8kihejqtll8-9arheopo.kvh67o.knc@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmr5mM1z3c57
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:36 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso81471235e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066954; x=1780671754; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuldBekegH9n0W4LLX2RtMOFJe4Z/6YrXjIgxtYQaL8=;
        b=I2grgjtL53wlpVXeNmYBp8Vkr6qSAN6SIeiVKbeVkkDW86rSuUISnZNYdnu3fLAOGn
         v+UOsun3aLrpMKgDBNXvldwkylxAeevibVil77hjGtd5ilOO9dWE2Q0MMN9meYHmJhLy
         QMKiUTWAAMpxHNQrK5im7NsMBijSOlTwGRlMumLOxYM5Rma2o/aP9QeMG7JCQ8RqWHE+
         QZZ6cP3Dlw550RD8MruIG9Dam3uNAFhFLJMPErN1yaPe1O/JZzXtccTWtLwRberNBAiP
         j7QqsQqq8H/Hs+8Pj+YWWDrV99m6MyJgMCWnfMQiICNa3fOP2iCBYPybE97BriSxwMkZ
         OVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066954; x=1780671754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuldBekegH9n0W4LLX2RtMOFJe4Z/6YrXjIgxtYQaL8=;
        b=R5YBYYgm+Pvn2M4deSG9uUa+ZbyOV0+0tuZCE0gYVYP3kDPO5hHHoaBb+H4lYDnefb
         F7JvapQhFr3o4Iq888dZjPGqHgab/80yXdY8IiXP99GD1V66iAIMKCkSHhOay3Zp5Tv/
         NMpF36Oqc+PVbDK+gd0Fn5/YAGVC2Js/Mo4/Q+YuEkWL7i4wnhtNAZgUMHxwjERMnJ57
         GzlHjYH6ZN8s2/PJRecLh4nFSAJHk26SRsk17MCRzQSmAgF5n6e4fMhHmp80VIEjjO+B
         PnQ3FRcMIkCwN9dwnRgCVylvRvkrs8pF4mUmKeAca8yVprMYlwvVYjBOLfaJrzqPc+b4
         oceQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5E2ViGDO18b9p99+tTD0QbteTxrXvi3LbsLzvvnQPj2aTnB63pR1xTjfRp++dkVxP6Quh+efbLzSH9qE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsdezsMH3MJ3rtF5dCXxjy2ozwwwqVNBeaz3kK+OQfSJbfpLJd
	2B8k6ncRSff0pDsdeeEmdDg4B8ggO8JDQxLUR0L/VdxP+9Eg+ePsaWi4Ckrm2sgVF8v2uVTRGQ=
	=
X-Received: from wmbds9.prod.google.com ([2002:a05:600c:6289:b0:488:c686:2b56])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3552:b0:490:58f4:ba23
 with SMTP id 5b1f17b1804b1-4909c0ea669mr54166795e9.30.1780066953743; Fri, 29
 May 2026 08:02:33 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:04 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
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
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=dIgftrvtjy9n7J++AHRmcZhewFAl9rYaD0F4euqeHS8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVd47S5EVE1yUzEILxG4o87+S6v8hxD9hp5NyQ8ruu
 0eqhL90lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkcVGP4X3vEZYrpXP0XPhoq
 LB8n7Xn7w1MyccZGAxbjdtX1WbwLNjL89511yu9VgsV9/ZkbXeb/7X59yD7RKOaQzExH3lUBFrd CeQA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-30-ardb+git@google.com>
Subject: [PATCH v7 13/15] mm: Make empty_zero_page[] const
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Feng Tang <feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The empty zero page is used to back any kernel or user space mapping
that is supposed to remain cleared, and so the page itself is never
supposed to be modified.

So mark it as const, which moves it into .rodata rather than .bss: on
most architectures, this ensures that both the kernel's mapping of it
and any aliases that are accessible via the kernel direct (linear) map
are mapped read-only, and cannot be used (inadvertently or maliciously)
to corrupt the contents of the zero page.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pgtable.h | 2 +-
 mm/mm_init.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a..67aa23814010 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1993,7 +1993,7 @@ static inline unsigned long zero_pfn(unsigned long addr)
 	return zero_page_pfn;
 }
 
-extern uint8_t empty_zero_page[PAGE_SIZE];
+extern const uint8_t empty_zero_page[PAGE_SIZE];
 extern struct page *__zero_page;
 
 static inline struct page *_zero_page(unsigned long addr)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..46cf001238c5 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);
 
 #ifndef __HAVE_COLOR_ZERO_PAGE
-uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
+const uint8_t empty_zero_page[PAGE_SIZE] __aligned(PAGE_SIZE);
 EXPORT_SYMBOL(empty_zero_page);
 
 struct page *__zero_page __ro_after_init;
-- 
2.54.0.823.g6e5bcc1fc9-goog


