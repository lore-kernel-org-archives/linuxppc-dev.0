Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE007ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 16:02:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6004E2081D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXtNNfbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6004E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42p0tv0kGvzDrDg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 03:02:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="vXtNNfbV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vXtNNfbV"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42p0pz322FzDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 02:57:48 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id f1-v6so4594698wmg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A/vc8w9bIzubG/6+g3lUpu+GraSJf1qwC/xuf1KPdsg=;
 b=vXtNNfbVHjEoEWYHpgkgxdFu4/a1kBeQO+8EvhVmVXFeQwKBVRcAi660X/KvRnj0gg
 sTy3q1+9lj1dozdF/j5oYt7OQPLsFjdj0PTDuUpHhBqctmCj+NEB6Jr1SKEcbxP+Wq2H
 TpZWe3Z65uSVSLdwshr9LoZ1R0vfbfaRdq3A1Lg1xnm5Q4hd4kLij1W+0PtGrKx/9kNt
 udTb7TSFYszI0/SwM2XQQzbOKZOam0FBKsW4eg7hU0LFAw76prHte/vgUfTEgUg3aqDe
 lewj7FjsrbnodDZgchkr+cTYBYgNJ7UlZvOnT02xU9YmSMBIWu8JBnSaNTz4o+4TFGti
 ed7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A/vc8w9bIzubG/6+g3lUpu+GraSJf1qwC/xuf1KPdsg=;
 b=KXBZlhccgG1RPS5I+4LO/e2temncK6g42sHjqqoZPXa6cLqnGCjWXIsZRCYBmMveWd
 2sxOD85UgfRRGh4uFh0L10PyiBc1RRjsUm0Su7SEJ+aAXlEpwABcUE7vtOeCZmaArUay
 IEvX+atljK1ORYyHUdZXVRzIILqKl78x6lztX42kQHQjI9KsKlG1MBRbo0b6xvsQzYvf
 0xcRaxHq9yMo+dxR8iI0dZIgUDahW+Tw1m9ELq+QbjLVjRso08+x8hBDnjU1H5nLI1WY
 FRIEr6SppaF7nB6IiS8AwdhLAVmB18Ygu3+PDiH2oPlo0jqo6KaTcvhSGJNCEQPH4VtP
 02gQ==
X-Gm-Message-State: AGRZ1gK2O2kBHW7a35dyrWvaOcU5xWCYhy9cbBZWHDroMucj+aIlrnKW
 hJcplxzPM+Y7kB9+Foz9jkWdqq+N
X-Google-Smtp-Source: AJdET5eTlPjz7pNXJ5fX7fpDCQVkWoxrPusIJb/DzZmLNAwT8Tk5fdlhn4noVlIU7nQcCcjW5KTlDg==
X-Received: by 2002:a1c:d181:: with SMTP id
 i123-v6mr3609684wmg.124.1541347065651; 
 Sun, 04 Nov 2018 07:57:45 -0800 (PST)
Received: from debian64.daheim (p5B0D79A7.dip0.t-ipconnect.de. [91.13.121.167])
 by smtp.gmail.com with ESMTPSA id v189-v6sm23763635wmd.40.2018.11.04.07.57.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 07:57:45 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gJKmW-0003jY-5t; Sun, 04 Nov 2018 16:57:44 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] ppc4xx: ocm: fix errnous "failed to create file" errors
Date: Sun,  4 Nov 2018 16:57:44 +0100
Message-Id: <20181104155744.14310-1-chunkeey@gmail.com>
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
 arch/powerpc/platforms/4xx/ocm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 69d9f60d9fe5..4590b4d82969 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -289,23 +289,28 @@ static const struct file_operations ocm_debugfs_fops = {
 	.release = single_release,
 };
 
+#ifdef CONFIG_DEBUG_FS
 static int ocm_debugfs_init(void)
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
 
 	return 0;
 }
+#else
+static int ocm_debugfs_init(void) { return 0; }
+#endif
 
 void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
 			int flags, const char *owner)
-- 
2.19.1

