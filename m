Return-Path: <linuxppc-dev+bounces-22988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4CBCDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:26:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmN1l0klKz2yjR;
	Fri, 26 Jun 2026 01:26:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782401179;
	cv=none; b=EBKkNeKhQXGb9sy0l84DptJMicPF1RYlfWkrzuNQchYfgpA0eGhQq688dS6siooigP2nYdjjKnMoeASD4MS4m8H5DAAqyRx11PH5xAMBDpRvvFxT3d9GFkagHpAlzt0qSYLPPFsmjCpb7LxJmxmUquOPkC/iW28xJ04etaNfuahF/7+jnKYQPw6HEu/VdwVgGEKp8UM25+py2P4TULKolIjBL2Nuqxo/GkPdr2pqiCw6/OjVsYbHzjzYDKlftHV+1ElBfR4RGe10gjVEF6wqdKtewF1euzgFsuRmY1mpdRTh/c8Zkw2ns0cRp7v+vk87MISib/m7RI37924YlpGHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782401179; c=relaxed/relaxed;
	bh=e2kzugiSXXnut0MG0Ah87pWfEVTXT2Cv2TcVn0+5PSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjRZoetIVqs/k9SDV/YDA8tk4DpFj1BOEphHPMayinwRAGHANZKV/6tGmN0vJPhsbqmPucAMSXgGX83R8qa0lJkMTGSZEK42d+f2uN54P87kooJIgb23YfSVW3+vBI3KRLKjEO2OwMeF6NSA/qMtKpJmz2akyYRrMIlKAF1wu7KuTj9JeKjsr10hG57MiIlEhvAoIIzFUZUZJpefc07mVo7rRbVobpJTEkWhDkMxquWDm49nPlX/0bFT5Vtj6DAXXSxPn7iJLWRIYa08MivsS4ldjKY2wSm8R+NHCldyp+S2xBww3LQuq1xyoGrENB6DagfJUtnAzBwj2aLaKZKdNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YFhd5dPT; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YFhd5dPT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmN1k1WkPz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:26:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401176;
	bh=e2kzugiSXXnut0MG0Ah87pWfEVTXT2Cv2TcVn0+5PSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFhd5dPTDSDDJrKklU0G5nPkPXm+iR2wnftu3mjt06uv6wxB6N1YCkOea+ceeTr8M
	 tihriFpyrZgqelD1OjbJvS1CHLuAsk2IrKHK9dQ9+U4/Id+bHv25FyT/89ZjV+uB3H
	 LeIxqI+GwlEBceJJLmMpfY9u549OAHIpQlsFzCsE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1h0QX6z10tb;
	Thu, 25 Jun 2026 15:26:16 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1g2dvRz10v9;
	Thu, 25 Jun 2026 15:26:15 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:58 +0000
Message-ID: <20260625152558.7450-5-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152558.7450-1-include@grrlz.net>
References: <20260625152558.7450-1-include@grrlz.net>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
other CPUs. Do not ask sys_info() to handle that bit again later in the
panic path.

Use sys_info_with_filter() so panic_print=all_bt does not request more
output after the CPUs are stopped.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..eb842823df61 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	sys_info(panic_print);
+	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
-- 
2.53.0


