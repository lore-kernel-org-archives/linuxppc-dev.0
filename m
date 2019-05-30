Return-Path: <SRS0=Y6lA=T6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF1C28CC0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 10:37:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C4825758
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 10:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C4825758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45F3t24xgxzDqT1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 20:36:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.215.195; helo=mail-pg1-f195.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F3r54vy2zDqSR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 20:35:16 +1000 (AEST)
Received: by mail-pg1-f195.google.com with SMTP id z3so1767010pgp.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 03:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XpKc7tFp6ByDXYCLUrBtR5YS0+nVh9v5o+pDFrcL76o=;
 b=axUBenzoiSCN7Z8eci4C0ggeL/ktg7hnqSQh9N3+ZeIfIp5WOSYc4/irOIqnWbbMCb
 Caq9mYfJjSK2HGRpqxH4xq0rvh71TFVVD6go0Fo0rJKnZFr2gAh0nNOquVAV1ZfnqO8X
 I2Zd18zsYoniSk1EEexS4VnE/jurQZaXW6sxyzX7sFn0g+0wzsO2VSFC8GLtiucNnOCu
 RF5ThQ/p/VMLgbZShlQR84bncZwPzOQM1Qs0cfkF42DHqceKLZReU6IP8zWLvNU8DdX2
 uQKovdJLjDhF65WpJ+0G/pT8bHnA/uC+hdA8diy5YlCIO16fHGFJ0hAOFS3tgZwo4n8p
 ghdA==
X-Gm-Message-State: APjAAAWSNf+VmjIvlq//CNxLxiikt/10MTgYc8JGZCvGYYZPf8cmcUUs
 PW1OeF1zSDIsW0yXF7aNBvNqOvgYHrY=
X-Google-Smtp-Source: APXvYqxl057OqJfi5DEVOLi7UxawcQprYXyRjAiooA0z0i3duRhBHciN+C6qJbZDcndhT4dB2CYEuw==
X-Received: by 2002:a62:29c7:: with SMTP id p190mr3003996pfp.218.1559212183940; 
 Thu, 30 May 2019 03:29:43 -0700 (PDT)
Received: from localhost ([122.177.146.171])
 by smtp.gmail.com with ESMTPSA id p64sm4352239pfp.72.2019.05.30.03.29.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 May 2019 03:29:43 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Documentation/stackprotector: powerpc supports stack protector
Date: Thu, 30 May 2019 15:59:37 +0530
Message-Id: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
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
Cc: inux-kernel@vger.kernel.org, arnd@arndb.de, bhsharma@redhat.com,
 paulus@samba.org, bhupesh.linux@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

powerpc architecture (both 64-bit and 32-bit) supports stack protector
mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
add stack protector support")].

Update stackprotector arch support documentation to reflect the same.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 9999ea521f3e..32bbdfc64c32 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -22,7 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
-- 
2.7.4

