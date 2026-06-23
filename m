Return-Path: <linuxppc-dev+bounces-22933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BCCCDB471
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:35:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl8K56lzHz2ydq;
	Wed, 24 Jun 2026 01:35:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782228921;
	cv=none; b=ffyvm9ZpKxYycYvYGX3/2osxcR3e5yc54Yl9MoGfjt3cm5jzheneiGTVAXkg6LOU/53HdKfAcxt2eCn5FbDN9ne5q4obE0LZVdCUdxGuPwQgWINLnQ0TFEWA0DlmdaPsjVPMMl1bZkXz85nGTXodWt9rcSyBLpgoX7wAjshzWtB8IGrz3uAjhnNzxbzY8WK1oCqk2xHfUZ1EMNody0JsIwAOxfIt3+7wdafpVSnKxKF1TYrAYdNT6SUZHolxgTo8YxY4PFm9gml3nMRoGRas0cEl5ckodU2bPjTeZKMzIyC7yh8mLJlGayO/ol3Mjlxi8jTtb+Y8YTPMFcR/FCQR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782228921; c=relaxed/relaxed;
	bh=Gx2pxVFTVh6CiezPzsu7vQ1YDNEI7j7XBUAxmNRT16M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrciIroYejKJtj33xccWoVcNVyBquAuFoG77QFh1HHZnspAeaZN4TDvsQT8K43eJb+fI1nFPqihHw5kjD0WCdLeOqKEHJo5gcxIRL3yRjyHorTl3NKGqSuUkMwXyqrzl8AHmQ+PeSGowVXA6OmBFJYtZy7qxavejnIJfCCmQtuitigLm7qw6bBEtkm54XftFWsJMDjWJl4ldqQGFbjilcHZddPX5+hu+RddYFHAD9FZyHCN7qzmFhBk72zbeQNsGwEYtm3yu76M22kfcFxrFTfRRhNslNcDWWLqaJcyePVU/JH+Kk0yYZg3X4ml3Ny9GbJRt4gJqD6yOLH+D+0absQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=DzVafJmD; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=DzVafJmD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl8K20Wgwz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 01:35:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228907;
	bh=Gx2pxVFTVh6CiezPzsu7vQ1YDNEI7j7XBUAxmNRT16M=;
	h=From:To:Cc:Subject:Date:From;
	b=DzVafJmDrIL2Ee0agTEXJ/yol2TdqjBOjmeM80UFaT3xcqRDsatfgEpNhiACGNcsu
	 mdwRzS/igrFv4kKvVQSECmZ+HdckiXhaEuokSSf1/xYiuC4ig8AdC6/YRCN/VqknAO
	 Fl1zQpg2i215l2vwuD2p+Ak8oJd9e1n9ttff1Wkk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jq3zc3z10x8;
	Tue, 23 Jun 2026 15:35:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jp2CN3z10xZ;
	Tue, 23 Jun 2026 15:35:06 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 1/4] sys_info: add helper for callers that handle all_bt
Date: Tue, 23 Jun 2026 15:34:58 +0000
Message-ID: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
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

Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
Add a helper that strips that bit without turning an all_bt only mask into
a kernel_sys_info fallback.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- New patch for the shared helper suggested by Petr.

 include/linux/sys_info.h |  1 +
 lib/sys_info.c           | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..87a841ec7b6a 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_without_all_bt(unsigned long si_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..6afd4c697633 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -164,3 +164,18 @@ void sys_info(unsigned long si_mask)
 {
 	__sys_info(si_mask ? : kernel_si_mask);
 }
+
+void sys_info_without_all_bt(unsigned long si_mask)
+{
+	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
+
+	/*
+	 * Do not call sys_info() when the caller context required only
+	 * backtraces from all CPUs. Otherwise sys_info() would fall back
+	 * to the generic kernel_si_mask.
+	 */
+	if (si_mask && !dump_mask)
+		return;
+
+	sys_info(dump_mask);
+}
-- 
2.53.0

