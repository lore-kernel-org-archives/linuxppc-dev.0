Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE1CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 09:59:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE4820854
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 09:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ej4oLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE4820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Y9pM56tGzDqFH
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 20:59:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sergey.senozhatsky.work@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5ej4oLl"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Y9mY1ywtzDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 20:57:30 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so20538976pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ze2tdZRcrsfRWtX0DH4fBvdbFaxqCQ1B/ZmEi8dntyM=;
 b=H5ej4oLlqskUIU0/ucYmdyzpaWBObClYAkOa/Cw27/xi4pZOVaZkX7crpmj30sk3DL
 hLB22BagvfKHWfuG5kgkiZHN+yqE0YIvrYSk8ozAeBtsj6JISI82DvIR/ibetPW50jWi
 5bOMcSiGhPkMzOS2MlHUyY8JRvjNyglE34kS6LZf/sCy4HWT2xrcExddTWfGVg2DP+H6
 eDiHDts0QZz1m2ssCb0VGbHJ2auIsL+vb65GHktGc+fFX0SoukntTOGkY1RP4b1ihpu7
 IqUaHfJFgxfHnASi3s4L2FbY6c96Os+Dq95Bj2Us8wgtMo4TEHTSzrbWq76px90/ayGm
 m6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ze2tdZRcrsfRWtX0DH4fBvdbFaxqCQ1B/ZmEi8dntyM=;
 b=rV18E+k0o2jGHQI1G3Q4SFc3017QAP23ebewMKNDMRT1YB7vyU2seN422q/sFLftnd
 FmzipqCixU97QDH6hMezYsYHWTrN57mblOFm7Rvga0mMnHm69dG8ZLUj0hbXEcww5pYZ
 6ubFW094rMpcJzPAPK3Ze5mgjA1rtLPN9BiSEl+rrJp5JhosButXnOanLCLyUmISmP3M
 SkrtIGyr86XtYCJPzzABCi2uNToXTtZGse10nHpGQOFdJcfPwrs2w4El5m7Wh4CsYEcC
 uEwM9z9lxOjqlGTYsJ+f9j6XVIjcXoX0t7HqrIGVzUKMmtirDgDtmDhjbZwxYWxcsEIm
 Q/nw==
X-Gm-Message-State: AA+aEWYh8kpdaqBFLdb287LW0IYJlt9/UGjFFRDwF+Mdxt1LbbGUDPUF
 E+CPf2vLHlJ33a4NyMRG+Ig=
X-Google-Smtp-Source: AFSGD/Uf84UEDVKpsIVbbr/BY+uTuwlcRjEShYRNhc6NyDrtBTToH/NIveMPLkQefVLE3aKJB6k8UA==
X-Received: by 2002:a62:710a:: with SMTP id m10mr61997859pfc.69.1546855048251; 
 Mon, 07 Jan 2019 01:57:28 -0800 (PST)
Received: from localhost.localdomain ([175.223.14.193])
 by smtp.gmail.com with ESMTPSA id x19sm111676579pfk.14.2019.01.07.01.57.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 01:57:27 -0800 (PST)
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: use a CONSOLE_LOGLEVEL_DEBUG macro
Date: Mon,  7 Jan 2019 18:57:20 +0900
Message-Id: <20190107095720.7538-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use a CONSOLE_LOGLEVEL_DEBUG macro for console_loglevel rather
than a naked number.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/powerpc/kernel/udbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 7cc38b5b58bc..8db4891acdaf 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -74,7 +74,7 @@ void __init udbg_early_init(void)
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
-	console_loglevel = 10;
+	console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 
 	register_early_udbg_console();
 #endif
-- 
2.20.1

