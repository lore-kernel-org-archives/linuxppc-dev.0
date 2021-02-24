Return-Path: <SRS0=wwxH=H2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBAC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 07:56:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F4964EC9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 07:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F4964EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DlpCY1XlFz3cYl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 18:56:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ZKxcX7ci;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ZKxcX7ci; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DlpC471M2z30Ly
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2021 18:56:15 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id v3so835830qtw.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2021 23:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=piJQ2+eVg7Z4RtyyaGqKuQT5hzrDLRvoDnnVb4fGjF8=;
 b=ZKxcX7ci+X9BoqAJguVITDxBXaOs0nGZWnSD8GyXV8+ZXAE972NYOlkdRyqGrq3/Kq
 ig8kXx+QWZp4gGOt11Xb2bkQvXkDBmx/0rSRjEOKd6UWdPpT+okWRUpPDZlouNA/d4d+
 4S+GQ+0hP1y28/6ROgy6oZ/qcn5PEoOWu6KzbAzCzzK4PDXCSi0GsugdEYmcqLY8rtWv
 TADSRWlcFvTZ/auDcEsJzoJK1efPsUQQyNwYlCGHQD7ikdYZR+yfWGoMPxop52jsBfOu
 53e/HiZIMaHT5xGRh5PPl7uz14mSI/sVwFRkxYeDJV3PHGiBTHqyol79sA1bo1MEAkA5
 Wapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=piJQ2+eVg7Z4RtyyaGqKuQT5hzrDLRvoDnnVb4fGjF8=;
 b=hDo8S7+kLrFXFfr6exyAreS9iFTqPHAJS49iQc81o2Jc7GNtX2upSnAf1h8rnFGW5u
 dx1VV22LLpKz4B/trNwqAT4CQ57Dh+3aqMOuWFpuW6pORAun0GcmuRzndJEUa2R6Y8Qv
 L7oRzvvcTARb7nhH1BJU8PzXM8RwoKnBkvfFcFMepyvp8V5kP+K+bw7nW71Zom6Vganc
 pGwTdTXiC6cyruxVGbDnnUmagwDIs7X8hSHHz5YxSNUO+X8ZNevBHbHi5pqAdDOVz1SE
 XPN/F9HVv4svmjaI3vugywA9uRXwSUPBCU7Jvphdutn2u6MRmL0ghJcyoDg4TRD73cMm
 d4OQ==
X-Gm-Message-State: AOAM530rf+UvWyGMrZ1BJT0JxHBiKXzsDsYY49dahPO+Btt+mfYHTQM1
 jvJTzKiTvCQzEG57hBiB3r0=
X-Google-Smtp-Source: ABdhPJwDKkaHSAlJ7clDw+zIhE/tpefzRxBFPn/L3xDOvQo5JYZDZ0XnhiQ25PIJpDfXIHl9llXV0A==
X-Received: by 2002:ac8:5ac9:: with SMTP id d9mr27112093qtd.123.1614153370751; 
 Tue, 23 Feb 2021 23:56:10 -0800 (PST)
Received: from localhost.localdomain ([156.146.55.69])
 by smtp.gmail.com with ESMTPSA id i75sm960295qke.47.2021.02.23.23.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 23:56:09 -0800 (PST)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 christophe.leroy@csgroup.eu, npiggin@gmail.com, jniethe5@gmail.com,
 alistair@popple.id.au, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] arch: powerpc: kernel: Change droping to dropping in the file
 traps.c
Date: Wed, 24 Feb 2021 13:25:47 +0530
Message-Id: <20210224075547.763063-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
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
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


s/droping/dropping/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1583fd1c6010..83a53b67412a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -405,7 +405,7 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
 	 * Now test if the interrupt has hit a range that may be using
 	 * HSPRG1 without having RI=0 (i.e., an HSRR interrupt). The
 	 * problem ranges all run un-relocated. Test real and virt modes
-	 * at the same time by droping the high bit of the nip (virt mode
+	 * at the same time by dropping the high bit of the nip (virt mode
 	 * entry points still have the +0x4000 offset).
 	 */
 	nip &= ~0xc000000000000000ULL;
--
2.30.1

