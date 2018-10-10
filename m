Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4836C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:25:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B7020841
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0SCj/Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B7020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VMxk5jH9zF33c
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:25:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0SCj/Pl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0SCj/Pl"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VMv70QYgzDqfX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 16:23:14 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y15-v6so1920271plr.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HDc9DIxeQLjP12HWtbcAEsECA9aLaRIXkV11FebGvfg=;
 b=G0SCj/Pl8llhRoQLhdiDnMa7kAsGmtBMhG9+csD4f5LLn4HHW9+BIp28Y1+vTeZziL
 lzOhqv+WAxLkrI/cmm2ruMSIol8+tH9yLLsgPBJGwH++sLgmlS61ekaLg/a22LiPG1fz
 AdBHiFZyHWk/qLN3cxXYGztbVXUYXky12Idu8Z2gJPoyJKhAUXm8Q03g1aMslNIuOtSJ
 y9bcwHkNnxz8hXUudxJ0tcIGRz+B9U45Ag9Hb4pyFfweo+k7I/ZhRLnZl09QcreGJNt8
 6Njy5vOSl2tn0uV9+k+4hwQdQEC06jVp5G/47O5/pTXJ3R0ZgiSeXSeMnH3nMDDe0lIl
 fz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HDc9DIxeQLjP12HWtbcAEsECA9aLaRIXkV11FebGvfg=;
 b=iMxfN0LrBTBLVtFQhxdLNCzUwJog31Yi3xOucAypcRriQvzjlo5VG/h133zyOeIOi7
 0hmTyYIcKC6DQu44wvTzYiGYLv4v1n7+fd/Xkk8HwTfiqp2NkgFzHKp2Q+7jP2RyPWec
 fHL8bw2q9tlHVgIm5her3ObPUYM0udIRIPxA+9FpyPgKev4lVJZu0aqBYpcQtzO33/ER
 Ds+beYkTSz24AFj3b9CcL5HMMGO/oKbUWWHCq2UPTvvEjV08YXXnTFdmtkU7T13F4htb
 dWEitkvWSFrFbFhuLrU82t9ReaXfiVXYG4OprV6ZLt3ZB2SqcMCVVSruXuDgzIM33pZJ
 TImQ==
X-Gm-Message-State: ABuFfoivPUHdFvPiHecBz8HdoC/CcS0RsdPugKq1I1b9UYXV4zStnqyC
 babytcgHXR5VPlumIQkoMr9FpPCQ
X-Google-Smtp-Source: ACcGV62OsN8c/xHLKbLvc/2jJ9aJ5y2yn7vsT960/ffXkxvu3jreZAyDdwGIH5bEjp7PiFUSb7cemw==
X-Received: by 2002:a17:902:d20a:: with SMTP id
 t10-v6mr31720761ply.256.1539148992334; 
 Tue, 09 Oct 2018 22:23:12 -0700 (PDT)
Received: from flat-canetoad.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f81-v6sm41827496pfh.46.2018.10.09.22.23.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Oct 2018 22:23:11 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/rtasd: Improve unknown error logging
Date: Wed, 10 Oct 2018 16:23:02 +1100
Message-Id: <20181010052302.18094-1-oohall@gmail.com>
X-Mailer: git-send-email 2.9.5
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently when we get an unknown RTAS event it prints the type as
"Unknown" and no other useful information. Add the raw type code to the
log message so that we have something to work off.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/rtasd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 44d66c33d59d..6fafc82c04b0 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -150,8 +150,10 @@ static void printk_log_rtas(char *buf, int len)
 	} else {
 		struct rtas_error_log *errlog = (struct rtas_error_log *)buf;
 
-		printk(RTAS_DEBUG "event: %d, Type: %s, Severity: %d\n",
-		       error_log_cnt, rtas_event_type(rtas_error_type(errlog)),
+		printk(RTAS_DEBUG "event: %d, Type: %s (%d), Severity: %d\n",
+		       error_log_cnt,
+		       rtas_event_type(rtas_error_type(errlog)),
+		       rtas_error_type(errlog),
 		       rtas_error_severity(errlog));
 	}
 }
-- 
2.9.5

