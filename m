Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F96DC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:23:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A0F2064E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+cypP9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A0F2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RN7K4SqNzDqBy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:23:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+cypP9O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+cypP9O"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMwB0L8VzF3JY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:45 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id d2-v6so8139291wro.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9pEAraO+w5FxZNKwOwU68gCXSvwsp2RrSj23yV0hAkg=;
 b=e+cypP9O6uanr3tyDWz0c6akRdpCzHEznDk/UGqdh0XmBEz5LaG5BHA8TQpA89x4OX
 1yb2GPuTj7EKXgJXcoo8GSSuT10ecGI2deQSCUBfSElkNv+n92lTnZFWQxHmqCgl4FEe
 ouWG6NoD/o9bqb2rorXsdLVQB0OmZTM4XGPlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9pEAraO+w5FxZNKwOwU68gCXSvwsp2RrSj23yV0hAkg=;
 b=p+q0dp4xQI1+qoZo3WkuGpFdBtbgH811C7Gmbz27+YvyVHLVsHB2tlGQxPk46dlfzn
 FKCJv8s1caqDmvKhHRJtd1LWab9FT3N0qpfNMTpPUGNcv3z8enwjLV57OAWOA/cGboFR
 WkGrMeRrfzDTbd8DAwODhqgqnwj0xRzshZBdTUGFsMXti8CjJIn3A2F47V/ifC/XkYtV
 rPeVmy3Z+aT53UIvuSugtHok8EZc5LzTd2adfZRkyrM0zl8O7pSVNxfNY5tb/4OJwx03
 Cu43MNxypit1/5ql012pzjFo5YBlFLq9aIH4Y1Qw61yhsDvmAoHfK2gshrYoUAj+c3mF
 HEyg==
X-Gm-Message-State: ABuFfogO7CkhfxGuzCgdYN5lnPXX9r0FdybBlxGFkDqloOUbOohCKzB3
 rzI+uMwoDtnkFCyJTzewDa6dTg==
X-Google-Smtp-Source: ACcGV62ntJ9ibv6XTTbuRRc5lV5zur1H0clIqrdCTZXin3xHDioy7KJrXqpRM0YbS2pFQWeCAQb7kA==
X-Received: by 2002:a5d:610a:: with SMTP id
 v10-v6mr1391403wrt.308.1538727223269; 
 Fri, 05 Oct 2018 01:13:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:42 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/9] crypto: crc-t10dif - make crc_t10dif a static inline
Date: Fri,  5 Oct 2018 10:13:27 +0200
Message-Id: <20181005081333.15018-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

crc_t10dif() is a trivial wrapper around crc_t10dif_update() so move
it into the header file as a static inline function.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/crc-t10dif.h | 6 +++++-
 lib/crc-t10dif.c           | 6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/crc-t10dif.h b/include/linux/crc-t10dif.h
index 6bb0c0bf357b..4dfe09ff4cf2 100644
--- a/include/linux/crc-t10dif.h
+++ b/include/linux/crc-t10dif.h
@@ -10,7 +10,11 @@
 
 extern __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer,
 				size_t len);
-extern __u16 crc_t10dif(unsigned char const *, size_t);
 extern __u16 crc_t10dif_update(__u16 crc, unsigned char const *, size_t);
 
+static inline __u16 crc_t10dif(const unsigned char *buffer, size_t len)
+{
+	return crc_t10dif_update(0, buffer, len);
+}
+
 #endif
diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 4d0d47c1ffbd..036ee664c9e1 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -81,12 +81,6 @@ __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 }
 EXPORT_SYMBOL(crc_t10dif_update);
 
-__u16 crc_t10dif(const unsigned char *buffer, size_t len)
-{
-	return crc_t10dif_update(0, buffer, len);
-}
-EXPORT_SYMBOL(crc_t10dif);
-
 static int __init crc_t10dif_mod_init(void)
 {
 	crypto_register_notifier(&crc_t10dif_nb);
-- 
2.11.0

