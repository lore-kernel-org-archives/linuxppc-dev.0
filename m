Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 20:22:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F09F214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhzIYV8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F09F214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JmcJ5kkqzDq75
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 07:22:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jhzIYV8c"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JmYb2gfBzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 07:20:18 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id x7so4099431wmj.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IeWM4AXVY/e4lDQuN3ToH4SBkbwPxft+9TDRwgvEvBs=;
 b=jhzIYV8cVGg4JVIrmaONRCp7pEMdS+N6PONtCtg3RduPoubskkxozYeGyDDUNmGlkk
 PZ21bveBsO6Qf7W+ynvpZ9OdHyFaP9Xwi404CN1qy90r4VuvDaru2ksI+ouZu1QN5OL7
 sMzoSRP/e8bG2Ml0lCaXt8mUtglACoRmIH+I1vYAEQcaR92LPVcM5LhzLxgOOqk6Fmxn
 HxveI2fiGndThJ7x7Bg+iO4KvIEhfq6ZB9aFkzOtCyUkA+VTe440VD9dW5GhjBhCMHAP
 aIlytgntiKJrg3g12gcA7rCs4Pcedq7AJN0ijG9eu24OAEZGHeYtSDUbT2HGQowAa4Y3
 g0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=IeWM4AXVY/e4lDQuN3ToH4SBkbwPxft+9TDRwgvEvBs=;
 b=ol7u8DlvKrIXkpozZKdPZsrQ3F60lNa07OZ7+RQHpGqkjoKdCyoQ64k/AprDQSoXOY
 E+C4Xq+po17md+MT5O8W1OlFmu2OI5WH5wi7L9CS2n2SaEnREm4ihPSQNuSZ/f6/Khc3
 WmXXCyMddAb7+2VDyOcbE4NMJMq88u4fIOFXzgmJU6f6XadPSILjcX3EnQ1xiDhvnJfs
 jhI7SLALl4eJRoJsUL6OlnsZkPJBctFDiDeekNHEDMD9FMbcEVszKnjITzrDpiBTJlIt
 I8o58YzFHK8nrA/lNtN9r1Jwpiu5LzN2DDJQdIvBVQ50xlZOuT56NtFpLffNghV1unmD
 N92w==
X-Gm-Message-State: APjAAAV1MvjL+lqn8y+0S3kQj3gdcHOHs6yucdqeLRkZahVmwwXIO6xI
 /AYvdQzO8wIPKLw3FNkZgrY=
X-Google-Smtp-Source: APXvYqzK5U3aqvyYy8LSaY2voahC9WGDRNFVZkU0VUkW9XqX/CX1y9GWafnJBPeylWVcOnyrPZYjQA==
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr3514485wma.79.1552422014832; 
 Tue, 12 Mar 2019 13:20:14 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id t2sm1601787wra.9.2019.03.12.13.20.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Mar 2019 13:20:14 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 2BD9F114655E; Tue, 12 Mar 2019 21:20:13 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: sstep: Mark variable `rc` as unused in function
 'analyse_instr'
Date: Tue, 12 Mar 2019 21:20:08 +0100
Message-Id: <20190312202008.29681-1-malat@debian.org>
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add gcc attribute unused for `rc` variable.

Fix warnings treated as errors with W=1:

  arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/sstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3d33fb509ef4..32d092f62ae0 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  unsigned int instr)
 {
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
-- 
2.20.1

