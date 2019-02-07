Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88505C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:29:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF81A2175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ul7xcKFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF81A2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w51m58RyzDqPc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:29:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5046SWczDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:28:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ul7xcKFj"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w5045X4xz8tS0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:28:04 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w50453m9z9sMM; Thu,  7 Feb 2019 15:28:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ul7xcKFj"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w50420dvz9sLw
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:28:04 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id q1so4205421pfi.5
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=L1eq9tPBRTWzi9si6n6qaYL29cWmyMTcGPTwjgD6QEQ=;
 b=ul7xcKFjBFhiS7PavtXojz9QliI9c5UEpXr+DGufO6bEI1xUyJGMaOlGo9fUObe5Mk
 1lbewip7zHkrsIq6Od8DJ0InZePIM3Q5x8cxSlaaQJi4QYTvr55JmBhddWQ0k/RtG9O9
 wY43ap3LRKauc77TIokjhlELifM/9q1RN0ONbjfLqGqqneg46GDu8xCm4p8X3CqmMTur
 hAQhy2aU1kDjfbdSSHwwJJ5vXupNo3gdTZeYDJdxd4kDjJFExfhlmsQc9XWHYYAYwrIo
 unzwGCIxd6AN1yIO74ThsZv3LCBexrSXRj1Ih8p25RDRS2AwWbLkaHPP6uZIN5gXadx0
 7XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=L1eq9tPBRTWzi9si6n6qaYL29cWmyMTcGPTwjgD6QEQ=;
 b=Cmt/qiqVq01VMhNkYM0sfzKNooNcnr6kb1ncJ57aKIWe6refVmKOTCUoDpQEDd9Xsm
 05AE13cyha/xfkUkKU3XpH4fUZPh453rxSLp7bzrbXAyVs+9wSKZW/lRlUQWzCcZ4Ykd
 YKREB4HyB4Hhqa/0P3txUOhy7IEYul8Gx74OXD6ron/6rOWzuvTixLBHopXDsdPPY1VG
 sd6eq4fVqc+T1DtPF4+xZqOWk9P2k7nkARuYokVIbbUrOCOne3BNIzbO+9ugF5jQZZHE
 KzbD0slgEILy5tvENa2s7/SR4cBYtAuArRXNNceXSkyIJvt/sgPC1wH9laiz/urejmag
 gx6A==
X-Gm-Message-State: AHQUAuZlgHxSrK+T3pCeoP/I4JDA1MGRC5FuDbUSAeRXS6JLZDKf+lsz
 jffVK4Mbi6Coz8nTHgGdkET261Z2
X-Google-Smtp-Source: AHgI3Ia5SwAw697I6Y5gJICrLnIWiUbQBf39JDX3cM/s0CT/HEszb+Zx14zPdgtdH8js7gZjoyO9mA==
X-Received: by 2002:a65:520a:: with SMTP id o10mr13456411pgp.276.1549513682576; 
 Wed, 06 Feb 2019 20:28:02 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id p64sm12664209pfi.56.2019.02.06.20.28.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:28:01 -0800 (PST)
Date: Thu, 07 Feb 2019 14:27:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 19/21] powerpc/32: Remove CURRENT_THREAD_INFO and
 rename TI_CPU
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-20-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-20-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549513559.eo06g2mjtn.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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

Michael Ellerman's on February 5, 2019 9:32 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> Now that thread_info is similar to task_struct, its address is in r2
> so CURRENT_THREAD_INFO() macro is useless. This patch removes it.

You wouldn't want to keep CURRENT_THREAD_INFO(r2) to mean get the thread=20
info out of current, as just a no-op for documentation purpose? I don't=20
know /32 code at all so it's up to you.

> This patch also moves the 'tovirt(r2, r2)' down just before the
> reactivation of MMU translation, so that we keep the physical address
> of 'current' in r2 until then. It avoids a few calls to tophys().
>=20
> At the same time, as the 'cpu' field is not anymore in thread_info,
> TI_CPU is renamed TASK_CPU by this patch.
>=20
> It also allows to get rid of a couple of
> '#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE' as ACCOUNT_CPU_USER_ENTRY()
> and ACCOUNT_CPU_USER_EXIT() are empty when
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not defined.

May want to split these a little more?

=
