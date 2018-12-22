Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C6C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:18:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381DE219FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp6PQWJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381DE219FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MNKQ6rS5zDqY0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 22:18:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gp6PQWJZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gp6PQWJZ"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLnw4KHVzDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 21:09:39 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id 96so7558326wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2WRYS1d5RWtrPTBi1Sn6CPUs4ZIBg49iQb6iZ47tMJE=;
 b=gp6PQWJZxrbxD5DeJWDCxnApILBD1kF6LWRbtMl96ExI6SawPtYLW98lGtG+UPYWAG
 W5ipTgT/mcPgKhasGh9NWRedtV1W9xdIyqzLYfpUy4PhUs3HZs+grTW4OFc0lrl1heIC
 OXzycizI4Nv//ePocZGJ6TPQtIBiJ8Oo+0DU/HZTNPnBLrpZrRZ6pgWSXpdif9eRnuqp
 ZRcCD0qE03nDSSfQGaoyHd80uY9XXASMTXmoxSzruBBimqpJ+bRF6VK/XwhcJaLr6nKf
 yay4GoSwFr7LBs3A3zWgmZF8nqlCZyMb/YznLM3QGWS5EabhBwRWwNRHjzU7IrB2TAGQ
 ea9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2WRYS1d5RWtrPTBi1Sn6CPUs4ZIBg49iQb6iZ47tMJE=;
 b=FfyvkaRs74n5zvyF+SLvezLPav0SGSfEEW3PquVNbJjudvUArAZltTxx31MUJkxv7Y
 uPomCpbVZEzAsf8ONR+qUWsoOCJRfV+KRBi3diqHKKZvP9xYj5x6CoanaLeH5TV7YlPl
 cj/fufzrwGX/cnD6lGEn0ndNmDjCWKdLKhfjay6Vt8THMRa5pIh2N08xWOB59D5yveRD
 Q6AbPHgbF4q19TDipqGsiF1IgtTzW7J7vRamKNo216DwtERPcMeMTKSXJ2VIoBqN7fOR
 Zf8Ibj17qYhb2x9jMQYUVj1vAn0UntoIj4SdyJNHPv5xL5mHLZ+lrvGTXyIPUaMyUUP5
 Yphw==
X-Gm-Message-State: AJcUukcuFuzHpzI+krdUfJzbqYC3v9gjRACZwDo2K83IeN9VuqkNYZHz
 DnikP5C7amiTgS71IXAro0b7Hy3F
X-Google-Smtp-Source: ALg8bN4FP1kH3P97KE3wuBWlMA8Qv+J/1pV/r+fHDlxaEk2pJfugn7/0SE9ogFN7U7262la1y8p70A==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr5986898wrq.133.1545473376326; 
 Sat, 22 Dec 2018 02:09:36 -0800 (PST)
Received: from debian64.daheim (p4FD094B4.dip0.t-ipconnect.de.
 [79.208.148.180])
 by smtp.gmail.com with ESMTPSA id j8sm26477189wmd.0.2018.12.22.02.09.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 22 Dec 2018 02:09:35 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gaeDu-00026b-Q6; Sat, 22 Dec 2018 11:09:34 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/4xx/ocm: fix compiler error
Date: Sat, 22 Dec 2018 11:09:34 +0100
Message-Id: <20181222100934.8051-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Paul Mackerras <paulus@samba.org>,
 Markus Elfring <elfring@users.sourceforge.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch fixes a recent regression in ocm:

ocm.c: In function ‘ocm_init_node’:
ocm.c:182:18: error: invalid operands to binary |
ocm.c:197:17: error: invalid operands to binary |

Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ioremap()")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/powerpc/platforms/4xx/ocm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 561b09de69bf..04ff69ddac09 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -179,7 +179,8 @@ static void __init ocm_init_node(int count, struct device_node *node)
 	/* ioremap the non-cached region */
 	if (ocm->nc.memtotal) {
 		ocm->nc.virt = __ioremap(ocm->nc.phys, ocm->nc.memtotal,
-					 _PAGE_EXEC | PAGE_KERNEL_NCG);
+			_PAGE_EXEC | _PAGE_BASE_NC |
+			_PAGE_KERNEL_RW | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
 		if (!ocm->nc.virt) {
 			printk(KERN_ERR
@@ -194,7 +195,8 @@ static void __init ocm_init_node(int count, struct device_node *node)
 
 	if (ocm->c.memtotal) {
 		ocm->c.virt = __ioremap(ocm->c.phys, ocm->c.memtotal,
-					_PAGE_EXEC | PAGE_KERNEL);
+					_PAGE_EXEC | _PAGE_BASE |
+					_PAGE_KERNEL_RW);
 
 		if (!ocm->c.virt) {
 			printk(KERN_ERR
-- 
2.20.1

