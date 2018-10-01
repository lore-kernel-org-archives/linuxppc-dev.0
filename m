Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918CBC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 06:24:35 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9152083C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 06:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qE98+g1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9152083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nsh03Wf4zF37Q
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 16:24:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="qE98+g1p";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="qE98+g1p"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NsdN0m0ZzF35s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 16:22:14 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id m77-v6so8410981pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gb/QeTgch69rLNoSkztRf63gt6HjmQ/UAWrv+rNxmdM=;
 b=qE98+g1pjMaoCIc/mgovR+JCCUNlTs5KkdDc1iEQZhwqrU+THZGx+8mrZYbpZzAcH9
 OTgDU1hgUHi0P4x2S4xN7plxdx3qNTmWNIbFmr22FwBxq6AK7Wsa33Wqx6No+I75ApA+
 Io9uC5EVDEjI87xqoL1AnfJ3LdPGqAHiP1MvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gb/QeTgch69rLNoSkztRf63gt6HjmQ/UAWrv+rNxmdM=;
 b=Xc6jmrHBF+Z08Dr8k2wvaeDtLrUI7e3APQR9QYWstFfwRnXbaldRgOP9YgTXt8wPLj
 LKJfbquJdRiChxbBe5Kmb4Kko7hfY6Ezn97W9Siss+9ak22erMKVSzCSazTv5uOMufsL
 v4CplxjU7qAQH06TZQeuQb8ay+nJ+vs6wfwbQjrl8SlPsWxNy8qGXNqFRu6tLevP/SAk
 Xou08O3Blr4nMaTYZn3DtDsZdGEnVCyLuS/IsCeQBZDfH676md7dB/1RISowCUSa5/5S
 yJxm5RSmo/s+iH5zwxT3uXY1IZHGRzhlZ9M/Fz77lS8qCJyaUyxvvgFBQxuKcxL//kVN
 7nZw==
X-Gm-Message-State: ABuFfoiX3FeIYshBsdeTE307mUHRI1bJ7CWSDJLOl4g/LFqvWq0zvf/W
 RZxrRjIc7al6ABP6dmLt5P6CzVs6CNbePg==
X-Google-Smtp-Source: ACcGV62Ap2KHq4wmFYl2XPwOWw21yN74EVbLHMPxsRMXKU4y8DYmPA0ICkleVgC6Z5UMGX6M5YKnNg==
X-Received: by 2002:a63:5021:: with SMTP id
 e33-v6mr8908214pgb.306.1538374932596; 
 Sun, 30 Sep 2018 23:22:12 -0700 (PDT)
Received: from localhost.localdomain
 (ppp121-45-207-120.bras1.cbr1.internode.on.net. [121.45.207.120])
 by smtp.gmail.com with ESMTPSA id g3-v6sm17550952pgn.37.2018.09.30.23.22.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Sep 2018 23:22:11 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/nohash: fix undefined behaviour when testing page
 size support
Date: Mon,  1 Oct 2018 16:21:51 +1000
Message-Id: <20181001062151.23831-1-dja@axtens.net>
X-Mailer: git-send-email 2.17.1
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When enumerating page size definitions to check hardware support,
we construct a constant which is (1U << (def->shift - 10)).

However, the array of page size definitions is only initalised for
various MMU_PAGE_* constants, so it contains a number of 0-initialised
elements with def->shift == 0. This means we end up shifting by a
very large number, which gives the following UBSan splat:

================================================================================
UBSAN: Undefined behaviour in /home/dja/dev/linux/linux/arch/powerpc/mm/tlb_nohash.c:506:21
shift exponent 4294967286 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-00045-ga604f927b012-dirty #6
Call Trace:
[c00000000101bc20] [c000000000a13d54] .dump_stack+0xa8/0xec (unreliable)
[c00000000101bcb0] [c0000000004f20a8] .ubsan_epilogue+0x18/0x64
[c00000000101bd30] [c0000000004f2b10] .__ubsan_handle_shift_out_of_bounds+0x110/0x1a4
[c00000000101be20] [c000000000d21760] .early_init_mmu+0x1b4/0x5a0
[c00000000101bf10] [c000000000d1ba28] .early_setup+0x100/0x130
[c00000000101bf90] [c000000000000528] start_here_multiplatform+0x68/0x80
================================================================================

Fix this by first checking if the element exists (shift != 0) before
constructing the constant.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/tlb_nohash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 15fe5f0c8665..ae5d568e267f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -503,6 +503,9 @@ static void setup_page_sizes(void)
 		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 			struct mmu_psize_def *def = &mmu_psize_defs[psize];
 
+			if (!def->shift)
+				continue;
+
 			if (tlb1ps & (1U << (def->shift - 10))) {
 				def->flags |= MMU_PAGE_SIZE_DIRECT;
 
-- 
2.17.1

