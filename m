Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:02:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3A22075C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMgmYD2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3A22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KN6422h9zDqM1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 07:02:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMgmYD2M"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KN4Q672QzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 07:00:38 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id t124so498776wma.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCHDAob2L2Ty8cKpbvR0K56/ZQonIWJzTExy3tCtNQ0=;
 b=AMgmYD2M3KR8ZZlQiXI7NIS7Yub8S3tYNOIB4za9vqTL5u2+yWf1Bm7SdmxgcypTht
 ECzhMQ6/9UTfsr1bnzOLHIfiu0x3HOjhIphrshRIRNZ2MJvO1TQisCW1nx2HoIzUuPSM
 leX+AFydh2ekX3phK+rKfxA089LC5ZTRrDlcGYHeooPKrmLHZR5i27hnaVDhDgEt9Eu3
 4Wua+KkCz6qKmm9QnaBEKNGAFfUha7sg4swxfbQgh0jTJzm+lW28sRIbk3588M/umLq/
 Jer+etUFn8NwfKN01+wCxcRTAHvRqN0OVdms+PkD51jkropRa8NfVJanbFrSjwAr64dw
 yEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GCHDAob2L2Ty8cKpbvR0K56/ZQonIWJzTExy3tCtNQ0=;
 b=BJB+m1tVSYSPV/l1KOu6mKWRB3XSLZA7i44OQRbHluYGO8SHPZw6EK3nP5ZR2GCAj4
 Ii9g3jHA5u2jOVrW6kQPppV6VP3K4IMzEYONC5ao26dj5z60SLyH9NeNk8SO/Oz0w5Q9
 DNQBSsQPhvS/ApiqRv3dKAQf/PtQ+pxzyTDs6aUDoU8gXSQOU2NBjGxEDH6vXUKkLh52
 a7qVyQfIPHrkmVy77bVL3rZiUykUBPWrHAbBVUl0fb5CHeyEw2Il47xAsuL9MGlwx+uX
 2wZk/U7X+WJBhOCGiqX0vL7YuJkFAKp0eCXnWWHuB42Us7UYFPaiu1FJQzgeiugBzlBB
 YRPw==
X-Gm-Message-State: APjAAAVcsKRn46hlT9yuiSCBhx2WSTv6ZLlN/VAHydVdHJCMJHjyZ92p
 fkxM39E4ylTcLCX+b0mqi+c=
X-Google-Smtp-Source: APXvYqxSAKrpYuccNZtrZ/rJwN6FCBUoES8meVdd7HDb1pZFOvQ4bB12ILPgd4b6s3IfwnM54r2DqQ==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr3529639wmc.69.1552507234662; 
 Wed, 13 Mar 2019 13:00:34 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id 26sm4623926wmg.42.2019.03.13.13.00.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Mar 2019 13:00:33 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 787691140A07; Wed, 13 Mar 2019 21:00:32 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/64s: Remove 'dummy_copy_buffer'
Date: Wed, 13 Mar 2019 21:00:30 +0100
Message-Id: <20190313200030.19145-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312202921.31331-1-malat@debian.org>
References: <20190312202921.31331-1-malat@debian.org>
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
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 2bf1071a8d50 ("powerpc/64s: Remove POWER9 DD1 support") the
function __switch_to remove usage for 'dummy_copy_buffer'. Since it is
not used anywhere else, remove it completely.

This remove the following warning:

  arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]

Cc: Nicholas Piggin <npiggin@gmail.com>
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: complely remove dummy_copy_buffer instead of marking it as used (since not anymore)
 arch/powerpc/kernel/process.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 77e44275d025..b2f0daa2fcf1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1151,11 +1151,6 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 	thread_pkey_regs_restore(new_thread, old_thread);
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
-#define CP_SIZE 128
-static const u8 dummy_copy_buffer[CP_SIZE] __attribute__((aligned(CP_SIZE)));
-#endif
-
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
-- 
2.20.1

