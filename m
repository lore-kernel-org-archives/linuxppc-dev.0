Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3002EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 01:33:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5AA64E21
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 01:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5AA64E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1mcN0jhSz3bxW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 12:33:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=PG0JzHKM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PG0JzHKM; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1mbt2P0hz2yyv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 12:32:41 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so3854492pjq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Mar 2021 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=0e9uVhoDrBxYkyYzcG5/SLyYDiusx9kb6Y7qbKS45Nk=;
 b=PG0JzHKMPa+bD9Ab70MqGB4hKYbLxpS7JeGHEILGpxUWy2zLLNLQRUYY0xpbmqGrRb
 mkMfe6GfWHniIKohMzpGVRL8vrONn8VIRw/WrdsvARmWcFbB2Aw5AYioh45+NeEJoPI0
 yaTbR+XRFA0CKbRnl+MZx+AZAeYSqwNdtVtIsftsjStiLGMZF/kCzJD934bz1wcuqJUW
 nN67sa4hmU0W06x1U9TlEX5fyavZiS+GhcPItzC8htTJay0jCLLO7GCFYtxVqsUw92uo
 lSyd4MvChIY/0U7JbDqI6zqM9ecCv0mXheRMH2MvaaWvQdpv+GaMEFQ5lhcS/op5+xQ2
 cGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=0e9uVhoDrBxYkyYzcG5/SLyYDiusx9kb6Y7qbKS45Nk=;
 b=OJdGzR39H0eJ0eIPBQ0V3GCHk582TeiB9pIAgtWfPwxxmiqOL0LVqDsPFHsBf2WQZu
 ysyivSdqInZX7MEDc5Ntak3b2LUTVMF3vUphrwc9uzwGW+oqeKmUkwURLwBhPOeWTAKz
 E7yh89NWBky92uV2Dv5PrD52JUkVHY5wL0JzTAD/H0RgX1W9aNgM/qhYxw+Chba2blef
 aSitUahQktBa5WMe29olt1+Sb18eQ2WhBrmVfjb6Huid3lC4+uGy5goXUBf6lFkXIcCZ
 /DBWBWUFnkwIxnQkSM+Dhkn5Z8qfzMaLAVNs5iTJGCzDWxmbYPP0HRfm5EHI1J+4SP+m
 tG3A==
X-Gm-Message-State: AOAM530ZB3QDWx3dCTIgxlyE3gbzmL6NOArAtdZ0aQa6Xk9ueODBj3B3
 BWHVgmL61o2SyJHlE4AJXeY=
X-Google-Smtp-Source: ABdhPJwQ9YR1G1ZckqfTR9qorU9//BVB9MTWxUjhZTpfiH7KdgYEdPNU9ZZ/aCycRm3l0FdROdZL+A==
X-Received: by 2002:a17:90a:a63:: with SMTP id
 o90mr7263045pjo.90.1616117556741; 
 Thu, 18 Mar 2021 18:32:36 -0700 (PDT)
Received: from localhost ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id e190sm3441775pfe.3.2021.03.18.18.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 18:32:36 -0700 (PDT)
Date: Fri, 19 Mar 2021 11:32:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 2/8] powerpc: check for support for -Wa, -m{power4,
 any}
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 llvmlinux@lists.linuxfoundation.org
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-3-dja@axtens.net>
In-Reply-To: <20210225031006.1204774-3-dja@axtens.net>
MIME-Version: 1.0
Message-Id: <1616117194.vwe39qw3i4.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Daniel Axtens's message of February 25, 2021 1:10 pm:
> LLVM's integrated assembler does not like either -Wa,-mpower4
> or -Wa,-many. So just don't pass them if they're not supported.
>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 08cf0eade56a..3e2c72d20bb8 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -252,7 +252,9 @@ cpu-as-$(CONFIG_E500)		+=3D -Wa,-me500
>  # When using '-many -mpower4' gas will first try and find a matching pow=
er4
>  # mnemonic and failing that it will allow any valid mnemonic that GAS kn=
ows
>  # about. GCC will pass -many to GAS when assembling, clang does not.
> -cpu-as-$(CONFIG_PPC_BOOK3S_64)	+=3D -Wa,-mpower4 -Wa,-many
> +# LLVM IAS doesn't understand either flag: https://github.com/ClangBuilt=
Linux/linux/issues/675
> +# but LLVM IAS only supports ISA >=3D 2.06 for Book3S 64 anyway...
> +cpu-as-$(CONFIG_PPC_BOOK3S_64)	+=3D $(call as-option,-Wa$(comma)-mpower4=
) $(call as-option,-Wa$(comma)-many)
>  cpu-as-$(CONFIG_PPC_E500MC)	+=3D $(call as-option,-Wa$(comma)-me500mc)
> =20
>  KBUILD_AFLAGS +=3D $(cpu-as-y)

I'm wondering why we even have this now. Kbuild's "AS" command goes=20
through the C compiler now with relevant options like -mcpu. I assume it=20
used to be useful for cross compiling when as was called directly but
I'm not sure.

Thanks,
Nick
