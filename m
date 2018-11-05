Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D35C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B020B20685
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJidsjYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B020B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pkKY3tkVzF22r
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 07:09:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJidsjYe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJidsjYe"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pbVG6mmJzDrPv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:01:26 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id z17-v6so4353983pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3gYZRtrbX5ghD33CiTpEkdHxJdZHVlkk1o9milWK0P8=;
 b=KJidsjYesKTgUnD+WRPbdFJRD29hlmroinWgPNnzT5eAqQdcs+HPBcV5OcZGh9pSPo
 LlQvA6eqg4S/wmgpK5W9aNMpFFFXRXBElTsSd5l0ktygpFApR2neMCoBdRgX8VM8sqqN
 iQ65iV54BISJkZfd/vJ9bT5UfE5Q+O2zQUVUGkE/EvaHw3IThjtbqkDuNrBHv56lLM6T
 qfVu7wtDX50eZxK0pXJQfC8oPwrlWo94aeVFyEjfyKeFrKjUZgHiodbmKixvKBTPsDU4
 7eNkOrxslhEIqlIykf7SPo5cO9UwMl4Mozus3X8+YyoYhvouHOCUxadhwIn4oFBBSP75
 9zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3gYZRtrbX5ghD33CiTpEkdHxJdZHVlkk1o9milWK0P8=;
 b=PLF/M2LBWzZ6ZoileeL0W/CqkVlaDEiUYVlrlh2eqm+QSsY4AcYXz4Cc7PbNCjg9Uj
 9mx2F/5TvghHdKlOMTjm063vs0dLNbywTnDt0r0CQe63Jos3IuExwKt84hj6EFzQiZ18
 0i2BCuaZWWOpBaLhms10dTOlbvHtKVZt9X3tV9zllUR2OkSE814p6S9C9OslEt8D8V46
 vdGEA08vKddnC0A9z0w8+BfH5X2g72gfOfqGVtXZcwgTep5IU1f7CyJ4UZZliBU139oh
 2mQCgf9XyHEkK3zjl061l1v0mbDOydLNbuH2q3Ox+VPjSep7xx8szWo8aHUlC2bC8fqo
 7zpg==
X-Gm-Message-State: AGRZ1gJB5+6dDItD3q1sWf4LLj8sDAbOUx7WFBcP/e0ShpNxIEKy6a96
 XNxArGc1qmxEBIIc3yoeErM=
X-Google-Smtp-Source: AJdET5cWmP6/esTv8Nh5ylAho4fdMs6Ow0hq+m/befBtj4M+euxQPeXHTf4WU53eyCeIPPLFQ5ftBA==
X-Received: by 2002:a65:4049:: with SMTP id h9mr20159224pgp.304.1541430085070; 
 Mon, 05 Nov 2018 07:01:25 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id n87-v6sm55558608pfb.62.2018.11.05.07.01.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 07:01:24 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au, msuchanek@suse.de
Subject: [PATCH] powerpc/fadump: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Mon,  5 Nov 2018 10:01:19 -0500
Message-Id: <20181105150119.6452-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-Mailman-Approved-At: Tue, 06 Nov 2018 07:02:16 +1100
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a711d22339ea..2df5e04b5afc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1531,17 +1531,7 @@ static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
 						0644, fadump_register_show,
 						fadump_register_store);
 
-static int fadump_region_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fadump_region_show, inode->i_private);
-}
-
-static const struct file_operations fadump_region_fops = {
-	.open    = fadump_region_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fadump_region);
 
 static void fadump_init_files(void)
 {
-- 
2.17.0

