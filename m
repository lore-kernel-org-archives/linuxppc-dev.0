Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2F606A320
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pWwqCbOo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jX2Dc2rfHz2xlh;
	Sun, 22 Nov 2026 06:23:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795289008;
	cv=none; b=fw6bfFF+oLaSyfmdBhz4Vgq6csmQjmBipQf+PbNzAHtMn7ptb7lWMSaQac44oebQeamLuumvrVcHIKhkWEE+3ffY+GZZAVLK//PiYHyElzgi8o68dX1H9rHJQdHl2+PA9D7/274spKwhB/rsFN1nniYtnIdHhZW+X20vbk3Z79hWCr7aJ+EZwvkb7V/vjTOwYVrXaYj5JvHsOXXGfJKrhUIG8IGystmNhAAAqkHSLiM8tHndkBWfuV0Zpq2bbgM0F/Pzfx2L0evpMbZqBMEOSc5Pb3acg1Od7Ipb8Ldr9somhT4GnLypxJpEwmnuo6rvMHhkuZi5in51CsHN4ELtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795289008; c=relaxed/relaxed;
	bh=6bhYiTt8wscg2ZrolxCieoNLNuP/Q0vhDX28mXlNHno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnuYP/tKSltJlgw4BSvBtvBwXMFjGECnXTKIcDvDmEHJ+FMDby7z/qOfHphGa2jO6akrxQ87tL7HDcMDBb9rXvXxO8V/DMYx2jumO+xiOdeOSELUTvJNUw8qnGrfykqOxBwld45t/XIr3+62jlxmfmXCUFcINsXVoxkDQtp8KldZtRq8EsMzeDTr6tKpOAmTCdgKX4+hPL3YpCmA/UBzwOL7ydjrDpVhDdy2jkK9yA+IezwxsvT34vBH+oJrRjg+n7XxvELrj0CGo3oJ+M6RuvcpdCwzinwPLbv1Lv5g0ZcQsVn/xAQ4JkskoWKBM4Z0EGmtZ410f1zZLDOzjnlekA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pWwqCbOo; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pWwqCbOo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jX2DX2C05z2xQK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 06:23:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6bhYiTt8wscg2ZrolxCieoNLNuP/Q0vhDX28mXlNHno=; b=pWwqCbOoIhkYbup30GzLYz2SYP
	p9RJxKPtXyWQA7hX+VeNphIXgUR4YMwRKbu9F0eRZib5GmkoAiTeZkA8xAOXb5h0iHVlIl5RvxGIn
	MRRNvXnbkyj1WeP4QctPbVNveGI7SRvmtGU3ux7bMgdAXiZvHkb3xZNDvuLjB1NTVONDLyAJG9TB4
	YSImHhpdtZdW2GhpJSqjIPrX4mz1fLTsOgafJvc4gGkOmuCysI0aDHnahdX7yM9dBFWOpsMxvU2jg
	ajUzVtBbc9A60WzYLddn1OAGg6OyW/LNAJf/0KKtW+IuTeQCQIVr9RH4T5m6woujN2ks4uCLcj18N
	mFW088RA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUqgC-000000006jM-0gIS;
	Sat, 21 Nov 2026 19:23:20 +0000
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
Subject: [PATCH] macintosh: ans-lcd: add missing MODULE_DESCRIPTION()
Date: Sat, 21 Nov 2026 11:23:19 -0800
Message-ID: <20261121192319.930162-1-rdunlap@infradead.org>
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

Add missing MODULE_DESCRIPTION() that is now required.

WARNING: modpost: drivers/macintosh/ans-lcd.ko: missing MODULE_DESCRIPTION()

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
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

