Return-Path: <SRS0=KC/l=27=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCCC33C99
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2020 04:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D6F20678
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2020 04:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwYfLdss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D6F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47v9gC2vvBzDqc7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2020 15:56:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QwYfLdss; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47v9cz4Sr8zDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2020 15:54:22 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id k3so407014pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jan 2020 20:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4g4JvgldEwoKMuWLUOAYj3Z5zE2fAkLH46301oeIx7E=;
 b=QwYfLdss+l0rasUrCGlCdscv8AWGKx8yL+zddjV+st59nGgeeaIkdemSmFFt77fk2X
 40LX/geiJdEqbx7OAtMEFvRC2Zg4qf/b5bd83e2x8oZIyzV0iCddtnVR7zzd1IB4GVRD
 jSoGLPyCnXPvlVUK3f0wTOUd7CfvEHyUpQKXG0y1OV+HNzrS1o/JDx3UjdsGu7GhRehp
 MrcFtWmCXf2nncxj7CUzJTinQiAuH4daQTml778qW4xXLgs8/JC9fv7ggw0/hX8jD2gJ
 Frt6yhoKF6CTHu1eFRxY4uxd30GkHrGHbthqCAx4mfpKP8iognVWnRKb+6umnErs5NQo
 rEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4g4JvgldEwoKMuWLUOAYj3Z5zE2fAkLH46301oeIx7E=;
 b=HMhLxesVe/Di6CR5VmRH5RQd70XBhHSVFXEufpKZyUovZljqzRxoTDoLdw98c2fy5B
 0Fp5BXo7QEPqJfY2z/zTSzt3b6IBnLRbyTTgN9cENjIRPiYscm8re1G3QgiRfPxEdwta
 2sD10eXmZy7fRtfhpJtR5Z/Jsa1bLkLNZhMlji1ZZ26CvuLDb9JE9eaa59Rz8b9Nfli3
 uWJaf/5r9qoYUIE5XEqowzwVypYkqAAvQ4Ha4b3Tgu/+R7bV6eu2OIqQ5b+Dhoo8RjOT
 Zg5aAnXOkTpul5CnqI2EZNsgOCICDTLB1n7MtuOD27KT3k57s9W1pF52hZY9fSyqcd3W
 h6lg==
X-Gm-Message-State: APjAAAXujAHokJi5XbtsAPaPmiit3F6zVjF/rDu51PyFuITN/cuER+U3
 a95f3HXe1Uibt9fJ2dH8G/nMJoEAkA==
X-Google-Smtp-Source: APXvYqydMvty7z4BPAaD4+kK3ki0ZFQeQ07+CwPMfhEuO4whsFARJypAaK0PSvI9EYJgMOBa2+KJhQ==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr1836726pfo.213.1578632059029;
 Thu, 09 Jan 2020 20:54:19 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 13sm779121pfi.78.2020.01.09.20.54.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 20:54:18 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: in lmb_is_removable(),
 advance pfn if section is not present
Date: Fri, 10 Jan 2020 12:54:02 +0800
Message-Id: <1578632042-12415-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
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
Cc: Paul Mackerras <paulus@samba.org>, Pingfan Liu <kernelfans@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In lmb_is_removable(), if a section is not present, it should continue to
test the rest sections in the block. But the current code fails to do so.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c126b94..a4d40a3 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -360,8 +360,10 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 
 	for (i = 0; i < scns_per_block; i++) {
 		pfn = PFN_DOWN(phys_addr);
-		if (!pfn_present(pfn))
+		if (!pfn_present(pfn)) {
+			phys_addr += MIN_MEMORY_BLOCK_SIZE;
 			continue;
+		}
 
 		rc = rc && is_mem_section_removable(pfn, PAGES_PER_SECTION);
 		phys_addr += MIN_MEMORY_BLOCK_SIZE;
-- 
2.7.5

