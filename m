Return-Path: <SRS0=itdR=HZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B875DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Feb 2021 22:29:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A107F64E00
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Feb 2021 22:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A107F64E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DlYdH0JHDz3cTW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 09:29:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=xo47+w6W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lixom.net
 (client-ip=2607:f8b0:4864:20::d2d; helo=mail-io1-xd2d.google.com;
 envelope-from=olof@lixom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lixom-net.20150623.gappssmtp.com
 header.i=@lixom-net.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=xo47+w6W; dkim-atps=neutral
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DlYcp2lpTz30JR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2021 09:29:11 +1100 (AEDT)
Received: by mail-io1-xd2d.google.com with SMTP id s24so18929071iob.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2021 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XJ/YE11Qof2rHpad0LdA3cz/q37muHTOojoBnUeLw3c=;
 b=xo47+w6WJsjjqLpkg3SvDW/Z+8ZTvIBxZ/0fxFOgGKpKW/6FLkRq8uvG4bMDr4Zfsg
 FPtQNfTgsw3+qG+FVcoPAkVLnb+ROO2oVDnPBxjJz11EWlwQNZbrecsYLn0jagvrLHxu
 lyrtv67hqvbAAmKxoH3VE7ymWnou/XWpTRz2WCQilT9k46l6Q7p+eS38TjB31UMEZSSn
 0bbMWTysrW1Ele/D8THmZS4CVnxiB+xfoC/iqdukhSivIKWeovwy/LWdyNNma4b32XVD
 tFKYwP+6agUvAan2CUsZJx1qnXAqv13mk2Pb7mS1TWZPiSCUA4dDcVwEvY2iH721JON+
 GZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XJ/YE11Qof2rHpad0LdA3cz/q37muHTOojoBnUeLw3c=;
 b=GK5JcLWhHUED+7GVUQN9PeHefPjdpwJUt0CGVJ6NLX00h6tBmLDqIrRc1xPrWgJwCp
 sedk0tDph+SVTyzxAWuXmvIoD1wJF8wSBz7VWeaNtNEKkhvmiXVqk5i781PzB9pm1UGk
 UmFcNnoyEzjDS2NHg02clmJ2VMRfVjU6Cw2e1CFJDu+BwMQGi4PqwL3IlJW3WJVXGVts
 F79LIv2tRarzae7ppf5OqOBowtMlZQBOzwAdUg+6rLuf6zu3MneD9iBaCuNGYzQegy1J
 MP9GS95YhB7CLVzTwvLRGekJQJtoTVa62SAkxMSGt96Fpm70t+49m+hOk9LdmpZk78Wj
 1uhA==
X-Gm-Message-State: AOAM531ShmN/joIBBtxFLBsvada6CCh/pa61szuYz6l6Z1eCJlz5rpw1
 va0sSryfiqquXSLlOqN9HjaMiMzNrDw0Q60OrZRr5g==
X-Google-Smtp-Source: ABdhPJxba6ibLuWlZU6n7Y+CUT0tsP04A4kPk27UscW8mZaVtWm2AvV8uqPl0B3XNctdvFXfQnKa1X2ktZxKtrnLha8=
X-Received: by 2002:a6b:d01a:: with SMTP id x26mr21711673ioa.11.1614119347962; 
 Tue, 23 Feb 2021 14:29:07 -0800 (PST)
MIME-Version: 1.0
References: <13741214-bafc-1ee5-4157-854c14dae17c@xenosoft.de>
In-Reply-To: <13741214-bafc-1ee5-4157-854c14dae17c@xenosoft.de>
From: Olof Johansson <olof@lixom.net>
Date: Tue, 23 Feb 2021 14:28:56 -0800
Message-ID: <CAOesGMgtAXPQRThhkF5QR25R+F68F5C_HSUvFPW0Wk1DcpCwvA@mail.gmail.com>
Subject: Re: [PASEMI] Nemo board doesn't boot anymore because of moving
 pas_pci_init
To: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Tue, Feb 23, 2021 at 1:43 PM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
>
> Hello,
>
> The Nemo board [1] with a P.A. Semi PA6T SoC doesn't boot anymore
> because of moving "pas_pci_init" to the device tree adoption [2] in the
> latest PowerPC updates 5.12-1 [3].
>
> Unfortunately the Nemo board doesn't have it in its device tree. I
> reverted this commit and after that the Nemo board boots without any
> problems.
>
> What do you think about this ifdef?
>
> #ifdef CONFIG_PPC_PASEMI_NEMO
>          /*
>           * Check for the Nemo motherboard here, if we are running on one
>           * then pas_pci_init()
>           */
>          if (of_machine_is_compatible("pasemi,nemo")) {
>                  pas_pci_init();
>          }
> #endif

This is not a proper fix for the problem. Someone will need to debug
what on the pas_pci_init() codepath still needs to happen early in the
boot, even if the main PCI setup happens later.


-Olof
