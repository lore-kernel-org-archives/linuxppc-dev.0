Return-Path: <SRS0=CBJl=7E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D0AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 19:24:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97BA206D5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 19:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97BA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49TGdP48k8zDr1V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2020 05:24:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.67; helo=mail-io1-f67.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49TGYM3yD6zDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2020 05:20:55 +1000 (AEST)
Received: by mail-io1-f67.google.com with SMTP id d5so3011171ios.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 12:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7QXy8aTnpYj4ZL7eavU1d7UIYAYQxy4JmDn6cV7LhWI=;
 b=Zf1IoQJ41jdjangnSUh17nyaUJkhdliP7hPUKS/yfATfPBK47ATJVRSm0ABwPhE4gI
 Q872s1lto3bjbfpLLIMcl20j6/4xVTtfNK272k0aooyNvS5+yLTd0g2/eZdxur81gau5
 etPdQjiIOKmDsioXJUKODB4Z+zfNkAUApZsaIXP87WdO+IuWG29ontwd9ZFc8Fd5BcW7
 wV3buO3WXnIZ/u3Dy9Bb0NJ6UdbdKq0czbKpBYCFsuXdmaU9BOM99hT6I7JlIP2e9/gh
 RxwScj+bmF3efE0pBL3sh2v4Tev3dRDVDkvhrpnNALvw/Wft06F+IhjkfR5hByUfgZ2d
 gAvA==
X-Gm-Message-State: AOAM5336sc+RcDNUi7jf2HBsDexvcQpCosGZaNH32dY4P1I45eHvF47F
 aCs9UAf7Gbumtc0cnRGgTsxwFH46
X-Google-Smtp-Source: ABdhPJxCyt+TlQC88Zk0ajSD2i9H1lNRWydRo1JVKySyyv388bo7IR2VmtXnve0ZLT2pySRMIVrIig==
X-Received: by 2002:a02:2a47:: with SMTP id w68mr9517713jaw.76.1590175252061; 
 Fri, 22 May 2020 12:20:52 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com.
 [209.85.166.179])
 by smtp.gmail.com with ESMTPSA id k7sm4880050ilr.41.2020.05.22.12.20.51
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 12:20:51 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id y17so9547285ilg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 12:20:51 -0700 (PDT)
X-Received: by 2002:a92:de02:: with SMTP id x2mr15117816ilm.267.1590175251164; 
 Fri, 22 May 2020 12:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200520091543.44692-1-biwen.li@oss.nxp.com>
In-Reply-To: <20200520091543.44692-1-biwen.li@oss.nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 22 May 2020 14:20:28 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ0Q1hSi+nOqwz5Ej0K6Nc0+8376aVN6yyJ4OhkyENPDg@mail.gmail.com>
Message-ID: <CADRPPNQ0Q1hSi+nOqwz5Ej0K6Nc0+8376aVN6yyJ4OhkyENPDg@mail.gmail.com>
Subject: Re: [v2 1/2] dts: ppc: t4240rdb: remove interrupts property
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

On Wed, May 20, 2020 at 4:21 AM Biwen Li <biwen.li@oss.nxp.com> wrote:
>
> From: Biwen Li <biwen.li@nxp.com>
>
> This removes interrupts property to drop warning as follows:
>     - $ hwclock.util-linux
>       hwclock.util-linux: select() to /dev/rtc0
>       to wait for clock tick timed out
>
> My case:
>     - RTC ds1374's INT pin is connected to VCC on T4240RDB,
>       then the RTC cannot inform cpu about the alarm interrupt

The commit message need a little bit improvement.  Something like:

Since the interrupt pin for RTC DS1374 is not connected to the CPU on
T4240RDB, remove
the interrupt property from the device tree.

This also fix the following warning for hwclock.util-linux:
  $ hwclock.util-linux
   hwclock.util-linux: select() to /dev/rtc0
   to wait for clock tick timed out

>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
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
