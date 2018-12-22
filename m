Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA799C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 14:38:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307F021B22
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQEkdn0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307F021B22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MSlc1qlFzDqcw
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 01:38:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rQEkdn0X";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rQEkdn0X"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MShv1rRLzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 01:35:42 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id d15so7772332wmb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 06:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SRF2HOXc8mXRYNmzPvFO4SQrYnTjCrYRu7gfmD606ys=;
 b=rQEkdn0XuVW1IRHk2j8Eu+x7gvx1y8BH4bJGq/pYwnD2m2Bu7eM6FkKXhfxxCF0TrA
 ElZlLCZvYMtss8ic8QFISkvmLXocMvAsM/SbYAyMnwEaJnZWeGrj9dcsPojNlHdcZALV
 oOntv4dBf8EETEKOJHZcsiOk+fI5speBISTS0BS7b2Kr+y6welkp4eQ9fjAa80rO8VHF
 I6b0HyZl8zq6VnbfPRJcR1eYHE6X6znsiKzjDqYeOr8ZmVZkzmPUqQk6WHXY8VL7/BR/
 LcpT4GEEgXVLSGq1BQQLyqi4eu3t6goqGTShSgY3I1YxEvBNqcKKcp4LXfnBcsaWHLQ+
 eN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SRF2HOXc8mXRYNmzPvFO4SQrYnTjCrYRu7gfmD606ys=;
 b=FwnclN6XC5PLG/u7VmxnzWVw749sTsF+im+oTzUZX35pTPqpyZL+Z+VU1Lwtbyp3We
 1gIzNvrcFwORYBC1KVBva2CmnxdvnfNiehFzh1kpVqV/C7shNlfVW6MpxkNvFYtHpO00
 GD1TdsEispIEk+8U6gIiA5Zk8jaOUENKKraS5/E1pa3+AWzMhMGOtX4zScaBWZXV9o2I
 YMyY2fbAzq1SWwS0Nj6YeAsF/TTcYiX4XksEYp3niNsl7yoKX8sbItKVSMFuuOPRa2k8
 wamAjReJF9rBjzecWwdDJ+kGtwD82hSZbXf+QLvvD3VrhlpVD8B35lZk1XRiZgTtcZRi
 4TqQ==
X-Gm-Message-State: AJcUukd5v3boFgAyX+elRpcNR4uZBsl9X4uUISeG2V/kXKzYN5IhrxWo
 1raPZhP9rrtOEmvSS4/axFZ7MuzE
X-Google-Smtp-Source: AFSGD/VFxrSkiZuAraGWDAB7Grb0IWxJ+BnZpthOB2+tjiZyY5YR7C+Ny6QMYHglt5kY/tgYOnuQnA==
X-Received: by 2002:a1c:934e:: with SMTP id v75mr6646222wmd.126.1545489339946; 
 Sat, 22 Dec 2018 06:35:39 -0800 (PST)
Received: from debian64.daheim (p4FD094B4.dip0.t-ipconnect.de.
 [79.208.148.180])
 by smtp.gmail.com with ESMTPSA id d2sm12080954wrs.97.2018.12.22.06.35.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 22 Dec 2018 06:35:39 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gaiNO-0005dc-BS; Sat, 22 Dec 2018 15:35:38 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/4xx/ocm: fix compilation error
Date: Sat, 22 Dec 2018 15:35:38 +0100
Message-Id: <20181222143538.21630-1-chunkeey@gmail.com>
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

This patch fixes a recent compilation regression in ocm:

| ocm.c: In function ‘ocm_init_node’:
| ocm.c:182:18: error: invalid operands to binary |
|       (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
|       _PAGE_EXEC | PAGE_KERNEL_NCG);
|                  ^
|
| ocm.c:197:17: error: invalid operands to binary |
|       (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
|        _PAGE_EXEC | PAGE_KERNEL);
|                   ^

Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ioremap()")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/powerpc/platforms/4xx/ocm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 561b09de69bf..de3565353153 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -179,7 +179,7 @@ static void __init ocm_init_node(int count, struct device_node *node)
 	/* ioremap the non-cached region */
 	if (ocm->nc.memtotal) {
 		ocm->nc.virt = __ioremap(ocm->nc.phys, ocm->nc.memtotal,
-					 _PAGE_EXEC | PAGE_KERNEL_NCG);
+			_PAGE_EXEC | pgprot_val(PAGE_KERNEL_NCG));
 
 		if (!ocm->nc.virt) {
 			printk(KERN_ERR
@@ -194,7 +194,7 @@ static void __init ocm_init_node(int count, struct device_node *node)
 
 	if (ocm->c.memtotal) {
 		ocm->c.virt = __ioremap(ocm->c.phys, ocm->c.memtotal,
-					_PAGE_EXEC | PAGE_KERNEL);
+					_PAGE_EXEC | pgprot_val(PAGE_KERNEL));
 
 		if (!ocm->c.virt) {
 			printk(KERN_ERR
-- 
2.20.1

