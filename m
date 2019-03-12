Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAFDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 20:31:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873822147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6cNE8QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873822147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jmpb1vvhzDqCl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 07:31:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="L6cNE8QD"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jmmc0rQTzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 07:29:49 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id f65so4089947wma.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/5yG8xrfCpP8AB+WdyEFUE67Um//wbZhauRqrSkBGpU=;
 b=L6cNE8QD+qEBKws6bZAaEVinKJ1VVxbO1qPA3PBrNNvRbU90kbcvzC6vVVh1+VbESy
 FfuypCxd64kfwIJVmPXlOpds6n3NhsCuP82VomKxVKNMs8nLpMDv082zuIk0UdbOR+mr
 0IC35LnmhKC9onZohXgZ0bWbAjsZjXm/Bh7ofG/KmL3y+8c+wzWKlWAFpWr7uLdCpwGr
 kU9t5wAORHPMpYM1lbaW0r3q7Ia3luZlbhJOqRL6E56bh48w4ZBUFtFw98KT3OKZAbJ7
 vjSRdYHiu9pPoqnuS6EKTYENzE2APjJSr2r3FUMf9ETcNOrB28QrTz6DU9+yQDlK5G9A
 SO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/5yG8xrfCpP8AB+WdyEFUE67Um//wbZhauRqrSkBGpU=;
 b=cq59sf5WP/vp08i+Q7jUoRwOXtDAmevys3ElT/oULL4aWXjtovCz37covNx/2lvjCl
 EeI556u6qy9N2mFGNdP5fyaNJ8C3pC0ssTDWrdA16p4L2uZ+RiUmYy/BUgmBhL71zbNM
 +MW8Cu0+TomWsQa/6ubamA0Iersfa0s32e9tKAs8+MHlwP4kLNz6xXrGzHCXBR9D5u+2
 7XaGDdPSUpIkEiOmO0Wm7kvHOQIAXwgs5MwYN0dcB4KLy2JF+fRDw8ytwnsijGHuTMpD
 190dpPNwUl9GbWtz53JcdXlaCheTT3bVlE3fX5ZmBmfT+YjbWTwqKUyNLZ9nqNQfmZEY
 W7OA==
X-Gm-Message-State: APjAAAXQ3kmmJnQjBP0JRUT5t/OBRm4M1rynwNIazoOzDRgMbRpOV5W1
 ZB/XsxCiTVxQmATi4vfjnXOHFOnY
X-Google-Smtp-Source: APXvYqzs2iziP211uDkoWkpV/g3fhBePYhwRB9XVcbxz1lD8Q/I0onk5LcEOT4yHRDVN28BFoyYdtg==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr3637853wmj.126.1552422587333; 
 Tue, 12 Mar 2019 13:29:47 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id w14sm16242504wrr.18.2019.03.12.13.29.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Mar 2019 13:29:46 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id BD0E611465D8; Tue, 12 Mar 2019 21:29:44 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/64s: Mark 'dummy_copy_buffer' as used
Date: Tue, 12 Mar 2019 21:29:21 +0100
Message-Id: <20190312202921.31331-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
when possible") a buffer 'dummy_copy_buffer' was introduced. gcc does
not see this buffer being used in the inline assembly within function
'__switch_to', explicitly marked this variable as being used.

Prefer using '__aligned' to get passed line over 80 characters warning
in checkpatch.

This remove the following warning:

  arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]

Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 77e44275d025..5acf63d45802 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1153,7 +1153,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #define CP_SIZE 128
-static const u8 dummy_copy_buffer[CP_SIZE] __attribute__((aligned(CP_SIZE)));
+static const u8 dummy_copy_buffer[CP_SIZE] __aligned(CP_SIZE) __used;
 #endif
 
 struct task_struct *__switch_to(struct task_struct *prev,
-- 
2.20.1

