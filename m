Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8182BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 01:12:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E829720663
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 01:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKZ6ROYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E829720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DbMt2clczDqCW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 12:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uKZ6ROYq"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DbL51J2KzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 12:10:51 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id n125so7085610pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Mar 2019 17:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RH1HRFwwG92oE9FO0MUBqMimz4ZaswU9xI1ppdGQE6I=;
 b=uKZ6ROYqd9vS/zfe35k1CRviG3sqe5iW6cjZvocCHheD7Zng+Grp46hqHy7ncspocd
 gHi45t4jvZcciUsD5oL+4q9cp1/rLRgillYQnPWYnhryKsOoaBlVD5ewJ7N2YCSyAjXS
 cZGiFxBb3r2p7zjw8wW34JDeqQu00iSmM0WlEC8HcZK+wGJpJpYkjLoo2pau85bnA5j2
 YTT9/9tm2HSvuPj3dZEiNtmMzJdVXfZcLIzowsMf6eUbAfkmJlFBQ12Xl9OaAacyLVBr
 TQLYHKPPAQGEMEPCzuPB9rsZayDG/3yUyRmtP/BMpC8oT/0N2BhbV6gPpZRPqM3H5N7Z
 lRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RH1HRFwwG92oE9FO0MUBqMimz4ZaswU9xI1ppdGQE6I=;
 b=U/QOXovdv29mdQsvXuTAqLdRP7vOf1SrY5gBinahC1AKO2dxYg9lhVQnJre2RdG054
 2ppZUWEZY1yyByqDenod/NzNEJ/NnJw7sFdo9/CLd93jRBs84vyC/nUcZ685NmqB557R
 4IlKd6FCWNp08oP7emzXKNg8CoKWsWZg0Qn/lDX674kYM9BpxPhCFbOpfVPov4g8XjQc
 TCUQ4U0e93bv8EZRdJmqK820WlyQlJnH8e7ZK3dpMVJt11svPfJaouA8HYbNshvFBcEa
 xVxBx4PZ1HNUFHdnMwfxI8o0p3Dr1E6NQSjYx9hJBhY4SJyXpjtx0Es3N1jiGcPgTaHS
 M5Ug==
X-Gm-Message-State: APjAAAUGdZyhzetybd84egsbSRKb8yaZ5Ft0I2/vU30N6sRKdLoHC2qm
 6aeAZrolf3XUE82f8HzyRjDcFMSa
X-Google-Smtp-Source: APXvYqws6ywD8PfFeE4dq+2fvllTDqEa7gXg0rTxo+iqUcF5rlfmb/GODG6bYO2MBvV9HdeLHXDJug==
X-Received: by 2002:a62:4254:: with SMTP id p81mr4610825pfa.185.1551834648017; 
 Tue, 05 Mar 2019 17:10:48 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h65sm167340pgc.93.2019.03.05.17.10.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Mar 2019 17:10:47 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Add barrier_nospec to raw_copy_in_user()
Date: Wed,  6 Mar 2019 12:10:38 +1100
Message-Id: <20190306011038.16449-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit ddf35cf3764b ("powerpc: Use barrier_nospec in copy_from_user()")
Added barrier_nospec before loading from user-controller pointers.
The intention was to order the load from the potentially user-controlled
pointer vs a previous branch based on an access_ok() check or similar.

In order to achieve the same result, add a barrier_nospec to the
raw_copy_in_user() function before loading from such a user-controlled
pointer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/uaccess.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e3a731793ea2..bb615592d5bb 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -306,6 +306,7 @@ extern unsigned long __copy_tofrom_user(void __user *to,
 static inline unsigned long
 raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
+	barrier_nospec();
 	return __copy_tofrom_user(to, from, n);
 }
 #endif /* __powerpc64__ */
-- 
2.13.6

