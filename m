Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F01C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 01:25:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B93204EC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 01:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K+kRbdJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B93204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X6Tw15ZQzF3T3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:25:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K+kRbdJh";
	dkim-atps=neutral
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X6RF5FDFzF3Sm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:23:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="K+kRbdJh";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42X6RF4WWTz8tPx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:23:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42X6RF4Lycz9sBZ; Sat, 13 Oct 2018 12:23:37 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::b41; helo=mail-yb1-xb41.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="K+kRbdJh";
 dkim-atps=neutral
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42X6RD3lFtz9s8F
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2018 12:23:35 +1100 (AEDT)
Received: by mail-yb1-xb41.google.com with SMTP id o8-v6so5588512ybk.13
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2018 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=JbOxpfFGdPswa4bZ/efSE4CbecsUEZMlH7KeeVCOkxM=;
 b=K+kRbdJhpTUdAzVkZ9yiTf4n6iaSlPr9FzyFCs+NRCVGXMbnRMixRdXcr3v4eCc+Dh
 zOJdwwIYHEagT9GIDx767kuqDNbyDAQUuPKrviM/A13lnPviTrsOT9MzdDUpMpZsyXhz
 fW4ipz+k2UOMQTWakM07v9AFcLgAB9Wbwpy5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=JbOxpfFGdPswa4bZ/efSE4CbecsUEZMlH7KeeVCOkxM=;
 b=i65qvRsxih3y4Odeq2zR6Nw3WxMLlDpBR3NCZ8TvVJfkTUMGPJPcn2WsrV9V5L+6xp
 qB/Yn1WGX9x/GwerdHmVKLSxz5h77CIDfTo7+9dz8hNGBvCMhuq4lW7MrL2VNP0iiNMT
 GD/8C/yEn5D/Mpj67z5P26FWQ8NAsMslxri2ydcnrVencQbowSUiQmb7c36aV06Ho9wa
 il9fC7A0PDbL9RSQKQFfm8O5lbB6ur4e3U7uHw3b6RMuSrblmVXS5UfY7hJxro58of1W
 S4ATu8jSrLh6jc98D6wHwVFjN4mAnD/iMCyLReMfPHsgdJu2F/3zuWfUQrGH+I64lldf
 Qf9A==
X-Gm-Message-State: ABuFfojyETAhmpyk6iMILZDB8wPLk5Q4tk5OMjWjLQJ8ygT0dPzzuwy7
 1pOTpMDwKT7JCOjcMK6YeB/SSwT4SoQ=
X-Google-Smtp-Source: ACcGV62TVO2EmvASgu+iYorzfrhTl7LdOcSO14iU/GjsLDNtUCKgVe4pjNK7PNvHs4z0uPv8zPREFw==
X-Received: by 2002:a5b:50f:: with SMTP id o15-v6mr4461926ybp.7.1539393812929; 
 Fri, 12 Oct 2018 18:23:32 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id b19-v6sm708810ywh.29.2018.10.12.18.23.30
 for <linuxppc-dev@ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 18:23:31 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id o8-v6so5588489ybk.13
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2018 18:23:30 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id
 j143-v6mr4532688ybj.137.1539393810363; 
 Fri, 12 Oct 2018 18:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:23:29
 -0700 (PDT)
In-Reply-To: <0de89924-ac22-b03a-b041-c79837d3c8cc@embeddedor.com>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
 <20181010051308.25422-4-mpe@ellerman.id.au>
 <CAGXu5jJqX6ogFgX1q9czwWtufK_nvzUnfN3Xf-74eOBOpcXWVg@mail.gmail.com>
 <874ldt2uhd.fsf@concordia.ellerman.id.au>
 <d86b4613-af42-02ab-6a0c-c1ea0e78f601@embeddedor.com>
 <87woqn1pdm.fsf@concordia.ellerman.id.au>
 <0de89924-ac22-b03a-b041-c79837d3c8cc@embeddedor.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 12 Oct 2018 18:23:29 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+-iRoDpxQMwNfEb-qnxN2VXyHz0JX2=WH51v7g+avwFQ@mail.gmail.com>
Message-ID: <CAGXu5j+-iRoDpxQMwNfEb-qnxN2VXyHz0JX2=WH51v7g+avwFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Add -Wimplicit-fallthrough to arch CFLAGS
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
Cc: maddy@linux.ibm.com, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 2:59 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 10/12/18 11:32 AM, Michael Ellerman wrote:
>>
>> Sure. The kbuild report up thread has some or most of them.
>>
>> But here's a full list:
>>
>> Failed 279/290
>> http://kisskb.ellerman.id.au/kisskb/head/1d59e2c78793d8aea9949ca71323c4583c78f488/
>>   Failed: powerpc-next/ppc64_defconfig/powerpc-gcc8           (http://kisskb.ellerman.id.au/kisskb/buildresult/13542791/log/)
>>     /kisskb/src/arch/powerpc/platforms/powermac/feature.c:1477:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>     /kisskb/src/include/linux/signal.h:180:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>     /kisskb/src/include/linux/compat.h:495:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>     /kisskb/src/include/linux/compat.h:496:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>     /kisskb/src/include/linux/compat.h:494:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>   Failed: powerpc-next/corenet64_smp_defconfig/powerpc-gcc8           (http://kisskb.ellerman.id.au/kisskb/buildresult/13542786/log/)
>>     /kisskb/src/include/linux/compat.h:494:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>     /kisskb/src/include/linux/compat.h:495:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>     /kisskb/src/include/linux/compat.h:496:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>   Failed: powerpc-next/ppc64le_defconfig/powerpc-gcc8         (http://kisskb.ellerman.id.au/kisskb/buildresult/13542777/log/)
>>     /kisskb/src/include/linux/signal.h:180:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>   Failed: powerpc-next/powernv_defconfig/powerpc-gcc8         (http://kisskb.ellerman.id.au/kisskb/buildresult/13542776/log/)
>>     /kisskb/src/include/linux/signal.h:180:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>
>
> Thanks, Michael.
>
>
> Kees, can you take the patches?
>
> Apparently, neither signal.h nor compat.h have a dedicated maintainer:
>
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include/linux/signal.h
> linux-kernel@vger.kernel.org (open list)
>
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include/linux/compat.h
> linux-kernel@vger.kernel.org (open list)

Normally things like that go through akpm, but I'm happy to carry them
if needed.

-Kees

-- 
Kees Cook
Pixel Security
