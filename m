Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48453C43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 21:21:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC394206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 21:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC394206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MPk833DFzF3M6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 07:21:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MPgz6cxFzF3JQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 07:19:27 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id c20-v6so822329otl.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 14:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVJ1BzTPqVwuEsAYNRRGQSay6V5VghQOpTKMdwNYelU=;
 b=pagMWXjEaLFyDJUhubOhiij65rbWEOb+UJgdeE9NJWWPFTRhUeBP3dyxX5E8t9OvJS
 X3KFZ2W5ACBUlH854GebP8jO7GKpTUUZufXaKzIBihpG3LNaKpqgPjhjxlh0oyENJkeW
 jMGR9Zndy6W0Jz3EYpTihUuBwOiUQFXnqcvclMPuaHPkN7yci69ZEimh3riWf4dE9fLC
 sx2ps0hKR0ZcnPsmLsUhM/IFY4fl5HrZAxvqBiszLEeox+4AOvGK42nCo6xqCaZGqyjt
 ZWT5+S6cIuiiKhgDJNAT64eX5eZT5CO7LSJ5DvpbVvGqQFNoSLMd60TytwF99V/5WMDB
 uPVg==
X-Gm-Message-State: ABuFfojfy/V/P5Z/MOAtsOdXpaBZHPTGkNKgT4nZn0a1feh41PHObhxZ
 6V8268VoEUMrVGg3Kr7Hd5qtTFEcX9w=
X-Google-Smtp-Source: ACcGV62GYMx5aKGxUueHNw73dHXitagjR5mWZAKK1T2z2PaKZNpEsphi6gfi2X1TCNMbgaFCI2tG3g==
X-Received: by 2002:a9d:502b:: with SMTP id
 a43-v6mr271261oth.195.1538169565507; 
 Fri, 28 Sep 2018 14:19:25 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com.
 [209.85.210.48])
 by smtp.gmail.com with ESMTPSA id p132-v6sm1965927oia.31.2018.09.28.14.19.24
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 14:19:25 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id b43-v6so2941798otd.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 14:19:24 -0700 (PDT)
X-Received: by 2002:a9d:1ab:: with SMTP id e40-v6mr290858ote.68.1538169564711; 
 Fri, 28 Sep 2018 14:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
 <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
In-Reply-To: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 28 Sep 2018 16:19:13 -0500
X-Gmail-Original-Message-ID: <CADRPPNTovoNaY-suhmeM2YCGHTe6UsQ5FnkOCuPef=uUxi74-Q@mail.gmail.com>
Message-ID: <CADRPPNTovoNaY-suhmeM2YCGHTe6UsQ5FnkOCuPef=uUxi74-Q@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To: Rob Herring <robh+dt@kernel.org>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, frowand.list@gmail.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 28, 2018 at 4:00 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
> > >
> > > Hi Rob and Grant,
> > >
> > > Various device tree specs are recommending to include all the
> > > potential compatible strings in the device node, with the order from
> > > most specific to most general.  But it looks like Linux kernel doesn't
> > > provide a way to bind the device to the most specific driver, however,
> > > the first registered compatible driver will be bound.
> > >
> > > As more and more generic drivers are added to the Linux kernel, they
> > > are competing with the more specific vendor drivers and causes problem
> > > when both are built into the kernel.  I'm wondering if there is a
> > > generic solution (or in plan) to make the most specific driver bound
> > > to the device.   Or we have to disable the more general driver or
> > > remove the more general compatible string from the device tree?
> >
> > It's been a known limitation for a long time. However, in practice it
> > doesn't seem to be a common problem. Perhaps folks just remove the
> > less specific compatible from their DT (though that's not ideal). For
> > most modern bindings, there's so many other resources beyond
> > compatible (clocks, resets, pinctrl, etc.) that there are few generic
> > drivers that can work.
> >
> > I guess if we want to fix this, we'd need to have weighted matching in
> > the driver core and unbind drivers when we get a better match. Though
> > it could get messy if the better driver probe fails. Then we've got to
> > rebind to the original driver.
>
> Probably we can populate the platform devices from device tree after
> the device_init phase?  So that all built-in drivers are already
> registered when the devices are created and we can try find the best
> match in one go?  For more specific loadable modules we probably need
> to unbind from the old driver and bind to the new one.  But I agree
> with you that it could be messy.
>
> >
> > Do you have a specific case where you hit this?
>
> Maybe not a new issue but "snps,dw-pcie" is competing with various
> "fsl,<chip>-pcie" compatibles.  Also a specific PHY
> "ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".

The ethernet-phy issue is not related to the general device binding
framework, it should be an issue with the of_mdio framework. But it is
still a inalignment with the device tree recommendation.

Regards,
Leo
