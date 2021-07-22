Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8EEC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jul 2021 19:38:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FBD60EB5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jul 2021 19:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37FBD60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GW2nB1rylz30Fy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 05:38:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.222.171;
 helo=mail-qk1-f171.google.com; envelope-from=pku.leo@gmail.com;
 receiver=<UNKNOWN>)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GW2mm5zl6z2yP5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2021 05:38:16 +1000 (AEST)
Received: by mail-qk1-f171.google.com with SMTP id n10so6488930qke.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2021 12:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rrCcO1rl/jimbgMioNh66hv+GfxnblGwSC/dwoJZl/s=;
 b=N2yMAJMDjf8qZelhxwWSBd5ylUKHcul/ePqtY0L+K7S8F7YNv6Wy4NwdNc+s6N4Vmg
 1RlcD0A78RCgo9V/UsKScQeaflShB622sOCCLBbdTBlVa/FLauKOAjQJcIl3JsW+xMi7
 U5x0txZJSE2Rma/GZ5UmC5+/3pCoOj+30cp9Z4ANaSuI9ZWSxtmsAvkM+5UJS0vIQjFM
 W2oPROLb2ILqfP3YlaDQr2UYGPuMyR4I7f9mJ+Wiidkiq4FZugysdiWmtqojuMkOMeOL
 QMGZnbJ5qf4bX8ISkpaM/XdM2swL7pVUy5azJi60532FghoQPLMYep8qqJBIoAqMIDB8
 Ivdg==
X-Gm-Message-State: AOAM531KVnLct3E93jVfJd+NWW6j+c5y/K2DkMKzQHjzePlkhUg5PDR9
 hZvsZQlIDLgZYeYAZcVegcklTNcvgVQ=
X-Google-Smtp-Source: ABdhPJxCReMLrzQVOL4vf3sZqVvkxr/dFvmpkzkytuZkykDw+4J+HEMQKWVeZhzJump3Emvhkkxraw==
X-Received: by 2002:a37:e109:: with SMTP id c9mr1284011qkm.480.1626982692205; 
 Thu, 22 Jul 2021 12:38:12 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com.
 [209.85.160.173])
 by smtp.gmail.com with ESMTPSA id 6sm13292030qkv.115.2021.07.22.12.38.10
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 12:38:11 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id a19so169200qtx.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2021 12:38:10 -0700 (PDT)
X-Received: by 2002:ac8:7c44:: with SMTP id o4mr1090841qtv.191.1626982690807; 
 Thu, 22 Jul 2021 12:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210705111250.1513634-1-fido_max@inbox.ru>
 <CADRPPNRYDBFHEppfpYLwsy7MMEdtsOLS764MJboL9ERW0-KK3Q@mail.gmail.com>
 <ec981260-fbe3-5cc4-1da3-dfb2f70f8f85@inbox.ru>
In-Reply-To: <ec981260-fbe3-5cc4-1da3-dfb2f70f8f85@inbox.ru>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 22 Jul 2021 14:37:59 -0500
X-Gmail-Original-Message-ID: <CADRPPNST8XRhO5yR7p8pSbbJCO7xwhF2W3WZ7R=63mTET+fAdA@mail.gmail.com>
Message-ID: <CADRPPNST8XRhO5yR7p8pSbbJCO7xwhF2W3WZ7R=63mTET+fAdA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: convert QE interrupt controller to
 platform_device
To: Maxim Kochetkov <fido_max@inbox.ru>
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
Cc: saravanak@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Zhao Qiang <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 19, 2021 at 1:57 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>
> 15.07.2021 01:29, Li Yang wrote:
> >  From the original code, this should be type = "qeic".  It is not
> > defined in current binding but probably needed for backward
> > compatibility.
>
> I took these strings from this part:
>
>         np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
>
>         if (!np) {
>
>                 np = of_find_node_by_type(NULL, "qeic");
>
>                 if (!np)
>
>                         return -ENODEV;
>
>         }
>
> However I can't find usage of "qeic" in any dts, so I will drop this in V2

It is really a bit hard to find as it is pretty old.  But it was
really used up until this commit below in 2008.  So probably it will
be better to keep it just for backward compatibility?

commit a2dd70a11d4c9cb8a4e4bb41f53a9b430e08559b
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Jan 24 18:39:59 2008 +0300

    [POWERPC] QE: get rid of most device_types and model

    Now we're searching for "fsl,qe", "fsl,qe-muram", "fsl,qe-muram-data"
    and "fsl,qe-ic".

    Unfortunately it's still impossible to remove device_type = "qe"
    from the existing device trees because older u-boots are looking for it.

    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Regards,
Leo
