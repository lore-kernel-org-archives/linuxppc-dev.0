Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6090BC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:37:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D2B2147A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqpKJl69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D2B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pGzG6VKGzDqMv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:37:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="XqpKJl69"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pFNQ4K9xzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 03:25:26 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F0342084A;
 Mon, 28 Jan 2019 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548692724;
 bh=jrZzuc4k34f+c7tBM1X+krHhiGj3GRg7G+UAWtHJPHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XqpKJl69Sx8F/OESJN7x14QCeCvvZjgUzEnwFIfuM3dQkKWzbktsrux1ptsGbksrt
 aJNGs28gpzn8TlWhLY6H3/WyL139Tkzu/Sgwu9IrcWf9hubuZJmfKJ+5YFk6IWQSO0
 Guj7H1ktQel2Sv5jKH1sT+yUUMQdO+rMxC016t0Q=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 48/80] powerpc/uaccess: fix warning/error with
 access_ok()
Date: Mon, 28 Jan 2019 11:23:29 -0500
Message-Id: <20190128162401.58841-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 05a4ab823983d9136a460b7b5e0d49ee709a6f86 ]

With the following piece of code, the following compilation warning
is encountered:

	if (_IOC_DIR(ioc) != _IOC_NONE) {
		int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

		if (!access_ok(verify, ioarg, _IOC_SIZE(ioc))) {

drivers/platform/test/dev.c: In function 'my_ioctl':
drivers/platform/test/dev.c:219:7: warning: unused variable 'verify' [-Wunused-variable]
   int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

This patch fixes it by referencing 'type' in the macro allthough
doing nothing with it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a5ffe0207c16..05f1389228d2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -59,7 +59,7 @@
 #endif
 
 #define access_ok(type, addr, size)		\
-	(__chk_user_ptr(addr),			\
+	(__chk_user_ptr(addr), (void)(type),		\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
-- 
2.19.1

