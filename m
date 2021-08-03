Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C437C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 21:16:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD5860F0F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 21:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFD5860F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GfSNc0CMXz3cRQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 07:16:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D7Z+CKbg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=nathan@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=D7Z+CKbg; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GfSN52lVGz2yyj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Aug 2021 07:16:05 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3A1A60F0F;
 Tue,  3 Aug 2021 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628025361;
 bh=hzGVYpSoT4c8eD9xIvtVELfHC2qZ9qRppSvQ6vReMyk=;
 h=From:To:Cc:Subject:Date:From;
 b=D7Z+CKbg2Z3xrAEjI8SCn68xBlte0yJcYGNFV212KyjPRdf6vuWbwxSE61SEMRw9j
 nc7Z8FpXxEVtIA4kNg+PkGkHfaCJRVhJlzKo8RXJGXeSlpUK9G8LpwBNZkYcGVoB11
 BmIzYXXJlKoop/0GwA1/d7+ryoouWpOw1UtZcbyF8hslz+LigrSBt3dNRYdZqaa6NR
 MAwDjI/q1THimh2Tl7OA2Qim/0t9BEGOzcqyiSF72T6HczXbExcnGHyYbfmaGuieLf
 tGQDP1cdDZVVPmc2zVukorqiqIAH1Ek9cpMjBENGR7t/aCJo6qYy1wTrZgWz67jhYP
 WHi0dVrOKTg+Q==
From: Nathan Chancellor <nathan@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] cpuidle: pseries: Mark pseries_idle_proble() as __init
Date: Tue,  3 Aug 2021 14:15:47 -0700
Message-Id: <20210803211547.1093820-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

After commit 7cbd631d4dec ("cpuidle: pseries: Fixup CEDE0 latency only
for POWER10 onwards"), pseries_idle_probe() is no longer inlined when
compiling with clang, which causes a modpost warning:

WARNING: modpost: vmlinux.o(.text+0xc86a54): Section mismatch in
reference from the function pseries_idle_probe() to the function
.init.text:fixup_cede0_latency()
The function pseries_idle_probe() references
the function __init fixup_cede0_latency().
This is often because pseries_idle_probe lacks a __init
annotation or the annotation of fixup_cede0_latency is wrong.

pseries_idle_probe() is a non-init function, which calls
fixup_cede0_latency(), which is an init function, explaining the
mismatch. pseries_idle_probe() is only called from
pseries_processor_idle_init(), which is an init function, so mark
pseries_idle_probe() as __init so there is no more warning.

Fixes: 054e44ba99ae ("cpuidle: pseries: Add function to parse extended CEDE records")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index bba449b77641..7e7ab5597d7a 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -403,7 +403,7 @@ static void __init fixup_cede0_latency(void)
  * pseries_idle_probe()
  * Choose state table for shared versus dedicated partition
  */
-static int pseries_idle_probe(void)
+static int __init pseries_idle_probe(void)
 {
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)

base-commit: a6cae77f1bc89368a4e2822afcddc45c3062d499
-- 
2.33.0.rc0

