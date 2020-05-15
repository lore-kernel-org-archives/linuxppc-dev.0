Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE1C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 07:56:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C43206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 07:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKIRR40X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C43206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NgjH4Ss1zDqZS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 17:56:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::343;
 helo=mail-ot1-x343.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bKIRR40X; dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NggL5NlKzDqwv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 17:55:10 +1000 (AEST)
Received: by mail-ot1-x343.google.com with SMTP id w22so1225216otp.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r+TSmqT57wNIvTmnWg6b8jh790OtySXIbPaCizcVwEI=;
 b=bKIRR40X6d+F5x/NWAhqoFciTy4cXLN5wq4+WG7KbFJJWY3ImpQ9LCCdiDF19nnk5E
 0lybeEyGKKw+s2fOwYCncfJ3o/y9uDU+70+j3+Qu1WodSkLlkx2/NdKI1E9YUKI8yFx7
 JU/FbBxED71BdmC3Qc0Je2mH0l6tUl+FLMMM1Fur48Lls9Y8OYI3Hmnu3m+wRf6VL+cS
 /KUcJSrDsanxvDaTjFHwua3SojucCKZVX8rBNBnss2vou8rjRjkgTADW/o0+wr6525jy
 Vr3aHkmxwxk7N351mgqPHJw6UFT1zZBID5GBwkWHfhQBm6TdwyEqJjPBv6lNdO9ognSS
 cODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r+TSmqT57wNIvTmnWg6b8jh790OtySXIbPaCizcVwEI=;
 b=TDFYXG5hJ5DQypQDZvhgGVtLeAEPDDGBxkIWDTimFudTU8igNw/PDOCKHteM1nz3x0
 uUVq1v3WTYz/WOTZ0Y0M+DQMxgtaYhTmSi9f/zFqKPsGsozB9sZ7et310QBeWcOss8U/
 MEd/isr0t86ylXX0huOEdf9V2EJxOzv0J78SHb5QTARlDvWXzQCJEFQpRApxbXA8RWdm
 Xi37Movig4ib5ySdKt+qwVNxaM8SCrNClX0dt5FfuoPOfsGK+uMwIbgM0oe4ry5NVlE7
 h84jJn3nw2Un+URT2cs+qqrlawQFB2MrgeYx9IEMzr8Q8rqb4bve2r658h5cZGjFEqja
 1cjQ==
X-Gm-Message-State: AOAM530gtighIrToIRDzJ06454tGqJbFjiywXzART2aeVnp44arjAeAK
 ItQlIjG0JOyoiCCk3iJTAvmlkkpNoHPOKYJ8WQZlBahAq+0=
X-Google-Smtp-Source: ABdhPJzC5vYt1G5WW6XFSn5Vvs7q9SKdlX/uMKCYpwVYDfEA19bmZism0qrZ/3PywdgERnN3E1fOelnAnxV9okW10fA=
X-Received: by 2002:a05:6830:18c4:: with SMTP id
 v4mr1303429ote.51.1589529308568; 
 Fri, 15 May 2020 00:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-25-jniethe5@gmail.com>
In-Reply-To: <20200506034050.24806-25-jniethe5@gmail.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Fri, 15 May 2020 17:54:57 +1000
Message-ID: <CACzsE9qvY5mW_ObW=Xh-AsL3r-zkGkpvrw3Wz8K4bUQS0JhDmA@mail.gmail.com>
Subject: Re: [PATCH v8 24/30] powerpc: Test prefixed code patching
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Alistair Popple <alistair@popple.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Balamuruhan S <bala24@linux.ibm.com>, naveen.n.rao@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hey mpe could you add this please.
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -707,7 +707,7 @@ static void __init test_translate_branch(void)
     vfree(buf);
 }

-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 static void __init test_prefixed_patching(void)
 {
     extern unsigned int code_patching_test1[];
@@ -733,7 +733,7 @@ static int __init test_code_patching(void)
     test_branch_bform();
     test_create_function_call();
     test_translate_branch();
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
     test_prefixed_patching();
 #endif

-- 
2.17.1
