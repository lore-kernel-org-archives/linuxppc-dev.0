Return-Path: <SRS0=ea3T=UJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E16DC282DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jun 2019 10:06:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D782A2082E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jun 2019 10:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D782A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45MpgZ5GrnzDqRd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jun 2019 20:06:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.214.193; helo=mail-pl1-f193.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45MpdK72MZzDqQS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2019 20:04:20 +1000 (AEST)
Received: by mail-pl1-f193.google.com with SMTP id go2so3440316plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2019 03:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VL7W9fZL6/Afil2J/mxLoXGQm5gFl+AhFAq1/FWfRX0=;
 b=K2pSnX5XD14YD8NH8GWFYGHk17cjQrB2uquUuKDHojamIQ/ucGyDKmbPriijDPXMsE
 fR1nUpTLQsVxDR4CbTZ6U8haGLtjyxFmxFvpZecPNK6u2RQn73iQLNmTETeD/0/tWwv/
 LjxkGGPDb3cJsi8gztIRvzRpMJ8of9QpKt95GrLXJZk1mWvmrp6wyiuwgbh437ie5gWU
 tDSGIs5/Vole44Ub9nct5W5Je75+UKDnitufo3FziuOmSFzvGoZMKM+rQbA9YTpDOO9A
 8ieHcTD/eYR65gT/TMTSc6JMFGlaJqf32Nbx6kHFSDZqByharRBSf7hY14GVedwXZslS
 6mmw==
X-Gm-Message-State: APjAAAV5YZ6MuoAPh1oxLJ5dt4iEFlInSsLYXfy6wdx43fyIIITB7mUc
 /yBwZMmABQ9T1oMWjsITMrANuQZHWcU=
X-Google-Smtp-Source: APXvYqzDr0J6ZRVKUD/yAIczeaILFdnQzJjOKMYBERKQCtn7Uet/99gmQt1F+I8Z8yK6peHQ1a6GTg==
X-Received: by 2002:a17:902:2926:: with SMTP id
 g35mr24078094plb.269.1560161057781; 
 Mon, 10 Jun 2019 03:04:17 -0700 (PDT)
Received: from localhost ([122.177.221.32])
 by smtp.gmail.com with ESMTPSA id p2sm5604993pfb.118.2019.06.10.03.04.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 03:04:16 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RESEND PATCH] Documentation/stackprotector: powerpc supports stack
 protector
Date: Mon, 10 Jun 2019 15:33:39 +0530
Message-Id: <1560161019-3895-1-git-send-email-bhsharma@redhat.com>
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
Cc: arnd@arndb.de, Jonathan Corbet <corbet@lwn.net>, bhsharma@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 bhupesh.linux@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

powerpc architecture (both 64-bit and 32-bit) supports stack protector
mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
add stack protector support")].

Update stackprotector arch support documentation to reflect the same.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Resend, this time Cc'ing Jonathan and doc-list.

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

