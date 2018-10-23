Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A5C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:29:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E922064C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jME5vagu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E922064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNlM3dC4zDrMG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jME5vagu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jME5vagu"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNTr5yfKzF14t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:36 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 30-v6so131263plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7KMMdFSw10DcDKiCmHQOwnGojU9vuBRNUucRAK3vrzA=;
 b=jME5vagubvW3EyStbGr1XxEkEkmBOsGi6AoIu6VmIVTBiLgZ83GcOizdWDm6LBB5ZR
 Ewz4jOukyZJdPR6QVCO2AnDdvTC5PwlW3XwbuqqSZF58YeW9SiRg58rxe5s49SfiIHJf
 65Ng02BHZZlMzY8VmiIh4sbiDrVD57w06hJMnYHF3PK6mzcp4xBOhC3sBf16MhvKx9Lq
 j31+1F6uXH93UeZXtTTnpIhnxCWubrZaF/7z1czXeW+seV1gprOHMs/ih/r7ba1zICQT
 k/gzLG9comRZUFHsFlN4FQ/Lp435v9ErntocrS8q5Y715Iz3A9xXZCHyFdmjVKbKOcdw
 CPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7KMMdFSw10DcDKiCmHQOwnGojU9vuBRNUucRAK3vrzA=;
 b=Xu5t0QP2EG0XJ/3IB/yR4jsF49z0NbHrpj2Q4A58+v+ykq+P2qq+R/Y4D3zyg14qgu
 ybH5TUZIiJD0K1/c0Dawx5HNrCLNr7w8jcXz6Meg9QRCEYxQpamb+htxLfQhA1U7lBdl
 DaRYey9tUB/jRgLsqYv8IsxTEirMWa10iWHLIJ2fyTnEO8xqQ1blKS2Hgo5wsVsGLuT+
 g1FjImuJhAP+XcMji7+rgPnr2nWmS5rAyklThCSu8qwM5gfdLFzCl1CnSJMjuutaj1DA
 2r4oXqQkcetdcgwgX408NAhroMnDIiAOGVz7rQDhVjWAe9CbWyAqEf1dB9u1n9Ee3W4+
 gtCQ==
X-Gm-Message-State: ABuFfogiZ+qPtUqFiX1/7LAbg6kYe9EyIBnkhrMMMWZkF73A3l10W3zT
 4J/A/X9zYJYoyTbL+qEJyb58Fewj
X-Google-Smtp-Source: ACcGV61ZsxPEKB+YewbJh1bxLOdgxhbGklIx2f0oB++OvZEhz2SgQSMMLjvg+nPeguaHbKcoGr9W3w==
X-Received: by 2002:a17:902:1ea:: with SMTP id
 b97-v6mr48414523plb.152.1540275454466; 
 Mon, 22 Oct 2018 23:17:34 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id 90-v6sm871825pfk.134.2018.10.22.23.17.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:33 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:28 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] selftests: powerpc/signal: Make tests build
Date: Tue, 23 Oct 2018 16:46:55 +1030
Message-Id: <20181023061657.18007-5-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023061657.18007-1-joel@jms.id.au>
References: <20181023061657.18007-1-joel@jms.id.au>
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
Cc: linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

According to lib.mk, TEST_PROGS is for shell scripts. It appears we need
to define the programs as TEST_GEN_PROGS to ensure they are built.

The definition must also happen below the inclusion of lib.mk.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tools/testing/selftests/powerpc/signal/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index d34a7c7710db..25d0973df5b3 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := signal signal_tm
-
-$(TEST_PROGS): ../harness.c ../utils.c signal.S
+TEST_GEN_PROGS := signal signal_tm
 
 CFLAGS += -maltivec
 signal_tm: CFLAGS += -mhtm
@@ -9,5 +7,4 @@ signal_tm: CFLAGS += -mhtm
 top_srcdir = ../../../../..
 include ../../lib.mk
 
-clean:
-	rm -f $(TEST_PROGS) *.o
+$(TEST_GEN_PROGS): ../harness.c ../utils.c signal.S
-- 
2.19.1

