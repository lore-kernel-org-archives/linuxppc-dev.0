Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CA606EEB4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwY1dU+q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKWrB0M2Nz2xf8;
	Thu, 05 Nov 2026 03:59:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793811561;
	cv=none; b=TnColteuudKrsubbF/5Z0SFKD+qH1bQJV+gx1WKLuSpkvRNct3xDGEjmkt7t5fS+tX18spydiKJyIbVCTwDYC5lXSOMcS6kiuetZzzvJ6z4r/jgvoI5lgTL5X56ceYoi5/NfoglPopVxMqIIMstDDUFEqoupIpqGVQOgzdsbinzY03UftjQyAEZj26Fg29rYyigJc4dznIlZTO+D5gStaw0IUjjWZ22xq4m4LHza+AtoHq+7E/D+sZBuHuHQpWQjgMUqpC7WnrmgutOpMjdB1buMHJ8VlHbTeHgG7xvZIJIuxWOlTIO5U4Ep3j04zhUKMd1oPJOlYluuodhx4FVtng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793811561; c=relaxed/relaxed;
	bh=UvNnba0EFtPx2Ttq4iUvrOuj/mWd3NJj3S/pP9tLcH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6TA/oUttrLcjhJykK63mVYEKfNQ1usvs38Xl5g4kukiFeE8trlmh+K5TEcfdG5WyjPzHzPoE2bqG+fFRLk2VmDtT9NQnl9q9DXvqQkmXvjhmHMWAsDgi0sJpMLSX9fWOkzg7Bk0LSvjUm1iIpVjfZea8Oek3Sq0mIttKjn5G/m/HFd+S2prGyMf3sXiet4R3p5WpVMJcViMUu5i7KxX7yK2QHsBqeOWd28oVJWlmqOzp3pWtGCBk5jn2IA+9RDge/5D9Ya0H7JbvJ2jgLlqQtWP5mL5IFAAz8WGtTLNvWRCUyTEmcXk9Zsv0kQO+VXaSroCCPxhjlSKiO0Y24zMAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwY1dU+q; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwY1dU+q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKWr92Wkvz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 03:59:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F3F241644;
	Wed,  4 Nov 2026 16:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87EF1F00919;
	Wed,  4 Nov 2026 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811558;
	bh=UvNnba0EFtPx2Ttq4iUvrOuj/mWd3NJj3S/pP9tLcH4=;
	h=From:To:Cc:Subject:Date;
	b=gwY1dU+qAqq5USLQTWEwbIJPYNEIltc4K8e7ccLLeB56qwfVFpA8C9z4TDRsX6mpv
	 harkVkIRnR5EwVQzUSd3+sUO+o95GcDlN5yk3FFn8ngnlrR1N/46OhVWGnVRbYJ+Mx
	 2jwjXbdtB1Gdt//kkHsUoLHDCFs7hO4tmPcmGij1XJYTf8q1sOg8KE4GRbbH36V6pl
	 ipF3/zhN62XKfmQFXMrHH0KxjnKJNe/L+BsrL0X96XxWCKbQFAK5f5Sk9wl3TWMueh
	 EZwoN7Li8wIpoermYTwArOnLKsRFIFLsuP7PWVKzVxhbU1+5kzKfEhaQ2lvAbCNUoN
	 Elw1amSzfPWDQ==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sysdev/tsi108: Remove redundant 0x prefix in tsi108_setup_pci()
Date: Wed,  4 Nov 2026 17:58:55 +0100
Message-ID: <20261104165857.174285-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=blum@kernel.org; h=from:subject; bh=sIdgCzeQJuWgAZs8h8jZbRe5apSi7L4o6ofhxV6hh+I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvU4IubnslPW2KYtSBXWcTn2w642/Antp1x+rzpjcF7 fW1zJqBHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRh+oM/4uynnUbrww67bTB pefIpQ/Gy7Z+2NvY/yiP5+asdPtAPQuG/yFzAydY75v+uiVec46/qE/8lbU1kncuCK36r+cUub7 ZmwkA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The %pa format specifier already includes the 0x prefix. Remove the
redundant prefix to avoid printing 0x0x.

Fixes: 55d8bd02cc1b ("powerpc/sysdev/tsi108: fix resource printk format warnings")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/sysdev/tsi108_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 07d0f6a83879..dcc5e3e85dbd 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -217,7 +217,7 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 
 	(hose)->ops = &tsi108_direct_pci_ops;
 
-	pr_info("Found tsi108 PCI host bridge at 0x%pa. Firmware bus number: %d->%d\n",
+	pr_info("Found tsi108 PCI host bridge at %pa. Firmware bus number: %d->%d\n",
 		&rsrc.start, hose->first_busno, hose->last_busno);
 
 	/* Interpret the "ranges" property */

