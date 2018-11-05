Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:05:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CF820825
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcRa1JFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CF820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pkCv57xvzF25b
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 07:04:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bcRa1JFQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bcRa1JFQ"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pZyv2Kl5zF15C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 01:37:39 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id s5-v6so4541537plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=z1zzkMTBEehskq2DPI3ZOQHaUdaoniARDpLAtPnVMgI=;
 b=bcRa1JFQfrDvxrCBswxmSbgeYFdHnqGGnLHq2506hoD518rVvfi+ArtX1yOrjsbBOr
 cKS4HHPs61TUaDKK7hcxEbfjeW/bO0GYRZtTTL7CEE2ZT48mdh81NSlaXTehVuVKrH2A
 aUC+SXnaJ5EQzeuG1htRreOwDDxM34/VaDgYrdpDhyXx/UAS9W2mUgvbPXrY/qlwRSXe
 Jf8QX+yZM3Iif5ZajdGd4heLQI/thOmMxfwWQ6U/BOTuLA9foA4fLBbBN6UOsGQ4lvfM
 HDmZf40WMracLCha0dmE/WtRdwKj8E7JkPiYKf3c6xT4jBbfIjUw/GXYFCYFa44UhT5G
 F9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=z1zzkMTBEehskq2DPI3ZOQHaUdaoniARDpLAtPnVMgI=;
 b=W9GaKCWt7n8pHUcXZlenMPpTqt+4xvaI1LW8LhAzWzQwMX7wYk8Ezf86dkAg7I+1+c
 W0faZHI0OQ09FtGSrWOpwoaF+/maMhSIVrIqOKS9msG3TinI/phfS777HvjEhECxOZjO
 UtYkbLNwb6QVGKzJRf2lbd/GU+ibpI/LZP/UQBE8FtxPvGcOU+dt79X+IFyPDUFtpwJg
 NqWUCdDOn/wjkSuKP6Eu4Vzim9ff4NDR/ZHZ7vHVFSIKJp9Bol2wv+kyzLrF2nbywYFp
 RcYAD2gHXoeb/kDfnpuurJnopqSBtOmEfxGUUlW1n56U7KMoogFQdGv9Yr1btLYPT0JA
 SiEQ==
X-Gm-Message-State: AGRZ1gL+s8O/16mfMSJ3SpwczDcT9YpdQiTloMuIsm48i6PdPg5rSiGM
 qM5PkqvCB+8GIL6Cqv9N62M=
X-Google-Smtp-Source: AJdET5eTxjVAXMLDVPHzELPZyCSMhaRrkGRajUG1ti+DRfkoiQVOCYE9rTqsYzy/8E/MQUnwlQ24GA==
X-Received: by 2002:a17:902:b183:: with SMTP id
 s3-v6mr21194163plr.70.1541428658045; 
 Mon, 05 Nov 2018 06:37:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id o27-v6sm57166297pfk.85.2018.11.05.06.37.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 06:37:37 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Mon,  5 Nov 2018 09:37:30 -0500
Message-Id: <20181105143730.6071-1-tiny.windzz@gmail.com>
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 sound/soc/fsl/fsl_ssi_dbg.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 1255dfe19eef..6f6294149476 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -124,17 +124,7 @@ static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int fsl_ssi_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fsl_ssi_stats_show, inode->i_private);
-}
-
-static const struct file_operations fsl_ssi_stats_ops = {
-	.open = fsl_ssi_stats_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fsl_ssi_stats);
 
 int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 {
@@ -144,7 +134,7 @@ int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 
 	ssi_dbg->dbg_stats = debugfs_create_file("stats", 0444,
 						 ssi_dbg->dbg_dir, ssi_dbg,
-						 &fsl_ssi_stats_ops);
+						 &fsl_ssi_stats_fops);
 	if (!ssi_dbg->dbg_stats) {
 		debugfs_remove(ssi_dbg->dbg_dir);
 		return -ENOMEM;
-- 
2.17.0

