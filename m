Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8981C5ACBA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:18:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EEE20866
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm0YzlJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EEE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZG9B2W9XzF3XB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:18:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nm0YzlJB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nm0YzlJB"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG3Z3hstzDqfW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:14:02 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 23-v6so10839215pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=og3nps762l1wehgPrVvLZ4tOt6tgHDhsP/lk8/fPWl8=;
 b=Nm0YzlJBr/tFpHAsamNBQRtcflUZ1a3Fhs7jRJoXnpFPig4gbEgKXSD8GJg5pTuCzZ
 flZP8osFYXA9rcYPLY1PyxKzJemBVuQjRz30z6FwFB4TaoUDz2o5xuG/CMsPKZ2UFyqs
 RZ+GE2BV0OhCu0HksSYWPZDL+bdF8YLGRJ14FGakPYH/sq2hk0gVDXssBQ1yLJUjEr7Q
 Xs9PwkS8+UAIHo28AreMJSU7LdlhogWZ2UT0D0x7OwKMjaCFxzh/mt7sv551VBgwuR39
 L/QfwPOstPLfmSkiEpLRxyhfsrZnq5zTvdQQsfeW8zv5Cuo1DGQSTzvpgO2MSayvrNPU
 O72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=og3nps762l1wehgPrVvLZ4tOt6tgHDhsP/lk8/fPWl8=;
 b=slgCsPaxKcfLQaPQF+EkcMXwUwi1bartMkb4B09xqi8tbNt39kCJudEblEFJbUZbEh
 xqoBzupJ7IlAfGp87/2sUd4dHlh1FbuubkA7E4IQ21JU/NqHlM/9nzJhCkFlVv+Q83wq
 gEFFAqYSXc3F+c1qgjq3RL7w4RCt+Lz2gss177G8NUkETk+Kf7/CoENXavyaDYTJM49j
 gBICLoW/vBDyRXC2vMfcz2ujCWmgcl7erjSAqm4Ue5Tc5EDg2yz42RSNCdt8tybyGpvv
 zmycvH2OuSk2+bKgThZR0CJVyq7mnHCc3cCLdJPOsLTUoNj3qnEIjNMibQpCjHxvX9Es
 o67w==
X-Gm-Message-State: ABuFfohQeKz0grxN1yZIUJEg2UCqoWSqKaGL4O4+qyTn+Rm60ahgOZjK
 9hY/+rjpP9mQTkDv+mu3TKW83r9e
X-Google-Smtp-Source: ACcGV633qW2OBNPwm3Of34MQ0PiCfw8SZWKbv1d8VPnZh7InlVEXQra/DC+Bn4ZaPxLg1AladyddzA==
X-Received: by 2002:a63:4f20:: with SMTP id
 d32-v6mr18957422pgb.231.1539695640808; 
 Tue, 16 Oct 2018 06:14:00 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.13.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 06:14:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/5] nios2: update_mmu_cache clear the old entry from the
 TLB
Date: Tue, 16 Oct 2018 23:13:39 +1000
Message-Id: <20181016131343.20556-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm <linux-mm@kvack.org>,
 Ley Foon Tan <ley.foon.tan@intel.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fault paths like do_read_fault will install a Linux pte with the young
bit clear. The CPU will fault again because the TLB has not been
updated, this time a valid pte exists so handle_pte_fault will just
set the young bit with ptep_set_access_flags, which flushes the TLB.

The TLB is flushed so the next attempt will go to the fast TLB handler
which loads the TLB with the new Linux pte. The access then proceeds.

This design is fragile to depend on the young bit being clear after
the initial Linux fault. A proposed core mm change to immediately set
the young bit upon such a fault, results in ptep_set_access_flags not
flushing the TLB because it finds no change to the pte. The spurious
fault fix path only flushes the TLB if the access was a store. If it
was a load, then this results in an infinite loop of page faults.

This change adds a TLB flush in update_mmu_cache, which removes that
TLB entry upon the first fault. This will cause the fast TLB handler
to load the new pte and avoid the Linux page fault entirely.

Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nios2/mm/cacheflush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 506f6e1c86d5..d58e7e80dc0d 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -204,6 +204,8 @@ void update_mmu_cache(struct vm_area_struct *vma,
 	struct page *page;
 	struct address_space *mapping;
 
+	flush_tlb_page(vma, address);
+
 	if (!pfn_valid(pfn))
 		return;
 
-- 
2.18.0

