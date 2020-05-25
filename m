Return-Path: <SRS0=r5XJ=7H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 03:05:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56457207C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 03:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQRWj2BV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56457207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49VhmZ0Z0RzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 13:05:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bQRWj2BV; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Vhfj3LpLzDqRZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2020 13:00:29 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id u5so8083159pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2020 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nWSLFWr+PrQPEz2pybw6DzVr65U4VpQ3V1gGQeAWMKI=;
 b=bQRWj2BVbikVfRKE5io43sOsrCIdaWmjFxNvZjn83GvbP/NOGy5/JdyQ43B1zqLYcF
 ptRcqLDcjXn4+9Ro+urKLMR+WB8DkU8CCOCHWlW8hIckHHbu206O5CGFm/n8wYZ3K/ye
 /f48OSDjJ5ZYMmh+CdEXfa6/zr2ayO4Xxu8krj1+hNZcAhDgDrHQ1XezZWfEmYH5tJzQ
 XN6OEQbtOi0UUckNKAVE3xKsPu1gYJFfGJBAVcYcCrp7X58CrMgXOtvyxZq7Qoibvsz/
 bEpODX1pxG4rQZa0zfJkg6vlB0KLwE0SdtdjorpjEaZWNUEB0Z1TCTWsQY1K9tqrwj3O
 kQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nWSLFWr+PrQPEz2pybw6DzVr65U4VpQ3V1gGQeAWMKI=;
 b=KDPVb21QKd7AIwq85Qtyi5U4UKD1BVKsuaYkCPMR3dQRcclb5st35i5K6WuifpWFbD
 AJBc7DvBKX/3U6rJ291/72YtjnMNg10A0pG444VPDK/g660Vok+fMnDtyJwPVp6bWI4l
 CvMhZ6JiBDDp8fw6ibz70JevahPCPAwdMYe0/5kgYiliZ6BTW9BVmGMeO55HwrIfbyHQ
 45SiN+f+hK3lvLupL+3/Ta6eWheykqyMyAjD16XGu32CD4DRxRvOZynLzPwWLiM3raNg
 XDcG6yDF0WWQo2L/BUQNLE6Odqm+9ImjpJ0xBV5Lf6ASHk8kFsUo1hjY7Hz7LttVNtfN
 3YQw==
X-Gm-Message-State: AOAM533jXfaQqA63+TGz3tfFm60hA2PexuCo1B91iVT5pFvtxXeAND+H
 J0YWAqGSDFDF8SFmtCtO26Oj8ltBVGY=
X-Google-Smtp-Source: ABdhPJz8vVllbpAe+7OS+1GmNKUMCKmc1vnwkfU9dUu68UaGOhZenIVFENVFCAjmKh8gIBspS/TZzg==
X-Received: by 2002:a63:b64e:: with SMTP id v14mr25205185pgt.164.1590375626559; 
 Sun, 24 May 2020 20:00:26 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id p8sm10790452pgm.73.2020.05.24.20.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:00:26 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc sstep: Set NIP in instruction emulation tests
Date: Mon, 25 May 2020 12:59:21 +1000
Message-Id: <20200525025923.19843-3-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525025923.19843-1-jniethe5@gmail.com>
References: <20200525025923.19843-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, Jordan Niethe <jniethe5@gmail.com>,
 bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The tests for emulation of compute instructions execute and
emulate an instruction and then compare the results to verify the
emulation. In ISA v3.1 there are instructions that operate relative to
the NIP. Therefore set the NIP in the regs used for the emulated
instruction to the location of the executed instruction so they will
give the same result.

This is a rework of a patch by Balamuruhan S.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/lib/test_emulate_step.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 9599f3a03ca1..427c2ca8191e 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -1076,11 +1076,14 @@ static struct compute_test compute_tests[] = {
 static int __init emulate_compute_instr(struct pt_regs *regs,
 					struct ppc_inst instr)
 {
+	extern s32 patch__exec_instr;
 	struct instruction_op op;
 
 	if (!regs || !ppc_inst_val(instr))
 		return -EINVAL;
 
+	regs->nip = patch_site_addr(&patch__exec_instr);
+
 	if (analyse_instr(&op, regs, instr) != 1 ||
 	    GETTYPE(op.type) != COMPUTE) {
 		pr_info("emulation failed, instruction = 0x%08x\n", ppc_inst_val(instr));
-- 
2.17.1

