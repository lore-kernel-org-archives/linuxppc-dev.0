Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176FC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:46:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7AD2082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7hapZUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7AD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fWmQ4KdfzDqTn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fWkh49RczDqPP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 13:44:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q7hapZUG"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fWkh31wtz8tP4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 13:44:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fWkh2gB8z9sDr; Wed, 16 Jan 2019 13:44:28 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q7hapZUG"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fWkg5C7dz9sDn
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 13:44:26 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id a6so765566itl.4
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2019 18:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7M87xbAiky44s4tL7xc/KDRdttp6uXvVS92dxmkzCfQ=;
 b=Q7hapZUGNG4AYHtFrRxodfj9b0KVZrDlxjn1QTIN3QodPC1Kp3pa4X4RzvhloeulZA
 4nZCsbKOnohrDB1lIMcREGwN3ztIs8eDiIHxwqGmwZJorpKupwcVcZGofHoVnl3Tme5f
 hrBeIaaQhy9QghM9Mq/Zat06alC4FF+hZnHr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7M87xbAiky44s4tL7xc/KDRdttp6uXvVS92dxmkzCfQ=;
 b=dk2QFi8Gdn8m/4JNBM5nYkD0FN6fobG1kKcb89+hz3ZB6F7JGzmdiu5Ej9czv1tUnJ
 6KcWKQwXgUrxnK7MxNc0NAZZURyaYrF5KLgpn2IMNd+YNOEvKVSeITaDl4CPx9wdC8ui
 EUe0evCYAJr/JjInZ3qdgvVWCU/5owa5x8XWvviq+1oGheZOKS9CsqqLU5merGguvSG0
 HL0dC/I8iyjhT7rnhoz6S4O766L0fhsCgSh5LJUwbh4peUOSm/vtuzsJaCAILuiZsNnC
 UkKH820RWIR1IsgveVnMGWeDPbJAVdsVLttKqDboBWhHoGgbwAVXtc10PlbSoybW+CUh
 JolA==
X-Gm-Message-State: AJcUukcUPqnSY1udIxImQ9sQtxuypI4vin7JHs9+e7SJ2ACZaFNxOMKX
 VIwgilOOF2HhrC4Nx3DKJ8KWzYcXldCHA+cSQVRnxw==
X-Google-Smtp-Source: ALg8bN5MxY6hMI6aPQoEmnRtBeCu9Sd7MMzhg0LcQI854obK1WkS6SJisC0xL62xnIcXZTF7cwe+nRbBFpLkXVYDhz4=
X-Received: by 2002:a05:660c:a45:: with SMTP id
 j5mr4348790itl.83.1547606665188; 
 Tue, 15 Jan 2019 18:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20190114113620.17558-1-mpe@ellerman.id.au>
 <20190114113620.17558-2-mpe@ellerman.id.au>
In-Reply-To: <20190114113620.17558-2-mpe@ellerman.id.au>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 16 Jan 2019 08:14:14 +0530
Message-ID: <CALxhOnhK8CJRTm-M=T11dQtmL4jYV2j9my6e=gHS6tYvu8ZyTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] powerpc/syscalls: Remove unused prefix parameter
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

Thanks for your email.

On Mon, 14 Jan 2019 at 17:06, Michael Ellerman <mpe@ellerman.id.au> wrote:
>         nxt=0
>         while read nr abi name entry compat ; do
> -               printf "#define __NR_%s%s\t%s\n" \
> -                       "${prefix}" "${name}" "${nr}"
> +               printf "#define __NR_%s\t%s\n" "${name}" "${nr}"

I'm planning to come up with common script for syscall table generation.
I already posted few patches;
https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
https://lore.kernel.org/lkml/1546441324-19774-1-git-send-email-firoz.khan@linaro.org/

So if we are planning to do the same, then this change is not required.

Firoz
