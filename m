Return-Path: <SRS0=hRAb=DF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C0AC2D0A8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2020 11:43:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCAE2080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2020 11:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCAE2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0LJ41k5VzDqTZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2020 21:43:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=windriver.com (client-ip=147.11.146.13; helo=mail1.windriver.com;
 envelope-from=zhe.he@windriver.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=windriver.com
X-Greylist: delayed 7107 seconds by postgrey-1.36 at bilbo;
 Mon, 28 Sep 2020 21:00:07 AEST
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0KKz1MJVzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2020 21:00:04 +1000 (AEST)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
 [147.11.189.41])
 by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 08S91MsO013707
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Mon, 28 Sep 2020 02:01:22 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 02:01:15 -0700
From: <zhe.he@windriver.com>
To: <gustavo@embeddedor.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, 
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <zhe.he@windriver.com>
Subject: [PATCH] powerpc: net: bpf_jit_comp: Fix misuse of fallthrough
Date: Mon, 28 Sep 2020 17:00:23 +0800
Message-ID: <20200928090023.38117-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 28 Sep 2020 21:41:54 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: He Zhe <zhe.he@windriver.com>

The user defined label following "fallthrough" is not considered by GCC
and causes build failure.

kernel-source/include/linux/compiler_attributes.h:208:41: error: attribute
'fallthrough' not preceding a case label or default label [-Werror]
 208   define fallthrough _attribute((fallthrough_))
                          ^~~~~~~~~~~~~

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 78d61f97371e..e809cb5a1631 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -475,7 +475,6 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 		case BPF_JMP | BPF_JSET | BPF_K:
 		case BPF_JMP | BPF_JSET | BPF_X:
 			true_cond = COND_NE;
-			fallthrough;
 		cond_branch:
 			/* same targets, can avoid doing the test :) */
 			if (filter[i].jt == filter[i].jf) {
-- 
2.26.2

