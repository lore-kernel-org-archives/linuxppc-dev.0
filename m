Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C005C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:38:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971B064E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971B064E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzMZk16Rdz3cK8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 14:38:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=n4tbZ1hU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::833;
 helo=mail-qt1-x833.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=n4tbZ1hU; dkim-atps=neutral
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzMZD00Qyz30Mw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 14:37:53 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id 73so8230354qtg.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jsNszPZXedsfKo/NVYJH3mt7sz+6/7d3/2iK40T3H3E=;
 b=n4tbZ1hUmWc0FvQk9jHWHSZnJpStEDGWoPWQPelBX1kOfx+uHJaj3r7K2yC32VdJCN
 +dpp6Ef513EBFnSnjoRVA5/YaMVJV5BSfSPtf7j0h6x5D0WAhNNriiQYHOuRBzigD4ye
 fA0rd9g9ix6q5F+g6DfbF5lgFFexSs+L53W+4wSCP5hKap8BhKsztS4QRFQX7q4WqfpE
 q05wEA15tNQ0HtBd9+S6BvMJnUxAhfWbv6ENOnbe9WbZzODXHyHjGjXoP1saOr2kn4KP
 NnjTA9aFxVOqNYOgN2+c3ZGv96z0X681GnvfWvKxwLBqtZzmWPjezuM0275tnupLcuwF
 h+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jsNszPZXedsfKo/NVYJH3mt7sz+6/7d3/2iK40T3H3E=;
 b=W3dIR3Pyw5nslIkzhSZ2gHcyC02t4yHbi/PDON5Zv84dO/UM5S80ekC/x59tImZJFE
 JNKjwU8az8Ofa0N673y32vGYiTA9/I9+jS2N2nSnCpTCvF05a6YJ2/mwiXCgDPt7WFas
 rE8GReEY4dalS9CMFRtTW7HaHW/FvucBRYpl1hBkOIPX9hwYQD++lXjniUWZANSCoZzH
 6JCF9FVzFw7KmnevgVtgcF7RrYKzVkUTxj53qlV8JSl2mGUWpms2sjRnS0Ojbl5fIIwx
 BuGC2YIbaWpOOfCbbAFk5QqkSx/gcV4FX5Dr/m9A50n9ZC9KZUpMGVPO9OVr2K6EzLNh
 DIIw==
X-Gm-Message-State: AOAM5328Lq24LmWUydwpORnIYfH1IfkevCt5tQP+YpfOO7pcVl5wqvMH
 GYe3W031tNpBJl64VAfmUp0=
X-Google-Smtp-Source: ABdhPJzpYoy1WskwOMaatABheKu2F3MpLTCwIufz8o/2TUz+wcty9ZMoQUTgwT2g6edB7+o3vLy76Q==
X-Received: by 2002:a05:622a:193:: with SMTP id
 s19mr21275482qtw.366.1615779469848; 
 Sun, 14 Mar 2021 20:37:49 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.217])
 by smtp.gmail.com with ESMTPSA id d70sm11906310qkg.30.2021.03.14.20.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 20:37:49 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 rppt@kernel.org, akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
 oss@buserror.net, npiggin@gmail.com, unixbhaskar@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the file
 head_fsl_booke.S
Date: Mon, 15 Mar 2021 09:07:32 +0530
Message-Id: <20210315033732.4173500-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: rdunlap@infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

s/virutal/virtual/
s/mismach/mismatch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 As Randy pointed out I was changing the predefined macro name,so, reverted
 or leave it alone.
 Michael,sorry to run down a cold weave in your spine with my stupdity,this is
 okay.

 arch/powerpc/kernel/head_fsl_booke.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 3f4a40cccef5..a955403247f1 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -113,7 +113,7 @@ _ENTRY(_start);

 1:
 	/*
-	 * We have the runtime (virutal) address of our base.
+	 * We have the runtime (virtual) address of our base.
 	 * We calculate our shift of offset from a 64M page.
 	 * We could map the 64M page we belong to at PAGE_OFFSET and
 	 * get going from there.
@@ -497,7 +497,7 @@ END_BTB_FLUSH_SECTION
 #endif
 #endif

-	bne	2f			/* Bail if permission/valid mismach */
+	bne	2f			/* Bail if permission/valid mismatch */

 	/* Jump to common tlb load */
 	b	finish_tlb_load
@@ -592,7 +592,7 @@ END_BTB_FLUSH_SECTION
 #endif
 #endif

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Jump to common TLB load point */
 	b	finish_tlb_load
--
2.30.2

