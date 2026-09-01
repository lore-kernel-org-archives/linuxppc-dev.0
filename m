Return-Path: <linuxppc-dev+bounces-26358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62906C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:34:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYx0M6rvVz2yr0;
	Tue, 01 Sep 2026 16:34:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788244451;
	cv=none; b=ROCe/1JNURje/E8q0PHRWoIM7l5gfvKPThtksdyKkK0tpULEQfn5B6RrWIy68qoJ9c1MBr4aAfGt/iCroWRsY8ckSdrGw64I7dfBI1QQSM4IfXwnMfpaTnawWHIdCjF4C83Q5692spuFNN43EAmKmRhGz0K+ozGH91ZiRQFPcocJce/bqVuSmO0a5vGLIb5+bXfFPcpN1q7Zp2/3JcnlE/GTtsQPl0Jho5JZAHuHYYMQelkS7Gw/JtSAoQHSD/R0ySYXL4lNXtASPS7+m2G8wXY0tG5CZMH21mvcmo0qeW1k1Upau0JICtkPN8BzZulPxNSP0tUm0uQKr8yK4+8cIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788244451; c=relaxed/relaxed;
	bh=OvHBVNFEaIP23Yj7JU5FUqxkZwdHXB2TgBTrhq4CMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhYPG2a7tTd/zW7Y5rJyqGvZIFTAWfowQDE9CWTeKSM62urUYZQd+Jul057P6BVoYGxP7z6eBK8SoEXhezXTw35HyUJw7X88ZK+hbnFPw7tBrUga46NKRfnf6co38x3WsCtZj+upqW0IqcGUBW91xXBwOqxaovN9/B942FaRlr3lKS8g73cMzj/9muiqk+IOB6JWk8tMmhsFxcpEGasxhBJdvyutbizl3DtMyglXmzNkXu9/yDepH8ZiktijeGqj0hcZgE3yAn7W3EbzdkayjaE7aQQgepSC3I/w8qS6ZfUfWhQA7FmIwEA0JnyBumEbz/fT+Q2tRtEPoxiY/gAgdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dAlgz+j6; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dAlgz+j6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYx0C2WHzz2y2S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 16:34:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OvHBVNFEaIP23Yj7JU5FUqxkZwdHXB2TgBTrhq4CMzI=; b=dAlgz+j6AhRxtzIOMlWOp2fSJN
	CC2HCQNPpXYo7IzQHmZE0GRIoNJKpzrPYSH/gjbtbkUeP7xCqwc7eR4voJQIQd9Aho0HYx5VqCVX3
	zkpkQx8+5GoV4MtQxTSMEO8TnpdNFTUAbzIDtkQd9dqOs3C3JOMPZ6uvbx6cNfadTqRyyRTK4WzUj
	KdClrAjyeeBhIOFb7TK+M3/xqtksaqUw1JHaNm4XPzN6HWqD73HHSeKUx+fvp30YBrZRviYWwL45O
	Zo+y+kirMOfn30dTboBvMdT8c/VB6CGkWT0Sy6fm/835pl6PPV4qk6/ZxpiL6wmhUAkC/FAKARCFD
	tVWwnS4g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1I4B-0000000B46j-1box;
	Tue, 01 Sep 2026 06:33:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc/ps3: repair some kernel-doc comments
Date: Mon, 31 Aug 2026 23:33:50 -0700
Message-ID: <20260901063354.4012138-1-rdunlap@infradead.org>
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

Patches 1 and 2 eliminate all kernel-doc warnings in their
respective files.
Patches 3 and 4 target certain classes of kernel-doc warnings
but don't eliminate all kernel-doc warnings in those files.


 [PATCH 1/4] powerpc/ps3: platform.h: fix enum ps3_spu_resource_type kernel-doc
 [PATCH 2/4] powerpc/ps3: htab.c: fix enum ps3_lpar_vas_id kernel-doc
 [PATCH 3/4] powerpc/ps3: mm.c: clean up kernel-doc issues
 [PATCH 4/4] powerpc/ps3: os-area.c: fix some kernel-doc warnings

 arch/powerpc/platforms/ps3/htab.c     |    4 ++--
 arch/powerpc/platforms/ps3/mm.c       |   10 +++++-----
 arch/powerpc/platforms/ps3/os-area.c  |    5 +++--
 arch/powerpc/platforms/ps3/platform.h |    7 ++++---
 4 files changed, 14 insertions(+), 12 deletions(-)


Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org

