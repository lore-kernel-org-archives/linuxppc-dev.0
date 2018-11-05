Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7107AC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:07:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E4720685
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMmsPR9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E4720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pkGp4y4fzDqjx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 07:06:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RMmsPR9h";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RMmsPR9h"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pbB66NM5zF12F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 01:47:26 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w3-v6so4320137pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=YGDbV8M6ZQhO26iEMemFlbnzNSn4SXD18e12/JLSXVs=;
 b=RMmsPR9hjn8LPbtES6bav82LC1g5/WYwn+HoicDgDaSIIbVrcehduVS0JWuXyjJJMy
 SRU9xgFrAYeeob3ZB7zUY/l3g7TLeDIUgqoIVa/aldvD1V3Q13znsx1OsNXAFXX76699
 LmGKn550c20qKejouedYZaFyupx7MDqUfeK0qPDhJL8ZxUMOfR/hcNKgSEqpNVDQr21f
 4kazinm0bBZb0w8K8AtXrTBcAtYrCw/PlDUGN/CRgqxV2A7yGD6Qy616xfdxlNjYsD/h
 /aqLz17morRx0/Lrfu6nEWCq4fJgQGbeElDb/3jdzLiygI8DUvH9c0plRg0sZSR+nlwZ
 LPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YGDbV8M6ZQhO26iEMemFlbnzNSn4SXD18e12/JLSXVs=;
 b=jmuLBJXIRHsOYPaLRpRzYVBg3Yigu9g3bhQ8fYad3610CWIRwGVPnzwQt8aIwwahhC
 cYKtRr20bbgnMkuxbxqpTrhNTpK1qF4W0m01emznatK1STA+plmodyMETOa0TGu1NEYH
 tNY934mxi6pGS6PpxC9Rh2S62kRXiL4WBgGdQUuNC8zjmBCfN05hUr8nfHZHODf7iIaa
 SjCBtORwFB0BfeWa3lTGEO4SFvk8XXccSXp8B/Ia16CiIWyqIb+l23n7c+KN3bCUQ7dg
 W01qAd2Hu92nrnJUdMTHB+MoP/pTuZ+P03EAQX9vz+Xi21vdAqoSpUV4/y4wrkDYVuDA
 aTGg==
X-Gm-Message-State: AGRZ1gLaN7FSdA4fIJVDHNzobbmnGi3FNacwuMlOMD7qm1gyCYahtHUy
 l2K8hJvgnZUUyUyE8eaiCr8=
X-Google-Smtp-Source: AJdET5eUcLJ+GtS+SNLmCHoE/gL2bJb7EPSmgPl24XzdFchd55UlHeIdmha17HQXvuyIdNFRQRIFmQ==
X-Received: by 2002:a63:194f:: with SMTP id 15mr6214161pgz.192.1541429244750; 
 Mon, 05 Nov 2018 06:47:24 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id z14-v6sm50956027pge.47.2018.11.05.06.47.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 06:47:23 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: paulus@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH] KVM: PPC: Book3S HV: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Mon,  5 Nov 2018 09:47:17 -0500
Message-Id: <20181105144717.6233-1-tiny.windzz@gmail.com>
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
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/powerpc/kvm/book3s_xics.c | 12 +-----------
 arch/powerpc/kvm/book3s_xive.c | 12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index b8356cdc0c04..8fdc8eb77039 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1017,17 +1017,7 @@ static int xics_debug_show(struct seq_file *m, void *private)
 	return 0;
 }
 
-static int xics_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, xics_debug_show, inode->i_private);
-}
-
-static const struct file_operations xics_debug_fops = {
-	.open = xics_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(xics_debug);
 
 static void xics_debugfs_init(struct kvmppc_xics *xics)
 {
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 30c2eb766954..57ef1502a52c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1905,17 +1905,7 @@ static int xive_debug_show(struct seq_file *m, void *private)
 	return 0;
 }
 
-static int xive_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, xive_debug_show, inode->i_private);
-}
-
-static const struct file_operations xive_debug_fops = {
-	.open = xive_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(xive_debug);
 
 static void xive_debugfs_init(struct kvmppc_xive *xive)
 {
-- 
2.17.0

