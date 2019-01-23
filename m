Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB257C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:58:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D5021726
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnUWG1Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D5021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kzhd0B6PzDqKH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QnUWG1Fh"; 
 dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzfv1PbhzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:56:38 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id w73so845122pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=OI0t5bWDEsJdv7S188XOnBTvHNBarxIayFMx00OCpcE=;
 b=QnUWG1FhQjDa77EWxaZ2e+/yhr1Xw7g04cyvR0s0uyUALH6vADwt2wIp67rR5FTC1D
 1ivKRJpmzTQXXm7raLpr5u05HV1Vdld6s3O2yxEf4stbHV50t56cGIYpLKpyEVzZhAGk
 mSXX0zCDmvQgUVbgYUb7+gHwdglrLa5TnmH4nfaGP7jMtBL31husdq1nKwl0tCXhxrjQ
 iTYeLD6EbIk6lw2PK2GNiDYW/HYc0p7eDeovvtot1c7end6gjfZWCHEdItz7FSxnywJM
 U8Yyk4uDh05R0m/ffCAjMykv3R6v45S79GJW/hm4VKoVzCDmQ9qef+HC3kjjRaEw3RpX
 0HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=OI0t5bWDEsJdv7S188XOnBTvHNBarxIayFMx00OCpcE=;
 b=WT4kb/s8qtqTfraUdsWcCBnmBLuCnjVXDBWzPW47ZzmGd2CSDqMshmAJXPqH5NuMIK
 64lMr99JW6j4sQHEqgOzESatHpCGc+LWlgH5zhT885qwU6tyA9xiEvVn1CS6Scz5Hcdq
 k8AVJc4TiPUhiY7VG3G7KJXcBXsQLo7ojeCaovf+z18SwReExjwCvftQeK94yH9ZXXQB
 nEg9CMrYDkdAA3DvjgbpXX2MCCt6kUC70wZI3zl9HRsMwBnPs0X298DrZAiANUUJ5Vpp
 CRIuFVMuRmxFQfF0ZhDPlnh9YU14VY/GCwRiBssCwzjpMoEn7Kniy0BSMGrJV8WY59Ky
 9N1Q==
X-Gm-Message-State: AJcUukdeNz7Tgqu0YwauuQxmp8n7ytKUZeA/6HUzAYLRjIF6jUSpnEnf
 kdp9y1J+zmydl/d0bLQ4mQM=
X-Google-Smtp-Source: ALg8bN5aqenZFChd03ebhJNZnGHXfr787vhuzeKGAgnG/D+Ssbzi4jAGpIvLSpPrAQZQV/dashi2ug==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr1224905pgr.300.1548233796902; 
 Wed, 23 Jan 2019 00:56:36 -0800 (PST)
Received: from localhost (193-116-78-72.tpgi.com.au. [193.116.78.72])
 by smtp.gmail.com with ESMTPSA id j73sm24318886pge.13.2019.01.23.00.56.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 00:56:36 -0800 (PST)
Date: Wed, 23 Jan 2019 18:56:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/traps: fix recoverability of machine check
 handling on book3s/32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
In-Reply-To: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1548233155.rsqberso19.astroid@bobo.none>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy's on January 23, 2019 12:11 am:
> Looks like book3s/32 doesn't set RI on machine check, so
> checking RI before calling die() will always be fatal
> allthought this is not an issue in most cases.

Oh good catch, this is a fix for powerpc/64 as well. I think actually=20
the panic was supposed to go in the bail: path, it's missing from
there.

But you may have a point, I don't know if we need to panic the box if=20
we have !RI in process context... Possible we might be able to remove
those panics and just turn them into die.

Thanks,
Nick
=
