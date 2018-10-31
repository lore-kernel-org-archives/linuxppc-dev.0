Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9238ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 11:06:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D45D20657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 11:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL7+NanL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D45D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lQWX07cWzF31L
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:06:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PL7+NanL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PL7+NanL"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lQS14RDZzF1Ph
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 22:03:27 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id x12-v6so15971541wrw.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 04:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pW4p5ekuQgWSAo3EpgmHNfRh/OxQhAWSXR6ZJn3Wn3w=;
 b=PL7+NanLkJYIdGjDn/qRqt7LINX3lNIF9/jaavHlbvaGNwgNtPklLdNMhcl/wUNxEK
 pME6NnczybMlsZc5EXsXueBApl1SmHgLvmEhrGJLpYfEeYP0C5r6c9Hia4izZyfrHZj3
 Obw6o0EP44frTBlm5ZwXU7OVTYO5AG07CEFGQVKH0rc5F8RG/6oBVGcBqqnasLUS/TQx
 0LblAczbbXtHaejDEtmtJPjF7jT4V/2qnKM9MjuJ7wnkg8+Yff1lVFM9rRCzNfLZgKD2
 G/7PWTZIHkGCF1ypWBbIwxPeSKO4tyufUiXfNTaQAm82UYmq8Yhst5km9b88r8AFWBsn
 4H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=pW4p5ekuQgWSAo3EpgmHNfRh/OxQhAWSXR6ZJn3Wn3w=;
 b=YFJQIxzNJdkONBMp6L//2W0vpIv2gxDzF3nS8rRzaVM9jowUtUHVxRVHPPC9bpkOjK
 4ne44jariG7coNpOVhnse/s/9NGxdamIsaRYsBhT+dcuEDKNyvwI8J46O/6h5Wmclt6O
 aNdXvVF1Lg2zKOyHUQpcWUKNu5asgCq224htiUi0zyXs4uBK6Zphm1tL2S9sLSBbUNvz
 WoDugl0NI465eEA+pFGoh8Oqtynqf8d3k9ivmdSkjV65GoIWri8y6L3VyDq2R9PsTmPh
 DYXeb0yrSPwNHssljf1QO514ysBNNI/0D04RBlpvGydws/GJdf1/sGk+0XAS0fqaVWuc
 yUaQ==
X-Gm-Message-State: AGRZ1gIArSh61cOe9Ui/7UDTK8n4sr5iRycAhtpR+dNPAy1Qhy5YmASE
 FsJIEfguGnyVnfoA5lLoTIZcS84y
X-Google-Smtp-Source: AJdET5fshi4tDPpym8Jo9Z4K5Ndwa/fv8W1OjBREuTaYwyUw/LyR6mYycLkVb2WDLYqZy3wI9WkQRQ==
X-Received: by 2002:a5d:570d:: with SMTP id
 a13-v6mr2448052wrv.289.1540983804438; 
 Wed, 31 Oct 2018 04:03:24 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id b71-v6sm21113557wma.13.2018.10.31.04.03.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 31 Oct 2018 04:03:23 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 36D81114491C; Wed, 31 Oct 2018 12:03:21 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] =?UTF-8?q?powerpc/mm:=20remove=20const=20type=20qualifier?=
 =?UTF-8?q?=20from=20function=20=E2=80=98pud=5Fpfn=E2=80=99?=
Date: Wed, 31 Oct 2018 12:03:07 +0100
Message-Id: <20181031110308.8194-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
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

Type qualifier on return type is ignored. Remove warning in W=1:

  arch/powerpc/include/asm/book3s/64/pgtable.h:1268:25: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6c99e846a8c9..2e6ada28da64 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1304,7 +1304,7 @@ static inline int pgd_devmap(pgd_t pgd)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline const int pud_pfn(pud_t pud)
+static inline int pud_pfn(pud_t pud)
 {
 	/*
 	 * Currently all calls to pud_pfn() are gated around a pud_devmap()
-- 
2.11.0

