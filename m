Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 03:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC5B64E3D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 03:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC5B64E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVnt00lg6zDxVL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 14:56:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::730;
 helo=mail-qk1-x730.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=H21XDKE7; dkim-atps=neutral
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVKWB37JhzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 20:38:27 +1100 (AEDT)
Received: by mail-qk1-x730.google.com with SMTP id a12so19155445qkh.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2021 01:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yg8qLn6EBRblBdGN89hb4qppVjdAkF53EYMnS584DQ8=;
 b=H21XDKE7kj6eviodyCfNiCshUr6Jl60NQwPGMYhq3Avfd4XS+uk55A2YxdbbFgzxui
 sL8c36XDslXNHh7ezBTjvKUKd/rdbrP+XeDnJg6BSONj3kFyiCP1BqqYjWZAKovb0L8Y
 VVt1+afdyxEhdTLjPf8UGL4I9rbDHEOd3EZ7QGqenX6ehu++KcdY5csfm9S7lrnOb58a
 dpBsBnPgWchQ74AWLHFheE2/fIvkkTxgiw7oZC13UwRhs4brUZAiP9M5nql3/PFP+2lb
 wuCfUTiV13Qxcd4YZ24kag/2/Qsm8J2h8kO7GpPaLrUelbs1buIpIbq0Wa/szKLNdIxd
 qenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yg8qLn6EBRblBdGN89hb4qppVjdAkF53EYMnS584DQ8=;
 b=dVpQWZpjRGodGU4+MvuOLPAnPc9IusHc9fDgqKu4C9mn8ftI3Hpo/nGSD3bQ/0k3E0
 KIk0l3+C4//X1unmaNgUKjjFbo3Q37t6oG1R1qfZUP5d6gIQDmaCBQoIMwBqXuYKr4hU
 nqQtjSOfcF+wC6FvrAV21rFu1xp7x/wf/pgzuTazR73CFRlUK/abeUMLh8whzZzIQ+2M
 Gcu/WHK/MJUNe7uiNzV6mziRthyYUqjSe+e4/gkIQjd8434fEo9hYVQL+rsoJqBp6CHC
 kmkAWo4AFy0uYylHDgbGrhgPB3UhJktgrVHH+D3UtzZ8lHKwDd35DuBUKlcw/1ww2tHj
 x8GA==
X-Gm-Message-State: AOAM531rnsNNEY145drSmoT7NBR3asHOrNs0XjNbarUcFQhn5+es3weG
 FLqLCrJkJVzoRdckM899Ap8=
X-Google-Smtp-Source: ABdhPJxq86fkMmfu4iLXPxDRIKQK7ZUhUum7zoVW/6IbluNr5HO7IxuObUF0GYjcobviYxjSr/GGlQ==
X-Received: by 2002:a05:620a:132a:: with SMTP id
 p10mr20466699qkj.124.1612258703039; 
 Tue, 02 Feb 2021 01:38:23 -0800 (PST)
Received: from localhost.localdomain ([156.146.58.43])
 by smtp.gmail.com with ESMTPSA id z5sm16608357qkc.61.2021.02.02.01.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 01:38:22 -0800 (PST)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 akpm@linux-foundation.org, rppt@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] arch: powerpc: kernel: Fix the spelling mismach to mismatch
 in head.44x.S
Date: Tue,  2 Feb 2021 15:07:46 +0530
Message-Id: <20210202093746.5198-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Feb 2021 14:55:03 +1100
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
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


s/mismach/mismatch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/head_44x.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 8e36718f3167..813fa305c33b 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -376,7 +376,7 @@ interrupt_base:
 	/* Load the next available TLB index */
 	lwz	r13,tlb_44x_index@l(r10)

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Increment, rollover, and store TLB index */
 	addi	r13,r13,1
@@ -471,7 +471,7 @@ interrupt_base:
 	/* Load the next available TLB index */
 	lwz	r13,tlb_44x_index@l(r10)

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Increment, rollover, and store TLB index */
 	addi	r13,r13,1
--
2.26.2

