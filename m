Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FF606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Sb3Pw2gN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc53N2Chbz2xlY;
	Sat, 28 Nov 2026 20:44:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795859072;
	cv=none; b=C0fSq41EGCB9EJZGMQZ0Ck/WF6tVKF3ptHmDacryseTsyAEtytNyvnBWFue9MCIVinjqtf1S8gES3yqiOtk99seXhY1NlckVNOTfhp0GPEYTnsCj1vJJ5R8Gc8XsqLhVv6iPybaJFAWLrwASQ83Z8C65/V2vAWOjhp8vTrJOeD3ShiMPDrI/MK585OSKxz5ffTYd3JPw69hj3pvW/n6eb3lqTplnGzkmELgP1pm7OvM3zcSQousNHHpG6ShSbIIeyo246+Xd3K2lHo//PjeYcemznuzr8hx1ml9DiuQOKWGlXLcI7MR0oNC3QN/6DCJDyA27rRk9tr+7TkXq+DNnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795859072; c=relaxed/relaxed;
	bh=UBNhwdQi35Qenxcrl4OCdRSVXW7qlIuKj7dqqQeQ1CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ43EBuRMHz+mzxwyXZ/qvDV1nJHW1KAgKWA2ttBGTG65sO9XoLiR69WLAvIxnuOOcgMRmaN0/tzqPjjg6qL+Q2MLDs0dzwzdykP3qvG+57Ox8qNOhxGDthesTcmJpW3wsuTgE3NbQwfABcp0vo2RuZE27QQlzzX7DgbcLldZMEbMbRLqbYQVuIRMcsif0yIa8wcMJZQNpYjve59FpBKdehjB6Nyf0mrEoy9TkNvYvhlOeTK0w1TFs7uWvv9kKrTikS3tvgSqqfbJCwJcq/1aOu4gTuv1/mMoZBvujP70nh95C5uWgKCtnzNdGKN6YAQFSuaytPBiD1Pm06s4l5X1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Sb3Pw2gN; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Sb3Pw2gN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m155101.qiye.163.com (unknown [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc53J5512z2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 20:44:23 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655b0832;
	Sat, 28 Nov 2026 17:43:52 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Keep the CPM interrupt controller bound
Date: Sat, 28 Nov 2026 17:43:50 +0800
Message-ID: <20261128-f81b700d6c-u36-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa2218a278c03a1kunm4e783e69451f12
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx1CVktPSRgeSxgfSUoZH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Sb3Pw2gNNlEVCxWVpu21rVH19ukLrzpRhw+qYuq6uGSMHCJy9wHb66LHy50OF9V8+XfZ4cV5/vrxvJObqzQG3Z1TmSTRI+rapA+7ZqxxIIH0xzSsWrJ2rmMBRa5XCQJm7t++HKBDPN6hu8MZX3xXx9DvZhPRUdmIT669MSB6Prk=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=UBNhwdQi35Qenxcrl4OCdRSVXW7qlIuKj7dqqQeQ1CY=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPM interrupt domain and its parent cascade remain active after a
manual unbind releases the controller data. Disable manual unbind of
this built-in interrupt controller.

This issue was found by our static analysis tool under development.

Fixes: 14d893fc6846 ("powerpc/8xx: Convert CPM1 interrupt controller to platform_device")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 arch/powerpc/platforms/8xx/cpm1-ic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index f9b37e098728..01c1b8095bde 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -134,6 +134,7 @@ static const struct of_device_id cpm_pic_match[] = {
 static struct platform_driver cpm_pic_driver = {
 	.driver	= {
 		.name		= "cpm-pic",
+		.suppress_bind_attrs = true,
 		.of_match_table	= cpm_pic_match,
 	},
 	.probe	= cpm_pic_probe,

base-commit: a772118ace8f1e53b237f550a38b92348a2666a5
-- 
2.43.0


