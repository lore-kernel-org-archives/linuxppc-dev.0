Return-Path: <linuxppc-dev+bounces-24916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C5EC53209
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 00:49:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8H156Y9cz2ygW;
	Tue, 28 Jul 2026 10:49:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785199785;
	cv=none; b=UzzrbH/JqAMQlIVnssLJ18nw9AEiLhDhLfmtqPYBEyf4cAqWb+dK+JeH2ZErqjBrvoTuYyUmckOUkUkvsTnxXm96t+ohnD501PZnZ0QAHsxOikvhAYz7CCUYXqBTSNT7j2ahg4jEypLsrWNVQ4Ghe3pSHyiKrzLFvf4SEZ7svtQMG+BBklENaZaJ/+LYbUSJqK/jyFh8o/wgb2D+/Mssz7EOSvBVVxGXLz/vyyTYPunMw/VeqMmFaL/1phl6OXpH+vtofUGHZ+ld57ZiCyc8sGQviLLvYMoibZJxp1ACufWdTgPhIYdwJlgxOzVIC/PWP/Pp3odkcYfM7/bIHewPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785199785; c=relaxed/relaxed;
	bh=yBaqld3TmYtpvcCuMNwP5V/ALj/CVjmTGKnWI1UmjDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+vZxt+Kk9rqIaFBBKNseNFxvpfe6+rUAemJglxjKGFqfzZ7lNv2M1bKNiFOO9x0zXYAqdaW4o3eF+cU4X7FiIVY1+RoodzaYJ6PbrOBivOPpeEDOJeFj2GYYf+9qHz4FO3pt7GsXKHzml+pLq+xwY/fJM+9Poc0NnaQze7cM68m0K1tPt4wt3yit++tVGDn/Ue/txwe5Shwl4x6uNCt/e/7NJwkegRxuWS+G0oiutOYHXlg+HvmQXDY94/4UNKv3Ek/ObQhVw6RVoE/o8XMc7t+1Fk5TJ9gsoO6B+Z4/oqG/TiRzp6cD9tb7WIszXqByOACgMkwXrZmjR8/zKP6Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RwR9nACB; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RwR9nACB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8H0x2Xjyz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 10:49:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yBaqld3TmYtpvcCuMNwP5V/ALj/CVjmTGKnWI1UmjDo=; b=RwR9nACBdDIdNGYz8AJfkJ9wNP
	zNje5gNVL7GftJklvgXD17k0lxo3sG8jQa8pj91xxbU1uiCo05bDlWs4td88JepEmDzr70lDe/1fL
	ejKM9qIlJI4y6aeVE1kj+x+/KDEw9CJTC3y1t5IbvlGsVYDWpwd5ZmtcZ7zvEXYh8TzcHFabYe3oP
	OnQmG8Fm26v2Y7MCxsxgvQxnMN3TJr8P56YfO4OuNsYANkT9gzrfUDFattr/iMg6F3kNa4ayL+EQ0
	sU4vdrytfqDHhXK9jIXpMSLtRcwVDbq+vi5OljqGG2S0ntaV9Tq0QfF8g8joWuClruCTB5EWtcP9Q
	+Vcdntuw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woW0a-000000049Wf-3dcl;
	Tue, 28 Jul 2026 00:49:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: [PATCH v3] soc: fsl: fix kernel-doc warnings and typos
Date: Mon, 27 Jul 2026 17:49:24 -0700
Message-ID: <20260728004924.904210-1-rdunlap@infradead.org>
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

Correct spelling of "list".

Fix a kernel-doc warning by describing the nested structure completely:

include/soc/fsl/dpaa2-fd.h:52: warning: Function parameter or member 'simple' not described in 'dpaa2_fd'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Guanhua Gao <guanhua.gao@nxp.com>
Cc: Roy Pledge <Roy.Pledge@nxp.com>
---
v2:  update Cc: list, rebase
v3:  rebase & resend

 include/soc/fsl/dpaa2-fd.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- linux-next-20260727.orig/include/soc/fsl/dpaa2-fd.h
+++ linux-next-20260727/include/soc/fsl/dpaa2-fd.h
@@ -25,14 +25,15 @@
 
 /**
  * struct dpaa2_fd - Struct describing FDs
- * @words:         for easier/faster copying the whole FD structure
- * @addr:          address in the FD
- * @len:           length in the FD
- * @bpid:          buffer pool ID
- * @format_offset: format, offset, and short-length fields
- * @frc:           frame context
- * @ctrl:          control bits...including dd, sc, va, err, etc
- * @flc:           flow context address
+ * @words:                for easier/faster copying the whole FD structure
+ * @simple:               struct for the FD fields
+ * @simple.addr:          address in the FD
+ * @simple.len:           length in the FD
+ * @simple.bpid:          buffer pool ID
+ * @simple.format_offset: format, offset, and short-length fields
+ * @simple.frc:           frame context
+ * @simple.ctrl:          control bits...including dd, sc, va, err, etc
+ * @simple.flc:           flow context address
  *
  * This structure represents the basic Frame Descriptor used in the system.
  */
@@ -497,7 +498,7 @@ static inline void dpaa2_fl_set_addr(str
  * dpaa2_fl_get_frc() - Get the frame context in the FLE
  * @fle: the given frame list entry
  *
- * Return the frame context field in the frame lsit entry.
+ * Return the frame context field in the frame list entry.
  */
 static inline u32 dpaa2_fl_get_frc(const struct dpaa2_fl_entry *fle)
 {

