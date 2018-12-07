Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C5C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A0720850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YB3m9hnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A0720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B5WS2LytzDrbd
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 19:40:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YB3m9hnc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="YB3m9hnc"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B5SZ3lyPzDrR6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 19:37:33 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id k7so2642239iob.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 00:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=axjiaHrB1ULkaMIAknrvQsbE0LJYkyVqkUjPnD4NEjQ=;
 b=YB3m9hncANhburPLFMAz/W4XooAHl64w43U3HLsP4EjNAnVut5AGglJBXl5RFsUUW3
 1phyg512TXiyo2xbC3SYREZYiPmM76bFY5gqM66s//Kn6gQxsxl6e8M2f965UFJ1oFof
 Hw1gFRjC5wB0RsDeVGjx+tXrhE8+TiXzDdlcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=axjiaHrB1ULkaMIAknrvQsbE0LJYkyVqkUjPnD4NEjQ=;
 b=Sew3umj0Q8SkCki8mEF3j0Kg2mH051ObHEV2EDADUlvoW/71LzzJ8vI08amVT+hwZ0
 ZC4l9QlkU7Rep2UBKjOY0S8G1n+GmEyP0Lg7NcXYRZ6DLpti5zEp/R+y7rfRqGXvb3Fq
 zwwLQ6nDOAAxvL1B361hIOXO07usQy54AUYiIse4NF2194R5YwXf8ZJIIh06hnYDognz
 kxVKSkRK6gFX8383hMZMVbzeYMMN260yeXxpnGpWUFadJpvqkb3MijZDSAhNNAdpwsMm
 McUKgG4Mvkm7ES2YRL/NrhjWGPhLA12jNWHFm3k7kGC3GkmBxZuJuNQw+trs6fHj3irg
 eQXw==
X-Gm-Message-State: AA+aEWYhkkO8yzVnM6aOPyWe3+gAuo17RpdHJmlEPi2bqglLQAXfWG69
 QeSEQ3eBo+fTbZDdmDgS/VSOBciiPxHqo1A0oOd4Mw==
X-Google-Smtp-Source: AFSGD/Wu9g2rpEVIfQVRau9qFsGtCCYK2QVFsmYhyUCl5TcNrGPk0AstIWwo+AQowJNdIf8B2lFvLZIaMliUIFPT02o=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr870290ioc.119.1544171852086; 
 Fri, 07 Dec 2018 00:37:32 -0800 (PST)
MIME-Version: 1.0
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
 <20181207072724.GA3750@sathnaga86>
In-Reply-To: <20181207072724.GA3750@sathnaga86>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 7 Dec 2018 14:07:20 +0530
Message-ID: <CALxhOnijfhMx8Uyiv3L5DR9dea2P85YRKD09cVK58T9h3ca+Eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
To: sathnaga@linux.vnet.ibm.com
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Ram Pai <linuxram@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Breno Leitao <leitao@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Satheesh,

On Fri, 7 Dec 2018 at 12:57, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> On Fri, Dec 07, 2018 at 11:41:35AM +0530, Firoz Khan wrote:
> Hi Firoz,
>
> This version(v4) booted fine in IBM Power8 box.

Sounds good. Thanks for the support.
Thanks Arnd for sharing the solution for "split compat syscall table
out from native table"

If someone can review this patch series and queue it for 4.21 would be great.

Thanks
Firoz

> Compiled with 'ppc64le_defconfig' aginst https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=a26b21082959cee3075b3edb7ef23071c7e0b09a
>
> Reference failure v3 version: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/182110.html
>
> Regards,
> -Satheesh.
