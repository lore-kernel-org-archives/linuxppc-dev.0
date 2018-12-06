Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0182C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:30:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAB420989
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz2AyUcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAB420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fgV2gZkzDrBr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:30:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qz2AyUcD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qz2AyUcD"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNk07ZFzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:41 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i12so322257pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zi1qaO4sdSOQaH21fGYxR+uCkoajV+MPOXlymf28wFY=;
 b=Qz2AyUcDH1BfgiZOLCAcDJ/48kweVj9hRCOojoBahzObCi/9ceLJ+gRQjVYtTyQfMD
 U1heHEpP0hRkfiAI+TdxgTz93JbKan9n0vQxdGylaer4SRqWwZdfHuFj8r/nbLvuzBdC
 /xvwrSasNOYs8iqw3OBUcxFJYjph+EW68zS8/iD9m/vpXJrSnvRkBmIL0oLwoZL+pPZC
 YVQd2ZUjUI4s2t579iDzHniSDbxC5VAM87zr6kQNYdQWykzuGzqRpaeIU+tSffo/qZ3E
 b7hgRrT7bPTlJYmn7nuAsambciN9Q4I88bqJqTNafcJ60VQ/gRkMjXBgJvo8xGy+4GSa
 R2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zi1qaO4sdSOQaH21fGYxR+uCkoajV+MPOXlymf28wFY=;
 b=YnMfRS7OZaYJ71t8wqac+grLhJRKS1W/4L9ZXM5e+JaOS4P1Yle1FIdKfpqeRuZ9EP
 lOMFjRYjahiyai+g0DgsIziITkP79ia7qBITw4R1SUqxXMGk8SqAIthkWBSRGScDqKzk
 ldLWYw/5YKP/iNFX4B0wKa0dvS9Bvq/G0va5aM6nXanZJ611i1f+VJb+9pdJnwaQ5TWH
 A2ue6q+461qZb5eEujFONNOCYwmAg4diFqSiTg4b3Y+5cF46fcAJLKxf9+Qc0tdGfYae
 a5W7uHA91+iNDEIn/AAIjcGtF9MQXtfy7Pd74KGHJDzYItlIWwikY07/+GXMYcqpRlbE
 +VAQ==
X-Gm-Message-State: AA+aEWYKWLK9FohtXnMP8cgz61ROADzMUj93mlnJ35zGsYH3S8KEvN3/
 SG/Zt4qZDUZ23pv+CLJ0WciMnJ50
X-Google-Smtp-Source: AFSGD/W7pZOwcgWGYFFQ4vJeXE05EImLDDhMK4BDdHBNYghyuLLpeh2aXLgPocpqyMSp48gxHFYeVA==
X-Received: by 2002:a63:507:: with SMTP id 7mr22789432pgf.411.1544109460092;
 Thu, 06 Dec 2018 07:17:40 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:39 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/7] powerpc/papr_scm: Remove endian conversions
Date: Fri,  7 Dec 2018 02:17:11 +1100
Message-Id: <20181206151714.28494-5-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206151714.28494-1-oohall@gmail.com>
References: <20181206151714.28494-1-oohall@gmail.com>
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

The return values of a h-call are returned in the CPU registers and
written to the provided buffer by the plpar_hcall() wrapper. As a result
the values written to memory are always in the native endian and should
not be byte swapped.

The inital implementation of the H-Call interface was done in qemu and
the returned values were byte swapped unnecessarily in both the
hypervisor and in the driver so this was only noticed when bringing up
the PowerVM implementation.

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ed1082cc1d27..90203039dee8 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -55,7 +55,7 @@ static int drc_pmem_bind(struct papr_scm_priv *p)
 	do {
 		rc = plpar_hcall(H_SCM_BIND_MEM, ret, p->drc_index, 0,
 				p->blocks, BIND_ANY_ADDR, token);
-		token = be64_to_cpu(ret[0]);
+		token = ret[0];
 		cond_resched();
 	} while (rc == H_BUSY);
 
@@ -64,7 +64,7 @@ static int drc_pmem_bind(struct papr_scm_priv *p)
 		return -ENXIO;
 	}
 
-	p->bound_addr = be64_to_cpu(ret[1]);
+	p->bound_addr = ret[1];
 
 	dev_dbg(&p->pdev->dev, "bound drc %x to %pR\n", p->drc_index, &p->res);
 
@@ -82,7 +82,7 @@ static int drc_pmem_unbind(struct papr_scm_priv *p)
 	do {
 		rc = plpar_hcall(H_SCM_UNBIND_MEM, ret, p->drc_index,
 				p->bound_addr, p->blocks, token);
-		token = be64_to_cpu(ret);
+		token = ret[0];
 		cond_resched();
 	} while (rc == H_BUSY);
 
-- 
2.17.2

