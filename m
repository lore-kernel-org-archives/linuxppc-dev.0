Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F16C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 14:42:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122182081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc5em9/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122182081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qC1K5N6jzF3D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:41:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vc5em9/n";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vc5em9/n"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qByb17wNzF3Cv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 01:39:34 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id g59-v6so6290394plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SFU/Z5qoWTfk9A6p33abSYOx6uOlq53OHyZ9STh41bs=;
 b=Vc5em9/nXIzzjBhEcBnEZR/6i0qu6qCOM+da4aYJXOK+UgmFEYBaIvwx6JxqBJDlBb
 gxczpqaP/26+MyA0JveRXw0tsLfxMlt1NkjQqT7bEaAzI7Z4sJNHuaotI73DB6aVtZfh
 gjWf10DTo08E8b6FOui3GjKzXJNgUqad8WC37XlxDXfMzXfLFhAhTXNSJUtGiu84FE5N
 BmcvNlmiMS6uHHHmIKansTGOLUn/se2nXzffMM2Z7rLqSklsEGDiURZuPFCgd7v3tm5s
 G2/bjvzEhAsFV3e+CoktW+OEMUMHfHxYwIpl/izb4WiPCn92q2eDQ8HsaND59mB7uRg7
 9SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SFU/Z5qoWTfk9A6p33abSYOx6uOlq53OHyZ9STh41bs=;
 b=mtOkEJ4zH2yRa2edvsBg8niYY5J9u/KHAqUjDgkKiNXpfoKszswLYOOiv+K3rz93kX
 efXz54zthqb/yLA0+JPZRuZPRSOJ3oiOquOQInURTVtXKpbPVaY2Q72PCetXUGEjb0P4
 KG4sFKyYRq+qhsRPolFa9Kk5IyzaJas3OO6OG1AR+QMU+4UblSp0IOK37Iw32Ehcfl0B
 wLYL89+q/3IhSBCtn9KXdOerfLKv54dVkB79JDtEFVZl+1LHr8Kh1pSaKlH6r1w6H85k
 saR32v/pbYTLvDAVflxLvusHS9BAios5p70MAuOMr6fWPC+sbetUWK7EFTc8shIpbQ13
 LelQ==
X-Gm-Message-State: AGRZ1gJohjTJZNt2EFEIdmKqpkRbZHINoSBFpHykiM662K93U755hEaU
 lXidOro4S/v8s6p21flUNDw=
X-Google-Smtp-Source: AJdET5fydtralHS9H673Op+hIecAiP5w6xNVsn/OrsGUAjISukUnOQSIuLRb6n1WmmhD4eiAWUebmg==
X-Received: by 2002:a17:902:20ca:: with SMTP id
 v10-v6mr27077351plg.182.1541515172906; 
 Tue, 06 Nov 2018 06:39:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id b75-v6sm55261913pfe.148.2018.11.06.06.39.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 06 Nov 2018 06:39:32 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc/vas: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Tue,  6 Nov 2018 09:39:30 -0500
Message-Id: <20181106143930.8604-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
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
 arch/powerpc/platforms/powernv/vas-debug.c | 28 ++++------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index 4f7276ebdf9c..4d3929fbc08f 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -30,7 +30,7 @@ static char *cop_to_str(int cop)
 	}
 }
 
-static int info_dbg_show(struct seq_file *s, void *private)
+static int info_show(struct seq_file *s, void *private)
 {
 	struct vas_window *window = s->private;
 
@@ -49,17 +49,7 @@ static int info_dbg_show(struct seq_file *s, void *private)
 	return 0;
 }
 
-static int info_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, info_dbg_show, inode->i_private);
-}
-
-static const struct file_operations info_fops = {
-	.open		= info_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(info);
 
 static inline void print_reg(struct seq_file *s, struct vas_window *win,
 			char *name, u32 reg)
@@ -67,7 +57,7 @@ static inline void print_reg(struct seq_file *s, struct vas_window *win,
 	seq_printf(s, "0x%016llx %s\n", read_hvwc_reg(win, name, reg), name);
 }
 
-static int hvwc_dbg_show(struct seq_file *s, void *private)
+static int hvwc_show(struct seq_file *s, void *private)
 {
 	struct vas_window *window = s->private;
 
@@ -115,17 +105,7 @@ static int hvwc_dbg_show(struct seq_file *s, void *private)
 	return 0;
 }
 
-static int hvwc_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hvwc_dbg_show, inode->i_private);
-}
-
-static const struct file_operations hvwc_fops = {
-	.open		= hvwc_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hvwc);
 
 void vas_window_free_dbgdir(struct vas_window *window)
 {
-- 
2.17.0

