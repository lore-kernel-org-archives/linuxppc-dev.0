Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97527C6786F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 16:19:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAC820831
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paFdzoIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAC820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jjbp0236zDsGm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 03:19:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="paFdzoIC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="paFdzoIC"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jjYN2c44zDrTk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 03:17:08 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id i17-v6so6019764wre.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Oct 2018 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RP7Y0mMKKL+Z3nvPIV0FGfNKzh5IlEUogIOnE6k5x9o=;
 b=paFdzoICOJTdChWo56mIreHnq4KP4Qsv2tQ0m+50EMJLzU4DarWPMKMpdZh98+KOvA
 pgvjX4gqOGODl3SgtjR0Zgf1xIPw+NA3dxRvinXJdgcPfGix9bkIGW87YmyUW8/F01G/
 hKU+2gNyDZfoD7NPovV5IzEE2soyQ9zPpUog6jOoMaPLxGtXeoWBbc99CbPUxlD6qLE2
 f+DbsZWzmjKgB2UpkQN5OCOVz+M9eCc47AE2xBFBYxNhnfMnjB+QunjxLL9x5vloNaoy
 +hixqUMBHtA2amLE8ZmAw3wfcIwUH9gNCHIryeqYRA++OxybKnNT0rYW1Ii+4jy6yqMQ
 rhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RP7Y0mMKKL+Z3nvPIV0FGfNKzh5IlEUogIOnE6k5x9o=;
 b=cmqIU9S+i502dQEW8c1Pt5I7BXt+bxzzyqZlUgSUf7I9Be+1lpNsC5XNc/KZ6UCh9t
 g3BAZUMQ3NtJxHsUiyA2H9KkxvrKXp5KMYP/TYNX/hAXcfMO2feNtUOupdH06rdpCGWo
 ZKysd+VycF+4fqQKlRv60fvc+Gg+coh8oLMEI5xEWMIKikuFeMJx2/7prjmsHpC1HX+9
 lx+JGTXRXhhpga/RwkZizZxkM7xA5+TNpspytsT8fN1AZJHvqzd5EAqyzkaYeyoGEZzL
 rGsQuWsSawxcUag/GM/gXayLUSUtb9sI2SnnauXrKpZb9UtxHsNkgMCxMbtyHNfy6hdM
 tsbw==
X-Gm-Message-State: AGRZ1gJvW2i3f7LH1NygX+nAO8e+3DaqyUq4+Zwnqj723jpUuVfK1WCN
 BF0jB69eTLTMT13uSh6ClL+XIcnW
X-Google-Smtp-Source: AJdET5eNPLZlJl/uSlB/JWed1K27dSZl0awUOxQvD3cOG/D8tPmD7w1Flr6iSMGWtWtnL9/A+VNx6w==
X-Received: by 2002:a5d:67d1:: with SMTP id
 n17-v6mr2230655wrw.245.1540743424307; 
 Sun, 28 Oct 2018 09:17:04 -0700 (PDT)
Received: from debian64.daheim (p4FD09D87.dip0.t-ipconnect.de.
 [79.208.157.135])
 by smtp.gmail.com with ESMTPSA id w2-v6sm25215965wre.57.2018.10.28.09.17.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 28 Oct 2018 09:17:03 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gGnkM-0002Qk-NP; Sun, 28 Oct 2018 17:17:02 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc4xx: ocm: fix errnous "failed to create file" errors
Date: Sun, 28 Oct 2018 17:17:02 +0100
Message-Id: <20181028161702.9300-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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

Previously, the kernel would complain:

| debugfs ppc4xx ocm: failed to create file

But the "info" file was still created and working. This
is because debugfs_create_file() returns a pointer to a
struct *dentry on success or -ENODEV when debugfs isn't
available. This patch fixes both the debugfs_create_dir()
and debugfs_create_file() check, so this will work as
expected.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/powerpc/platforms/4xx/ocm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 69d9f60d9fe5..e616c8636303 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -293,13 +293,14 @@ static int ocm_debugfs_init(void)
 {
 	struct dentry *junk;
 
-	junk = debugfs_create_dir("ppc4xx_ocm", 0);
-	if (!junk) {
+	junk = debugfs_create_dir("ppc4xx_ocm", NULL);
+	if (IS_ERR_OR_NULL(junk)) {
 		printk(KERN_ALERT "debugfs ppc4xx ocm: failed to create dir\n");
 		return -1;
 	}
 
-	if (debugfs_create_file("info", 0644, junk, NULL, &ocm_debugfs_fops)) {
+	if (IS_ERR_OR_NULL(debugfs_create_file("info", 0644, junk, NULL,
+					       &ocm_debugfs_fops))) {
 		printk(KERN_ALERT "debugfs ppc4xx ocm: failed to create file\n");
 		return -1;
 	}
-- 
2.19.1

