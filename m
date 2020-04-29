Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE03C83003
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 05:15:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6362068E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 05:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbMdTpHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6362068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Bmt707p6zDr1f
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 15:15:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LbMdTpHm; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Bmr60wTnzDqyg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 15:13:22 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id t16so415868plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 22:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=wt3Rrxm1wiUSiSdbKiTsbHccJCJGfTGrtCA6OKmMclc=;
 b=LbMdTpHmCF7T68H+jCt8hCPYI2SQ0k/selhIGKiJfddtK7qIjpZv5iWuKRQiwskEhR
 S5M6uPIanpIaNpM6q34mItzUkQU9/zvmRSGtlZ2CUt9ZP9DD0wZFr35t8dYwx1bTiqTZ
 DOu/mrKgdRGgm7iZwMSF27qfu2D+D6+k2gT/FgQsH/Clyx7nKQYacxx3urd7UXAJ+nVg
 VOtv5dnU1FGYHP5ueAs5RrdGmtf6qmr/HvxZALZzvydEflP5WmPfRiboI73urQsslbyj
 BfDw7NuK8AcVphoZ7oZ9XnDo8C3uwFz4RkTl2GHt2Ct8d5B0MQA1Q1yA8XKM/vFAAhkg
 Gv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=wt3Rrxm1wiUSiSdbKiTsbHccJCJGfTGrtCA6OKmMclc=;
 b=OZYuO6hotKw8IESM9s9Ibm9joxL/ZY7QrRSRExkUQutkfe6IMP7KQsI0d6Is3/zJrh
 uUupIAqfULj9ehM0SZ2WlwVEXOLBUTAqVexEYgIbds/VX5z66AOl2eynH+COKBt7iKN3
 Brjo+3hJQjmjfVtFAoQo5/2qAp+PIiV9SYxHZNuRA1zyCpkVToYAnz5Di59d7uqDN2T+
 0cxI+/Yc5wdrobJ7WRIQPzDFTOAG7Y+qCGZo1p6Lblu5ZqrdFsJAmouBchYoOHB+wTiD
 vifGjOMZxejFTVNQiKj2wnO8KTtNuMl8LIzqL/N6G0LcOcB80O5Gb4DFB/qbQWDDwrIU
 yFdQ==
X-Gm-Message-State: AGi0PuYmik9jinJ2fYPPiCr7WRTaMsUNvci+S21INs8pHKTgPMstcaib
 xpxEB8vO7EcCknbHWDw5cvs=
X-Google-Smtp-Source: APiQypKPKHxKS/SKcYxFfjaWI2D3FnpPlXzHDFmgYRJUKI9q3ywM5PsAABU1hS9XdIfQBpsXdoYNlg==
X-Received: by 2002:a17:90a:6343:: with SMTP id
 v3mr1030593pjs.127.1588137198835; 
 Tue, 28 Apr 2020 22:13:18 -0700 (PDT)
Received: from localhost ([203.220.177.17])
 by smtp.gmail.com with ESMTPSA id f99sm3786945pjg.22.2020.04.28.22.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 22:13:18 -0700 (PDT)
Date: Wed, 29 Apr 2020 15:13:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Section mismatch in reference from the function .early_init_mmu()
 to the function .init.text:.radix__early_init_mmu() after PowerPC
 updates 5.7-1
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
References: <mailman.127.1586355379.11283.linuxppc-dev@lists.ozlabs.org>
 <fa2aba7e-ef63-da43-8348-314bf8525161@xenosoft.de>
 <865a35c1-1eed-cd39-9645-06eedbe61b4b@xenosoft.de>
 <24c8f0fb-6e40-3546-a33e-1a4c9643e9f7@xenosoft.de>
 <0fffa44f-db23-cd9e-5bd5-4012e2398e34@xenosoft.de>
In-Reply-To: <0fffa44f-db23-cd9e-5bd5-4012e2398e34@xenosoft.de>
MIME-Version: 1.0
Message-Id: <1588136973.mf0j03tcz0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 "contact@a-eon.com" <contact@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christian Zigotzky's message of April 29, 2020 2:53 pm:
> Hi All,
>=20
> The issue still exists in the RC3. (kernel config attached)
>=20
> Please help me to fix this issue.

Huh, looks like maybe early_init_mmu() got uninlined because the=20
compiler decided it was unlikely.

Does this fix it?

Thanks,
Nick
--

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/includ=
e/asm/book3s/64/mmu.h
index bb3deb76c951..3ffe5f967483 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -208,7 +208,7 @@ void hash__early_init_devtree(void);
 void radix__early_init_devtree(void);
 extern void hash__early_init_mmu(void);
 extern void radix__early_init_mmu(void);
-static inline void early_init_mmu(void)
+static inline void __init early_init_mmu(void)
 {
 	if (radix_enabled())
 		return radix__early_init_mmu();

