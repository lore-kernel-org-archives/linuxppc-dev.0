Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6532C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 06:25:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A682086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 06:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTTgilt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A682086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43grXs2Jq1zDqpg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:25:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43grW033tvzDqtr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 17:23:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="iTTgilt0"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43grW01NCQz8tRR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 17:23:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43grW00wrbz9sLt; Fri, 18 Jan 2019 17:23:56 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="iTTgilt0"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43grVz2cWKz9sCs
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 17:23:54 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id z7so5314228iti.0
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2019 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=34uuksI/HtmF2DW5XyYEIXNVAgR2F7OA8LU5+zqtoF4=;
 b=iTTgilt0L+WctrLZWbnv8MVO/TPBBVy29wDJbo6/FAWuw3U9Il9Xoo/1i9NZkZUske
 S74uYjMl3+mkUG3DOZCXx7IgfRfm2slodj/+SGFp+O6/nLjMJcSzNWldr4Sdx/IGFh5M
 GE3dZYwJfQiBRgptFkVhGDGD17tcraWTe79Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=34uuksI/HtmF2DW5XyYEIXNVAgR2F7OA8LU5+zqtoF4=;
 b=CcJW5dhUNoUgvJKLI8DNHozN+W+aDYmbYaUYsy/WnhlAi282wrAK9Tc15NF1XLSX9V
 P/ut/M7TvwZBugc6RmQRZfbASpDQdqhamIu12aQGpoAEeD+vrYngRTn5NJV3Gc07uP7q
 TZNuOmRtwTXhrgBOQ+2gQJ8ZJlgnSVBV17Da830sBYgFTTvkF8DCJWirq80qBIFpLGT4
 0Y6m/+sIzUi5F0FlDoG3zimCKrFabVb8MvRJzGCFjjTQ38dd/kGi8b0J7D3kGqyt9Bag
 l3BRObyINrssrDFyxCGH3RZaGiIF302za8BLG/gIpUpeckdVSNvvHo65yOcmDU4b4FGR
 LslQ==
X-Gm-Message-State: AJcUukcgV/O9Hp5pwCqO0UsmF3Wwt6adj7voY0Sw8ytVey33LflQwi/9
 FqJmQBaBoqMLavB0goLet2njzLzD/vaQhjEFAHBVKTmH
X-Google-Smtp-Source: ALg8bN5RFy5XzXcbtZ7ILWxeUROxrtzEIRqkt7wRn/ETSJSkwY3+WnePZBclSy5FnR7Ebmekl2jzNA6awCtS4o5Ozeg=
X-Received: by 2002:a02:4d99:: with SMTP id t25mr10318919jad.58.1547792632823; 
 Thu, 17 Jan 2019 22:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20190114113620.17558-1-mpe@ellerman.id.au>
 <20190114113620.17558-4-mpe@ellerman.id.au>
In-Reply-To: <20190114113620.17558-4-mpe@ellerman.id.au>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 18 Jan 2019 11:53:41 +0530
Message-ID: <CALxhOni=Dgax7ujuJW5_xw4fV4ooPjzOO5r6oHZ63wSKgLAjkA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] powerpc/syscalls: Allow none instead of
 sys_ni_syscall
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

On Mon, 14 Jan 2019 at 17:06, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> sys_ni_syscall is the "not-implemented" syscall syscall, which just
> returns -ENOSYS.
>
> But unless you know that it's not obvious what it does, and even if
> you do know what it means it doesn't stand out that well from other
> real syscalls.
>
> So teach the scripts to treat "none" as a synonym for
> "sys_ni_syscall". This makes the table more readable.

The idea of the first patch series for system call table generation support
is to replace uapi and syscall table as it is. That's why u can find places
where sys_ni_syscalls present. I have a plan for cleanup in the uapi header
and syscall table files. By that time all sys_ni_syscall removed from the
table (Hopefully).

I can post the cleanup patch asap.

> +       if [ "$t_entry" = "none" ]; then
> +               t_entry="sys_ni_syscall"
> +       fi
> +

In that case I don't this above change is required.

Thanks
Firoz
