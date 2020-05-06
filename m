Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C2C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:01:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB6420752
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5eRPYBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB6420752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H2vl04lyzDqkc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 14:01:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=K5eRPYBD; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H2XQ5LLTzDqlX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 13:44:38 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id p25so321923pfn.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2020 20:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fh86nuu96NXb/S0f8GHq7uv4IK3kP+PreTpnEo2bL4g=;
 b=K5eRPYBDyWGkdJ1K3qvU66nMN0W5p4jPhlhG7K0wOKNf8hxZHVuA4JE1z7l/o1yLUC
 EGS5AlX89Squ+eQW6iPpJKrqaehB/h4ZfMGJoRKzYDw8wfTm8WFYkQuexNPoIDOncXxb
 lFKQ48IdjxAgSfYmjds/MfTN9ecoq1NlUHNLroU54HmZBEDSKNpMkviY4KOgOwmikmpr
 G+0L2iKWnJ0xAlBW27Y6DLkOBV0oh4IHmQjuzuNDgRFMeTlAz2RgUOfk7wu1HsDbjJX9
 qsoiVLvyk6Yi4emJ0zxKwrYFKDWJkEJt3WxUFC0iI0oBFKwEEVfwC+u03dNyPcvxL6gs
 khGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fh86nuu96NXb/S0f8GHq7uv4IK3kP+PreTpnEo2bL4g=;
 b=QIE/Mk1Mf7OL5qxtuQkfgXpLGz52ra80/nndcc1wbnDCAC+ssrijf3mTRfke7GqSO0
 vcG0iN7Jw+WtQJJsmUarqkazDZUNe3NalbOJO2UP2sxbRp6CFG10j8TgmnLiw3wa2aYd
 czaK+DBjfXhP1vBsUTKfap6slONG2L2v+l6DOs26tk0oO7VeVJr8jgjR8i89B+7E6eI7
 j6cgO8QDMWjjlra5ZnFUkpNoodIuHD/KN57t1zwuMWIPPkZN2uPC9r3z09WDQXxCI/nB
 rSLHL0bhaASOKnCxBn8YtQT4IU/FsD5kXELhD754TFRSuNPmMgVOlHvJDD+fyh7HJG/8
 baig==
X-Gm-Message-State: AGi0PubFH7FO17uGAH+xoRDEoZQbmvpePcnmLyeY0cdB+vlitREP4mU7
 BNCOLWqDIN+Z3tyRwveUKL3I8v81LnO1IA==
X-Google-Smtp-Source: APiQypJfjL5LlPZ5cw2ydUq28JvAI56E8Jv1R5bZfyALZiBiwSHPODmbCc4F9lbE1hQVklCRGEq/uw==
X-Received: by 2002:a62:e51a:: with SMTP id n26mr6057075pff.301.1588736675453; 
 Tue, 05 May 2020 20:44:35 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id k4sm465676pgg.88.2020.05.05.20.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 20:44:34 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 09/30] powerpc: Use a function for byte swapping
 instructions
Date: Wed,  6 May 2020 13:40:29 +1000
Message-Id: <20200506034050.24806-10-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506034050.24806-1-jniethe5@gmail.com>
References: <20200506034050.24806-1-jniethe5@gmail.com>
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
 naveen.n.rao@linux.vnet.ibm.com, Jordan Niethe <jniethe5@gmail.com>,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use a function for byte swapping instructions in preparation of a more
complicated instruction type.

Reviewed-by: Balamuruhan S <bala24@linux.ibm.com>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/include/asm/inst.h | 5 +++++
 arch/powerpc/kernel/align.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 442a95f20de7..23fd57a86b03 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -18,4 +18,9 @@ static inline int ppc_inst_primary_opcode(u32 x)
 	return ppc_inst_val(x) >> 26;
 }
 
+static inline u32 ppc_inst_swab(u32 x)
+{
+	return ppc_inst(swab32(ppc_inst_val(x)));
+}
+
 #endif /* _ASM_INST_H */
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 47dbba81a227..a63216da8cf1 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -310,7 +310,7 @@ int fix_alignment(struct pt_regs *regs)
 		/* We don't handle PPC little-endian any more... */
 		if (cpu_has_feature(CPU_FTR_PPC_LE))
 			return -EIO;
-		instr = swab32(instr);
+		instr = ppc_inst_swab(instr);
 	}
 
 #ifdef CONFIG_SPE
-- 
2.17.1

