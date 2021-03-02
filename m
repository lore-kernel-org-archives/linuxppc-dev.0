Return-Path: <SRS0=PW48=IB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA4CC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 05:28:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91DD64E7C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 05:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91DD64E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dr2Zk49Lvz3cZv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 16:27:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rFORUmuo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=nathan@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rFORUmuo; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dqp9b397gz30RM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Mar 2021 07:08:51 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40A9964F21;
 Tue,  2 Mar 2021 20:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614715728;
 bh=+ZnFHkCt4vxwdfNeetS0nLlA+jw/GbxPFD8wsnXzPjE=;
 h=From:To:Cc:Subject:Date:From;
 b=rFORUmuoN8/sw1fsN52kQIk1QPdI3scUBNK3k0XmymgtXQ5xFn2NROK7ivr4YxPO/
 1eTkyWWTNkjLInsdr8IhmoOHXsuTpbBx/9M4WL0McXGVpD6Hafo56Kv6LT8ipAvIs0
 b2SiRYcRPNQqY2eSit6+3UGuGsf1qSXwGlaYFSJf9CWWl66sWRu/WGSS28vIXtFo3h
 +MvJuST3FMaXUIx1z+fhSSHYL02hvAjPcKgeatebPykL24rjKs1tq1WhLshXJh8xYd
 KqUSN2kvYRBJ18Ub3QEtjr1jW8JDg7Il7ja7K6z6bxjDxOAm97nh/cHMTQSqWj4PwN
 zfC5dn8pWeOSQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/prom: Mark identical_pvr_fixup as __init
Date: Tue,  2 Mar 2021 13:08:29 -0700
Message-Id: <20210302200829.2680663-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc0.75.gec125d1bc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Mar 2021 16:27:13 +1100
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
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 clang-built-linux@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If identical_pvr_fixup() is not inlined, there are two modpost warnings:

WARNING: modpost: vmlinux.o(.text+0x54e8): Section mismatch in reference
from the function identical_pvr_fixup() to the function
.init.text:of_get_flat_dt_prop()
The function identical_pvr_fixup() references
the function __init of_get_flat_dt_prop().
This is often because identical_pvr_fixup lacks a __init
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: modpost: vmlinux.o(.text+0x551c): Section mismatch in reference
from the function identical_pvr_fixup() to the function
.init.text:identify_cpu()
The function identical_pvr_fixup() references
the function __init identify_cpu().
This is often because identical_pvr_fixup lacks a __init
annotation or the annotation of identify_cpu is wrong.

identical_pvr_fixup() calls two functions marked as __init and is only
called by a function marked as __init so it should be marked as __init
as well. At the same time, remove the inline keywork as it is not
necessary to inline this function. The compiler is still free to do so
if it feels it is worthwhile since commit 889b3c1245de ("compiler:
remove CONFIG_OPTIMIZE_INLINING entirely").

Fixes: 14b3d926a22b ("[POWERPC] 4xx: update 440EP(x)/440GR(x) identical PVR issue workaround")
Link: https://github.com/ClangBuiltLinux/linux/issues/1316
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a4797d1d40d..a8b2d6bfc1ca 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -267,7 +267,7 @@ static struct feature_property {
 };
 
 #if defined(CONFIG_44x) && defined(CONFIG_PPC_FPU)
-static inline void identical_pvr_fixup(unsigned long node)
+static __init void identical_pvr_fixup(unsigned long node)
 {
 	unsigned int pvr;
 	const char *model = of_get_flat_dt_prop(node, "model", NULL);

base-commit: 5c88a17e15795226b56d83f579cbb9b7a4864f79
-- 
2.31.0.rc0.75.gec125d1bc1

