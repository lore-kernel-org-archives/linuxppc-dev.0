Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C3606A683
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xV/y32E+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYrNl5Jjdz2yCr;
	Wed, 25 Nov 2026 05:06:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795543607;
	cv=none; b=d7bSODBw/HauuzYbn+UDyjIhWVYyt6mNe7mvZhPoX+4DyZLfUT9k/8bcBkStZ28dfIe1J1N4V+bRAGYv/Bfglv4rTMm5HRXi1q1mihWBJr/IiHcyT8kWR0viATf9xJsyQ8B9U6ez1ApTP1Gmj3iBPrPSlIU5z2qwd45n/BR4xBjGXQjvVlsPTQrLNHdlbtqrooJCwJTRhbPZ+zUtdtEA//6hji0lcL/9AHZGKlFb/7M8x3rvSdChFJok/PeL8AmPW5L8qgye9JXHED3HLwG2L4+UHpwkl57/U0vjCJofGq+6aKagntM8/OZKfNhEsxvgrNWIyucDj02K1IRy8DbZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795543607; c=relaxed/relaxed;
	bh=deq7Ule0WS6cCDkhEqiCXra8h/v0qwBkiJPpoRTzVqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGCKwjT35puLXuLYc39C5er46BXwwtoR5UPm+sojTvHwDjxeH5RjWphTuyycnlW2xeWEIxwawtMVMuRQ952urMOYbLfGa+3XQXQ8H4WSKzAmA4Zf2QPB0wiZ42nJZYY5YNA/pOX8k6lCloaQWGYv0yF952HS5T4ohFtWzOXkUqUl10wpsqQ+tkidhcoAeB6qAFjnR9zYfgjNJtodrPJGSukaargwpLTMQbFsAokDUE7Oido9gIjF78ZSY2K1829asqIdoF6e7Vg3TwFerkWgnKdlP5o7pfZE4WKocIQik99jTmp/33O2T2CwKC43JUl03qSxkrBVyqOi59k42xf7Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xV/y32E+; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xV/y32E+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYrNk52fFz2yCP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 05:06:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=deq7Ule0WS6cCDkhEqiCXra8h/v0qwBkiJPpoRTzVqA=; b=xV/y32E+Tzd80haa1CqxPT1wXJ
	rSCL5SQ9v4S8q6COId6sa5pMr6/ZZqjG1SKldjGS6946QhDDrI68U+5G4PbrEMj1FZis1seIGd16x
	RiBl8KJo14PfHUUmepYbBksyHFrXEBUjghdNhKuFaq9rdQTZ4URrqIW/8dFxEtFlFEVX7tAQa43cc
	u0WjyMqRz1uGDrUi68oIEvXniT2Ako5SUk1ss21xyIMNY5icgPJfKeWczVcXslqKru4y1LtFcVrvI
	8KuXIhfVewhpFo5ZMDanxYxpSRG9vs6VlGujiHCkHwdygh9DN9ZVkS3cjBPVW2v63CnJxzlfhxfMA
	4XWjXFtA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVuuh-00000007SYt-2X1a;
	Tue, 24 Nov 2026 18:06:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v2] macintosh: ans-lcd: add missing MODULE_DESCRIPTION()
Date: Tue, 24 Nov 2026 10:06:42 -0800
Message-ID: <20261124180642.2867269-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add missing MODULE_DESCRIPTION() that is now required since
6c6c1fc09de3 ("modpost: require a MODULE_DESCRIPTION()").

WARNING: modpost: drivers/macintosh/ans-lcd.ko: missing MODULE_DESCRIPTION()

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: add commit that requires MODULE_DESCRIPTION (Christophe)

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>

 drivers/macintosh/ans-lcd.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20261118.orig/drivers/macintosh/ans-lcd.c
+++ linux-next-20261118/drivers/macintosh/ans-lcd.c
@@ -202,4 +202,5 @@ anslcd_exit(void)
 
 module_init(anslcd_init);
 module_exit(anslcd_exit);
+MODULE_DESCRIPTION("/dev/lcd driver for Apple Network Servers");
 MODULE_LICENSE("GPL v2");

