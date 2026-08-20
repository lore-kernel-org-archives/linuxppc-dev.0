Return-Path: <linuxppc-dev+bounces-26018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E48C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:12:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQkPq16Bgz2xT6;
	Thu, 20 Aug 2026 23:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787231567;
	cv=none; b=anMNEHuqijt5RXLLyyc+zVAZoRktA6/HxbLqPtTeUylxyllIFB3NzJ/CoJs5yO7WVwxgc/ljPn8QlT/G+hEqfSli5QV+vl3VGzp8XD4SAVwJNAQcVeewrhXV9F2s/fbaCgYEfe84Ywfkb9ctvgzaEVKZDB36xrqAYqsq4XY7YqAEcZEoXuoOZa33KuOK+FPatIBI+6ng6Ca0Lpc0mdrLnwSD87hpiWUlPhk4rQPl3Ny3fS9QseRRlZC3QO14WPTG2FfMI40eD0/IEgu3O3JNfrHz5L2Eado7FiFrEuWF5Mg3sbd4LBURayQIpCCHEnaEmh2Efu4e6baYuWafv6Y6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787231567; c=relaxed/relaxed;
	bh=dJh7R0socmEoqo/IMHpdxGQe33Oo99W+P9AP/twAzOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0+9tZZ49zOPMdMSLLG3mr1oGQBdTP5B+UQ0RgG7KUPsHqyH6rX5MFinfJgSO+YrN66MN0WcBnRQdyIrmFZT39p2E8kWSoGS03wtP0jstly1D+yZuEueBtOgN7NeEI7R9A69a1+bgyVITtdeDVavFQgxUDWSs2z2/cJmTnwy5+rY3E4so70f+QGzMCZT0DT8NGwyiXLa67QMvu/sQbSeAfgVF88xhW+igNwQBcAevSth8lJmXlTm4Mg/Idac1X2eWxsTbKlL5MZmnyX7ouz1aFRZVY74NAWj2vAYn5PGdjzmPKft08ztXN9gGzS01lDtCQfnGi6noG2jshEVuetF1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Yc77xth0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=J4tXnGMV; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=ailiop@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Yc77xth0;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=J4tXnGMV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=ailiop@suse.com; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQkPn2G5Bz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 23:12:44 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	by smtp-out2.suse.de (Postfix) with ESMTP id 49F583EE2;
	Thu, 20 Aug 2026 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787231551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dJh7R0socmEoqo/IMHpdxGQe33Oo99W+P9AP/twAzOM=;
	b=Yc77xth04Yi8lE058M/W/o8ks7+eg2OjDAJh0WxZXeGzRyX5i0hM5t0jMzWcE9W/I3ccUo
	9GUFQ/wPnRMedxMCJRFAFoDllnnTIn3fw85WiEUWMcyKacFdIPHCdsarBYHPDF9tKcotLv
	7obL57WeyaQVfshkA4oZjXD2FYs52GM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=J4tXnGMV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787231547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dJh7R0socmEoqo/IMHpdxGQe33Oo99W+P9AP/twAzOM=;
	b=J4tXnGMVRWlWcz8YiewbGZMS3GpzJD/tXvow3lnbr934hvPu8vYMQp3xnBVx+qQ17SMQr1
	cEqsCoN5SGwl6yFvdKMtFdzZJ6V4c4GzgjnddmmULxpGphNtHpMHmffMU52g/3e/tFTnTA
	D1Jj4G9gcKqABu2W3zOd9+E+Qr1QrIM=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove unused profile.h includes
Date: Thu, 20 Aug 2026 15:12:22 +0200
Message-ID: <20260820131225.13848-1-ailiop@suse.com>
X-Mailer: git-send-email 2.55.0
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
X-Spamd-Result: default: False [16.65 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.96)[0.985];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	DIRECT_TO_MX(0.00)[git-send-email 2.55.0];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:helo,suse.com:email,suse.com:mid,suse.com:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_ZERO(0.00)[0]
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 49F583EE2
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam: Yes

None of the code in these files uses declarations provided by profile.h.
Remove the unnecessary header includes across the various files to clean
up dependencies and reduce include bloat.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 arch/powerpc/kernel/irq.c    | 1 -
 arch/powerpc/kernel/irq_64.c | 1 -
 arch/powerpc/kernel/smp.c    | 1 -
 arch/powerpc/kernel/time.c   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 15a3c3fd8e70..4483aa770966 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -41,7 +41,6 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
-#include <linux/profile.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
 #include <linux/radix-tree.h>
diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..8c8890fd227e 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -33,7 +33,6 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
-#include <linux/profile.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
 #include <linux/radix-tree.h>
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6a5a5469aaae..196d184d1651 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -29,7 +29,6 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/topology.h>
-#include <linux/profile.h>
 #include <linux/processor.h>
 #include <linux/random.h>
 #include <linux/stackprotector.h>
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 11145c40183d..b21bf4914876 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -41,7 +41,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/time.h>
 #include <linux/init.h>
-#include <linux/profile.h>
 #include <linux/cpu.h>
 #include <linux/security.h>
 #include <linux/percpu.h>
-- 
2.55.0


