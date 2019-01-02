Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0073CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 12:58:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6793D2075B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 12:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beIgIaBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6793D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VB182Xq0zDqH1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 23:58:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="beIgIaBw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=sedat.dilek@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="beIgIaBw"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43V9321j73zDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 23:14:34 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id y139so26356469wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jan 2019 04:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to:cc;
 bh=tuOeiypRUnZ+vONbIlfvSMz1B6QmcFHUX6zM6XouHKw=;
 b=beIgIaBwoGs1oVP4kVoCdEoOgYkRQcaIk0bR3Q2xIS2FszfzqPCLXyLGYS74X7bD0w
 jrWOYxayiEXKXmp5xyJhszLjNZS8sVE8hysSeKZJnf2VuOEe4UADKZCdG9Om4r85EIWH
 Rrg7r7P/mV09o65vPH0lVcUDmlmZFkgXnOs4YDMm+0+EVvMxr/ai5Ifpgh/Bn3dKVuTz
 cFo/VcLImQR3jNo4aj/1PKadMZtSRpPsjOm5P55xpZ9755igmPjUPNuA3dLqc0R26L02
 aDAz1WOC8JqqWJA1DzDGpIhYaya2rCtkSoAgUiIORS6ow4Li1wtrPa+wlRTvkZ15Cp6X
 K42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to:cc;
 bh=tuOeiypRUnZ+vONbIlfvSMz1B6QmcFHUX6zM6XouHKw=;
 b=om7NvotFCEE7fIgz7rcsf1NluVJ+LI3bQ7og3nUSybeoWyF34TXmR8Trx/wq3Vv+Xo
 R6I8jtqtWixmsl4t4bWpILYafJLXVHzz9HVJC7QT+DtQj/uWGKOiWc0V7WhRylwqN+Nx
 3kukKV5SkNZIzLCVvNGbJ6AqEF2FlKWsgRNctFRcwgqBW+Fc4ITnJg0iHcmSFD6mtwpe
 MuJsh9t7anwaTiS2SSMwoZdtc/Athz7gKSCuLah076J/u0YijmcDhspD0g6DznsegkIN
 6weis+iq8RSVs15SISQrILXnco8AEKJ7ywefSVk2xVAtg0cpfc4oyRG1I0n69+6HWXGG
 s/Fw==
X-Gm-Message-State: AA+aEWbVZlYiaNsa8iusM/UCf1alXpTW9Wu37bfhabC+Jgf5kfb/LKjW
 1OMFdHeiRLf5ZyoAhJab9bmkt3yNgmLVq3/zMLc=
X-Google-Smtp-Source: AFSGD/Wrp+2wG3UodzdTtFKXJ1N1+jmmQr9HUM6U4bEiUWyE7kCh4UEN6Qwi3BN1wf/RkHNC8Lh+0w7pDhELJg7mkKQ=
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr36004298wme.73.1546431270297; 
 Wed, 02 Jan 2019 04:14:30 -0800 (PST)
MIME-Version: 1.0
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 2 Jan 2019 13:14:18 +0100
Message-ID: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
To: masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 02 Jan 2019 23:53:24 +1100
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
Reply-To: sedat.dilek@gmail.com
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
support of asm-goto.

Currently, I am doing experiments with clang-7 and a snapshot of
clang-8 on Linux/x86.
These compilers have no asm-goto support.

What is your recommendation for Linux >= v4.20?
I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
compiling with clang - which has no effect.
This is confusing.

Thanks, this patch makes things clearer and protects users from
setting "wrong" in the sense of non-functional settings.

I have tested this against recent Linus tree where kbuild/kconfig Git
pulls were latest commits.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
v7 and v8 (snapshot) ]

Thanks.

Regards,
- Sedat -
