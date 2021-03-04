Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35AEC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 03:14:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5694A64EAE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 03:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5694A64EAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrbZN0MWlz3d85
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 14:14:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=P1RKrCmc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=menglong8.dong@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=P1RKrCmc; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrbY64zcSz30Lq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 14:13:28 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id l7so13679953pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Mar 2021 19:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ihoKSZ2JtK+MDtefdQWwboq2xXWO3Hg5YVvclpQVx5g=;
 b=P1RKrCmcyt72RM+mT5U3wv+Y6ZCAlh1TDPusj76xHpMxld6aqdApN0VbV6bdw1UOTm
 RwOKeE1skOWwGJn3D0e58HcwuqTf3nX2MbV9WtlXH55e++I8cFj4CvqjnCZ2AAbYMd00
 MzGMed8W5X6pfJFE0kHgF3lbvu4E0N1KmycLLuas+Qe9Jv8mCzS8fTdSHoulSI+FHp4h
 rygNL3TCbzSo8MlPG232oDXtcw4aetTXMzFRpPpJNdeDfXOAVD8LZUKtYjqCRye7uQCy
 glpyo58HUH7nytBHPr3kB90vcgdxNIV+bYTIzSWTsNjc8D2wXTUSC9OvwkJMcOlDlVg3
 S5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ihoKSZ2JtK+MDtefdQWwboq2xXWO3Hg5YVvclpQVx5g=;
 b=nfH/WSdpucdVxykAJ3wwLXuznjV9z7WsT44xWj31wcgxfWBLZpMPOyPDe9LYNZNgOi
 E90PM26F2+Xjcco/9C/UpRj5lI0l5gR9c8hvpcz5VqkI5oMPc1M133XjjX72zmATH+s/
 PQWefRAOTuONWsMB7bVwd2VhkMA1olm0RQw+XBH72lO9jbJ4xLcRPEf8yO77hFBwX1We
 rUkiQpEVHMArmj9loiWPmBf+5H9+QQ1bsfpezbySEI8UVN0NJE56H+vs4+xU5busxbbe
 zuLRF3u+Mjeaiz25HNHMCBH69l907Y93j3e9V2iTvnhCTQR3PAXct1JOVgKfc+EaC4jV
 2FEg==
X-Gm-Message-State: AOAM532CIOBJq4Kng89SAM9nRgVJyTETKahn2l+mNMWd2CtSEgm9jEox
 fpCHjzHl0FiUgek6r3v3bFYszrHKbCM=
X-Google-Smtp-Source: ABdhPJxRoYgeG9aLI7U1DV8vNSoXvmH+4j6ry8B4mBA8KTEj9Gza8qAiTHGa1ohkLtxDB9OAhWWRug==
X-Received: by 2002:aa7:93af:0:b029:1ef:1bb9:b1a1 with SMTP id
 x15-20020aa793af0000b02901ef1bb9b1a1mr1078028pff.49.1614827605544; 
 Wed, 03 Mar 2021 19:13:25 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
 by smtp.gmail.com with ESMTPSA id 192sm23447754pfx.193.2021.03.03.19.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 19:13:25 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To: mpe@ellerman.id.au
Subject: [PATCH] arch/powerpc/include:fix misspellings in tlbflush.h
Date: Wed,  3 Mar 2021 19:13:18 -0800
Message-Id: <20210304031318.188447-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Mar 2021 14:14:04 +1100
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
Cc: linux-kernel@vger.kernel.org, zhang.yunkai@zte.com.cn, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Some typos are found out.The information at the end of the file
does not match the beginning.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index d941c06d4f2e..ba1743c52b56 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -79,4 +79,4 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	flush_tlb_mm(mm);
 }
 
-#endif /* _ASM_POWERPC_TLBFLUSH_H */
+#endif /* _ASM_POWERPC_BOOK3S_32_TLBFLUSH_H */
-- 
2.25.1

