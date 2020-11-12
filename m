Return-Path: <SRS0=rG8u=ES=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06662C55ABD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 01:26:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225F52068D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 01:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfLxL9U/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225F52068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWkTS218yzDqwD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 12:26:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VfLxL9U/; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWkRh4GxvzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 12:25:02 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id x15so1938334pll.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 17:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t6O0sYxJBUgk9V8FqRpsvwNNwz5ipQ+AansIawZja9I=;
 b=VfLxL9U/SBb06NU26ZQg3mLeQ4YU1vURENNOX5o9q82sPjjgQlOfM1ZNu2MEX8cf13
 HiYQalcws2knOoe8K/KgYewmysQ8XDLjytyJ8Lj9gBheD0Bkl2D+PJIGAJlHwq3P0Jul
 LZrPQncH0vQobnEM1JMY88RpxSVE3r7lG47hHG5WmhT2Yiw+NisM+btts8lhN4bJuRk9
 pgEAtMLaELZYognagwPWUCKr52rDSoRc9Hk/TipywE70ue8nFy0R0/Z+wRYQwX5H1vI7
 MU5hAswXktl9GHH4aJsXmWx0TRKsirtCqDa7tWPiyikBYgQZj4a0OIMOCvOQ3zHmNcGY
 9Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t6O0sYxJBUgk9V8FqRpsvwNNwz5ipQ+AansIawZja9I=;
 b=C5shnvZeWZPUr6hcw5o3U8YkDt5UKA79r+QAyqb2lAFYR5UtXQQJAJrpfXRO06Yk0k
 eMs4cN7xIzcq0O+t5J2qQ239wF9DYz9DFk0xMDk4QXkYqw+2Y2a9RGkZNZDf2jWuZNIJ
 u1Q3wsjNc+q9Dd+fMDjyLxp4iLFL87yt1wNZrPLikRUBxBUb6fz8LNO/8gaVKDgPmfKi
 LxgVzF8uhF91t+MdsVdUaw87ZSPqMXAbtVZ6k9vi3snVZPMdfmO+q1x8IQMd/olAaqFZ
 NwaZ0mWW94goteNxwGoUiFxVNkINBtPOs+UUIgk8vMD/g8jwTv8D/tB4UKuq/nUrw65J
 LhJg==
X-Gm-Message-State: AOAM530mmURyhHfacPDUJ3EyfV33qMTmgA9BZQZe57ENrJ0RYYNB6q2E
 O7A0Dx7eY5AR633TELczveoCzoEKbuQ=
X-Google-Smtp-Source: ABdhPJyjsvg9C4SUokM73BG6LLbH3Hup8iycj/2InNMean/F6Boq/HwoUQ1KVzkfw4ArHsGv4r+FTA==
X-Received: by 2002:a0c:a5a2:: with SMTP id z31mr29221656qvz.15.1605143981548; 
 Wed, 11 Nov 2020 17:19:41 -0800 (PST)
Received: from LeoBras.ibmuc.com (179-125-145-97.dynamic.desktop.com.br.
 [179.125.145.97])
 by smtp.gmail.com with ESMTPSA id e10sm4153867qkn.126.2020.11.11.17.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 17:18:17 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/1] powerpc/kvm: Fix mask size for emulated msgsndp
Date: Wed, 11 Nov 2020 22:16:55 -0300
Message-Id: <20201112011655.382866-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Leonardo Bras <leobras.c@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

According to ISAv3.1 and ISAv3.0b, the msgsndp is described to split RB in:
msgtype <- (RB) 32:36
payload <- (RB) 37:63
t       <- (RB) 57:63

The current way of getting 'msgtype', and 't' is missing their LSB:
msgtype: ((arg >> 27) & 0xf) : Gets (RB) 33:36, missing bit 32
t:       (arg &= 0x3f)       : Gets (RB) 58:63, missing bit 57

Fixes this by applying the correct mask.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e3b1839fc251..5af0a429cee8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1241,9 +1241,9 @@ static int kvmppc_emulate_doorbell_instr(struct kvm_vcpu *vcpu)
 	switch (get_xop(inst)) {
 	case OP_31_XOP_MSGSNDP:
 		arg = kvmppc_get_gpr(vcpu, rb);
-		if (((arg >> 27) & 0xf) != PPC_DBELL_SERVER)
+		if (((arg >> 27) & 0x1f) != PPC_DBELL_SERVER)
 			break;
-		arg &= 0x3f;
+		arg &= 0x7f;
 		if (arg >= kvm->arch.emul_smt_mode)
 			break;
 		tvcpu = kvmppc_find_vcpu(kvm, vcpu->vcpu_id - thr + arg);
@@ -1256,7 +1256,7 @@ static int kvmppc_emulate_doorbell_instr(struct kvm_vcpu *vcpu)
 		break;
 	case OP_31_XOP_MSGCLRP:
 		arg = kvmppc_get_gpr(vcpu, rb);
-		if (((arg >> 27) & 0xf) != PPC_DBELL_SERVER)
+		if (((arg >> 27) & 0x1f) != PPC_DBELL_SERVER)
 			break;
 		vcpu->arch.vcore->dpdes = 0;
 		vcpu->arch.doorbell_request = 0;
-- 
2.25.4

