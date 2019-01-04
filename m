Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE0C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:29:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C7D21872
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRRTOMlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C7D21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WKHZ6fHzzDqN8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:29:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oRRTOMlK"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WKFx6NY8zDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 20:28:05 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id b14so31208234edt.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2nwlgmQ1pKF6ZBcLi62Mt7YJmEymWM13iEI3HkbeSBc=;
 b=oRRTOMlK9vGJxFAY6Sdz4d+Uxyq5JAVIPTdN5v+GUpa6GVySBGSruMSFcg3do/GzzF
 kvx9WOvBqDs5LcnJLFRrkz0CQQ/d/8nhqgi33ufNzyjD78MU0lg6B0dbphOZgFSINTyY
 9M7EsARP16/W8btpcybPp0BaoMn/lbfCf9IOeFefYTYYROWQC1NDPOPPlOSHvC48DC6I
 mUCHSvworz21XDYbTkAMMuYPQq8N79D4o0BE+WDQ9QpHGgHSoqf5CG/m1fCkc5tH1E7f
 YapXgjB827NgVH88LRQK38STisBuIBH9SL3yCxKe4svurTZVIIxJJWsySdD3zy/g3BLY
 tDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=2nwlgmQ1pKF6ZBcLi62Mt7YJmEymWM13iEI3HkbeSBc=;
 b=Qjxfoxu+7q5cIdS449hvOW4WbLfwEr1rt1DFGfYIVPgs5idNH/UFNRifx0+4q2LjID
 yPBhnfmd4XI25iI8OTX+NEkUMy1kFFQ/F4+5BWFi+QmfER7jYI48ZZJw+VTviol78b5E
 Di6FMaxoectk2KMdNJ4HhnkE0z7Vp+MCb08L5IBbSrqbexqtltOk7o6vv4mObH/TInud
 umDWbzNFesTpIe17UFLqR0k3EDk3CWI4UMqlFO0VYnmjIdmVWEY7iCmaySnWbFaO/cj0
 FBPIVdjJHcm7cAfXcBISFVxYR7Z4m0wIQyDyPoQ5ku7aHUvm1AE41Tx3LLE2N6ICEFkt
 0ZkQ==
X-Gm-Message-State: AA+aEWaYjqbcTMJtCM405RwnGhDOkpW30x19D15yxf95VsFGWIt/4CCz
 pR4ivIhzhKgPGj9uO04/CYw=
X-Google-Smtp-Source: AFSGD/VbSrg0TLNue3xEQQZWrztkLIZRkSri7ifn1MWPnP29bXxYq0iZYHnJ0LeuTTyET493xgHd0w==
X-Received: by 2002:a50:f284:: with SMTP id f4mr45193034edm.77.1546594082326; 
 Fri, 04 Jan 2019 01:28:02 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
 by smtp.gmail.com with ESMTPSA id
 49sm25983769edz.59.2019.01.04.01.28.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 01:28:01 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 4E7B4114685F; Fri,  4 Jan 2019 10:28:00 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] Remove 'type' argument from access_ok() function
Date: Fri,  4 Jan 2019 10:27:58 +0100
Message-Id: <20190104092758.4378-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
access_ok()") an attempt was made to remove a warning by referencing the
variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
from access_ok() function") the variable `type` has been removed.

Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
access_ok()") to fix the following compilation error:

  arch/powerpc/include/asm/uaccess.h:66:32: error: ‘type’ undeclared (first use in this function)

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index b31bf45eebd4..5f0c98e511a0 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 #endif
 
 #define access_ok(addr, size)		\
-	(__chk_user_ptr(addr), (void)(type),		\
+	(__chk_user_ptr(addr),			\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
-- 
2.19.2

