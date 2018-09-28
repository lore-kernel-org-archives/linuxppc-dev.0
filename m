Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B921CC43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 21:06:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F96206B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 21:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F96206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MPNy4bkTzF3LX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 07:06:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MPGq4kXszF3JQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 07:01:07 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id c18-v6so7361103otm.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 14:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lRsq3w2R+gURnajoQ19rTCU7wGm92qa64p4LIPgdLd8=;
 b=dIao3c/+sZ6dJHo6iqP7yh2HIC6WN83LJt2xbFIl69Q2MxL0qg+OAJg4yqnbqgPV7w
 9PS7ldu9d60J84a35KPChQBRvKh0+ONI5hAdXnKZK31FACdvriE6r0+vreJxU38qqvPD
 1m+lVblYxYr4z65ykghfDZqqZs47/X+mKeae7V3xnb6jktYjzpc3YnlL7hQta4HG+7T3
 s/TS1+TOEhAh5vTES4rNDFoOadlsEP0yv75nAnJfXqSvFJNtQHD6sTpaSe95F71uMNIi
 ARWanLaMlKb7ZcHaKMaQQ/VN4ClCaW3jsMSRVW9fg1Ra2JDMEIxyo+SmpAVZhE3WPa/4
 udmg==
X-Gm-Message-State: ABuFfojlo8MR7AH2/1zzhzJgoW1r+zbcCTa9duc+j7XP/8O59JiV8urG
 e3GGIKsL/bxMvx2zdi+6sBbvSnScw0o=
X-Google-Smtp-Source: ACcGV62j7ox3wNMGzizIS0hFRcmQNMYseqgMnkwPzw6pl8NHtCwMBlJGzcvpEgi0sFchCGUxwBBg7g==
X-Received: by 2002:a9d:b91:: with SMTP id 17-v6mr239386oth.263.1538168465210; 
 Fri, 28 Sep 2018 14:01:05 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com.
 [209.85.210.54])
 by smtp.gmail.com with ESMTPSA id n1-v6sm2290117ote.37.2018.09.28.14.01.04
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 14:01:04 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 36-v6so7306527oth.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 14:01:04 -0700 (PDT)
X-Received: by 2002:a9d:1d2a:: with SMTP id
 m39-v6mr267327otm.168.1538168464035; 
 Fri, 28 Sep 2018 14:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
In-Reply-To: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 28 Sep 2018 16:00:52 -0500
X-Gmail-Original-Message-ID: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
Message-ID: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
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

On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > Hi Rob and Grant,
> >
> > Various device tree specs are recommending to include all the
> > potential compatible strings in the device node, with the order from
> > most specific to most general.  But it looks like Linux kernel doesn't
> > provide a way to bind the device to the most specific driver, however,
> > the first registered compatible driver will be bound.
> >
> > As more and more generic drivers are added to the Linux kernel, they
> > are competing with the more specific vendor drivers and causes problem
> > when both are built into the kernel.  I'm wondering if there is a
> > generic solution (or in plan) to make the most specific driver bound
> > to the device.   Or we have to disable the more general driver or
> > remove the more general compatible string from the device tree?
>
> It's been a known limitation for a long time. However, in practice it
> doesn't seem to be a common problem. Perhaps folks just remove the
> less specific compatible from their DT (though that's not ideal). For
> most modern bindings, there's so many other resources beyond
> compatible (clocks, resets, pinctrl, etc.) that there are few generic
> drivers that can work.
>
> I guess if we want to fix this, we'd need to have weighted matching in
> the driver core and unbind drivers when we get a better match. Though
> it could get messy if the better driver probe fails. Then we've got to
> rebind to the original driver.

Probably we can populate the platform devices from device tree after
the device_init phase?  So that all built-in drivers are already
registered when the devices are created and we can try find the best
match in one go?  For more specific loadable modules we probably need
to unbind from the old driver and bind to the new one.  But I agree
with you that it could be messy.

>
> Do you have a specific case where you hit this?

Maybe not a new issue but "snps,dw-pcie" is competing with various
"fsl,<chip>-pcie" compatibles.  Also a specific PHY
"ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".

Regards,
Leo
