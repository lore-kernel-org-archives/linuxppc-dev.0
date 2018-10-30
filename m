Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4667C6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:54:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DF720664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaHrOuNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DF720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kwy76zktzF1Ph
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:54:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaHrOuNj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=tsu.yubo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaHrOuNj"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ksZr5JlbzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 00:22:25 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f10-v6so5560276plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ZX25RBS0K0zGBNNwI85JRx7aiFM3svnHk/4qU82CIr4=;
 b=AaHrOuNjnMLy6zinBnhx5R3wWOognmxuVQjVyjSquApDYa594r635V5lLXGqQGdy5I
 GGnhQXKTpA5CCYKpJO4FsYR1mgH4PXTWH2nrcKn3CqosnemseNIn+xJIpNaxDf0oCvNz
 vm31b5e5R5wtTQXUlDfSB1qH5f0j24rBTxzQ/WD1lWD21mq9hr84myNyfIbCMUK9A2Mn
 Jrp2w7sjrDd68RR4QMwzZSmVxlMlC+SwIF9hMreSdx1nZxo4gs/RQkreUxUtaQgkX6fo
 wz2rJ0nbp1f/ss5C6B50i9fWGWax4Jrh+PTtkxQ6lGYQG8chzFKU2LohOSWY50RpzpEF
 66Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZX25RBS0K0zGBNNwI85JRx7aiFM3svnHk/4qU82CIr4=;
 b=c1L7lwwkwewgZdY+yyix6vzipPs9LgiJZ7+/N+KuW60Q4wnFmsxhCIumMlVaC707WH
 NO4BHcws1MP/A03R3CGbnRgWATf7/bgc8cvyJCBW7BmeWL5aRthX1pEpH6ug5rob+ENt
 E+ZZL0Bi+55btN8V46a6CfNlcDT1XaIkS8KbfRw1E4D5JSAsveBbiZW3bKQt3U0v6fwn
 qMR0imCo2QbX+vW5GCTm6Yuwdj8p2FiWxsjuZGRywPuYTqZ9LBXokb6qMze6N5tWuRNW
 ojH/W1qbE3AF83X+5BRjN7+iAZsDkI/M9Be+sIC24krs29+4URqGIKaElnOJjMlXORg2
 0xcg==
X-Gm-Message-State: AGRZ1gLAeBkHdknj6ZhLcP6uHZz67iMZ2waUVgGLxKxoqw/fzZNMjiqY
 qiXJeqvzSE0pj9R94UPmKeA=
X-Google-Smtp-Source: AJdET5eW+SZrYa+BrKRhEZ9hE6939oamm2r04ock8KPSG1UWi0DNBUWbSXTgrXImazZcQ1xdonlg7w==
X-Received: by 2002:a17:902:a5c3:: with SMTP id
 t3-v6mr18820570plq.287.1540905743465; 
 Tue, 30 Oct 2018 06:22:23 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
 by smtp.gmail.com with ESMTPSA id b11-v6sm11765566pgi.10.2018.10.30.06.22.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 30 Oct 2018 06:22:22 -0700 (PDT)
From: Bo YU <tsu.yubo@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] arch: fix without checked-return value with lseek
Date: Tue, 30 Oct 2018 09:21:55 -0400
Message-Id: <1540905715-4266-1-git-send-email-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
X-Mailman-Approved-At: Wed, 31 Oct 2018 02:47:32 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, Bo YU <tsu.yubo@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

lseek should have returned value but we miss it maybe.
This is detected by Coverity scan:
CID: 1440481

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 arch/powerpc/boot/addnote.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 9d9f6f334d3c..3da3e2b1b51b 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -223,7 +223,11 @@ main(int ac, char **av)
 	PUT_16(E_PHNUM, np + 2);
 
 	/* write back */
-	lseek(fd, (long) 0, SEEK_SET);
+	i = lseek(fd, (long) 0, SEEK_SET);
+	if (i < 0) {
+		perror("lseek");
+		exit(1);
+	}
 	i = write(fd, buf, n);
 	if (i < 0) {
 		perror("write");
-- 
2.11.0

