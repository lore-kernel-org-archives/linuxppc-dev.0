Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75DC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 08:40:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98040206F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtLngfp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98040206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wkWb1vPGzDqS8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 18:40:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rtLngfp4; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wjsS0lwBzDqs6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 18:10:52 +1000 (AEST)
Received: by mail-pj1-x1042.google.com with SMTP id ng8so6169997pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=L20juKjF7+78xrE6tOwEZab6/V5ugIysDtHDa2XCWRo=;
 b=rtLngfp4v13WGbGO+2qLJl3DRmpeFwAkcVD4YO/5vIy+B7UWQEaLex8ah/zchxCuAn
 GdKuyzTHzgHjIb9SyRqcG30sBQVAczU1mwEPgJjMhpkcwk/bfIh8dlaLHY8EPGzXFVVI
 lXMokjVTMLK0QdODnADJe84IZQ8eqcwWO6V3nRodl0FIzHfysg3CvuDWd/gEYEeE68As
 FhEPaoDajREsttMp1ZrflEtuIUwbRIDxJlZJeL2t5IFlTpKn/4uIbpsC5GO+JR0uKlOF
 mQs3HVb31dAFKegSsBg3K/FQXUGZ3JkQAQSEjDR5ribZwFsHa840KZ2fE7ttOJfKtF2y
 9v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L20juKjF7+78xrE6tOwEZab6/V5ugIysDtHDa2XCWRo=;
 b=VkcDWSdenOntE0tFU1gXw06p7PEvjwJ9byvSnU8Goiii2GHIsytJ9B19o24Gmm1a61
 zZXyFaM1KLXqZ8QnK9sl2M9wLB9dxkR2p2fy8F4tD8mXToCF3xdhRWPb8fbuxoMnMNj5
 2QALYQ8JkVnzlcur01mTwQlWubPeCoy46jyRS7TRbty68owYLM45/CML/PkUXSxm1AGe
 yEc2f0YbkuqMI3f318pY/HPsSzYuovAszxKZGzaVOk0CAkWAzF248lmGGZ6OpXjOYgTe
 8zEixlhRD1Joud/HppNIPeMBipLK/Lb+f+k+vUCUtTs24P/tTrHNeSlrOk2q0BWrVwiO
 qCmg==
X-Gm-Message-State: AGi0PuZU4r/CTESu+jWvDZz3NeNhl/l7fT5+V/SY3Cxjca2KKtd/lxw9
 MdmOqrRzxF7wvQZpc1a/ZJyxLdIK/Hw=
X-Google-Smtp-Source: APiQypIhcERZaj8WtDrj3j5XUlvh21+TzKHLoziOwSA+cLK4U1aUpqeCuvllWRlHhvwe0SJLPdQ/dw==
X-Received: by 2002:a17:902:7204:: with SMTP id
 ba4mr19550939plb.232.1586160649916; 
 Mon, 06 Apr 2020 01:10:49 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id m2sm11460406pjk.4.2020.04.06.01.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 01:10:49 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 15/21] powerpc: Make test_translate_branch() independent of
 instruction length
Date: Mon,  6 Apr 2020 18:09:30 +1000
Message-Id: <20200406080936.7180-16-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406080936.7180-1-jniethe5@gmail.com>
References: <20200406080936.7180-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

test_translate_branch() uses two pointers to instructions within a
buffer, p and q, to test patch_branch(). The pointer arithmetic done on
them assumes a size of 4. This will not work if the instruction length
changes. Instead do the arithmetic relative to the void * to the buffer.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v4: New to series
---
 arch/powerpc/lib/code-patching.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index ba08f3815d00..c329ad657302 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -569,7 +569,7 @@ static void __init test_branch_bform(void)
 static void __init test_translate_branch(void)
 {
 	unsigned long addr;
-	struct ppc_inst *p, *q;
+	void *p, *q;
 	struct ppc_inst instr;
 	void *buf;
 
@@ -583,7 +583,7 @@ static void __init test_translate_branch(void)
 	addr = (unsigned long)p;
 	patch_branch(p, addr, 0);
 	check(instr_is_branch_to_addr(p, addr));
-	q = p + 1;
+	q = p + 4;
 	translate_branch(&instr, q, p);
 	patch_instruction(q, instr);
 	check(instr_is_branch_to_addr(q, addr));
@@ -639,7 +639,7 @@ static void __init test_translate_branch(void)
 	create_cond_branch(&instr, p, addr, 0);
 	patch_instruction(p, instr);
 	check(instr_is_branch_to_addr(p, addr));
-	q = p + 1;
+	q = buf + 4;
 	translate_branch(&instr, q, p);
 	patch_instruction(q, instr);
 	check(instr_is_branch_to_addr(q, addr));
-- 
2.17.1

