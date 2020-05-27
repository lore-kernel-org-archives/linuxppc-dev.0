Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24404C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 23:04:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F492075F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 23:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F492075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XRH63p5VzDqYC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 09:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.193;
 helo=mail-il1-f193.google.com; envelope-from=pku.leo@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XRFM04swzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2020 09:03:02 +1000 (AEST)
Received: by mail-il1-f193.google.com with SMTP id a18so8527342ilp.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 16:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IY5UsUVweat3Yf12W30ICZIuRx4S2mbmL7ClK7BMyrw=;
 b=QoEf8ZkzcyLctgQqhD4qT5oOVAQpc2h0wike1aHcp+b65H4XPia2USLfJcG8vE+yrF
 +b18dY8/CTbnfmYgx0yXZYdQlwT1YfcW3QM2DMq9iicFtl12GKE+Muiqc7/md9SZa/jv
 wGt+KJ9BE8TMsKDdE/4TP2ty+gnGbHL7kZqGvoP1FuIgM6whQ9PiwJA6pw1yuNIWhdCt
 1T9PDHCS79edYs54i7m+zq5BvSp/JY+DKYc0OaOjsRzMCtKRS4wWKcQ8xzhqR4YelCAz
 gv3phbs2WVu30cDw1GtzppkIYbLxurERkOWRbJrk4lOswyYtD6nMRvRPtBUAduL43VNv
 3xgw==
X-Gm-Message-State: AOAM530BnYbSga5jiREP8NwRIINujN2G4mJBH+OpYQ6gkf3EA0k/n6lP
 bbbbvSiZJB8twdGUGVALXhCza5De
X-Google-Smtp-Source: ABdhPJx9O6ADEhhDzuW0wq+L6kYYa++J6rel68VJOeMS2LelTBeER/AhrVacUGkhV/+v2veQTLrOfQ==
X-Received: by 2002:a92:de0a:: with SMTP id x10mr573594ilm.226.1590620579627; 
 Wed, 27 May 2020 16:02:59 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id b73sm1914841iof.13.2020.05.27.16.02.58
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 16:02:59 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id l20so25751443ilj.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 16:02:58 -0700 (PDT)
X-Received: by 2002:a05:6e02:54b:: with SMTP id
 i11mr596533ils.50.1590620578431; 
 Wed, 27 May 2020 16:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200527034228.23793-1-biwen.li@oss.nxp.com>
In-Reply-To: <20200527034228.23793-1-biwen.li@oss.nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 27 May 2020 18:02:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNRS59MQ47Be5xuzLCBLJ_77UYMRbMtAUQbXjir6d7jykw@mail.gmail.com>
Message-ID: <CADRPPNRS59MQ47Be5xuzLCBLJ_77UYMRbMtAUQbXjir6d7jykw@mail.gmail.com>
Subject: Re: [v3 1/2] dts: ppc: t4240rdb: remove interrupts property
To: Biwen Li <biwen.li@oss.nxp.com>
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Biwen Li <biwen.li@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 26, 2020 at 10:49 PM Biwen Li <biwen.li@oss.nxp.com> wrote:
>
> From: Biwen Li <biwen.li@nxp.com>
>
> Since the interrupt pin for RTC DS1374 is not connected
> to the CPU on T4240RDB, remove the interrupt property
> from the device tree.
>
> This also fix the following warning for hwclock.util-linux:
> $ hwclock.util-linux
> hwclock.util-linux: select() to /dev/rtc0
> to wait for clock tick timed out
>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/powerpc/boot/dts/fsl/t4240rdb.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> index a56a705d41f7..145896f2eef6 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> @@ -144,7 +144,6 @@
>                         rtc@68 {
>                                 compatible = "dallas,ds1374";
>                                 reg = <0x68>;
> -                               interrupts = <0x1 0x1 0 0>;
>                         };
>                 };
>
> --
> 2.17.1
>
