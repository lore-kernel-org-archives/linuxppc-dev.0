Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADE606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WYuD1bYg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFwR83pYqz30WS;
	Fri, 30 Oct 2026 07:13:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793304820;
	cv=none; b=mk3Wwb2TGn6nn44EV15Sl5RoISRmqaF/Y/e8c3GwalnsTB6/etvwrZ2NlCV5qs9BaWfRcuzdTBdKUJBmLdRYuEQljd0YRPIErfHtW+sUj0+WpQ7hXnHRdLC2jq9/7hvWbGO0kFtT4QAfpndM4lKYksUfXrOfqaL9BOOJ3xmLDkJBuG6pfVln3Fwn3KU4/bNnUEyxg80VJe8r8PzrmmAgG4M7mLHe9+9Jn/RqH3CE7AtzebiEe5UOmskMFq24Lnv88wtVAszkfr1RYitjf8QruHfZ5NnQzMf3SlHdAQOeDkDI8X0wWSzfj+YLkPFF2lsWZX5AH8ZsZILbvlSMo6STbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793304820; c=relaxed/relaxed;
	bh=OvHBVNFEaIP23Yj7JU5FUqxkZwdHXB2TgBTrhq4CMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1MArVh1mbGidLuszSByQUhGEcBBhzAAxFyYpriy93FscUS0uGY8Gc/8rI2MWm6iAJPbxDQWjC+lRgT81MPjCCGryveC1Oe42Rs7Qkl5Sz1e7emcJrr35sP7NZo7KTqP0Un8A9BCBvIL8Hcol7v5KIIyLBxwn1T++BXX0z3d0f0b/SB/yZj6i6w4IOZrArgwZF/mlVz6jFstsFHCFY5HYwwtiarc3Ui0elIaXSEoG4eF91GO76AOQa0dADTHZpfpNRq+G/S0HS0KFxzWs5XEdKMlXJ258cJ7C4gN9HjdhYc/n7lS8DIAOabuyUCMMjTFH2BGSAvUVUvS3bWcWE0w2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WYuD1bYg; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WYuD1bYg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFwR165Brz30NF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OvHBVNFEaIP23Yj7JU5FUqxkZwdHXB2TgBTrhq4CMzI=; b=WYuD1bYgTITEbQ4VQyRCaWMP9i
	/7BTCdaBvtBEwGO4CLiWbb8F7ahELZrP/EdHfGvAagZI4bJmINRCsmagdrm8Ws4cdsihwO08AaZJR
	OiDpZ3TbnSNldds4bYj4NovAQv2gm9eGspttc8zX9M7P/+BE0yKv/v5h8aG3qGxGCYYLFojqq6upm
	HF3xKPx4m1I99GYLPlqVvsrYS+5/nPqgR9hgbohjuMyc3dbP1TJ+hlmKbfQ7NPn4pTaaBKnVAD/Ur
	V4Ht2xl5sThXvqtp76mko6osx0qXo0Uye6eUJEhG5Zrdy+KjG0auuFMxjypuUOGX3M6smJT7xfcWt
	T6F/cmpQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWV5-0000000AJR2-1fmX;
	Thu, 29 Oct 2026 20:13:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: patches@lists.linux.dev
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc/ps3: repair some kernel-doc comments
Date: Thu, 29 Oct 2026 13:13:22 -0700
Message-ID: <20261029201326.2672284-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

