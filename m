Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF8C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 19:27:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F75D216C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 19:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F75D216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LlDf71SnzF37q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:26:58 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LlBR2sMvzF37p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 05:25:02 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id o13-v6so3708565otl.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 12:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EzsjO9h7V10qHOZxD5XIsRojhm72Dwp0dDZrz1FkINA=;
 b=SRQflM2/bovdSATDiuOTJk7kCVoJlOOLo9d2R+1KTAELYBnWtRfExZuqTpareuWWia
 88HqkBccnFp9sa2Wpirbl8Ae3R1sNcjJRXu/j8EgrnPW1foy7xrseGOKiLNxMp6oqHlP
 2PSMc4/cvvtR4QNcuumFs9YjmkINbCekQwwFazEpWFIr5PY1l/ONuLmwCKqNbvZIuLnI
 +fM7MPh+ncbJAGVD3fna9P/ySrHXhxZejewwRku/L1sV9/tzFyLmCozrZ4AZIN0XJfRF
 DLqQmVE7kxwJ0pd1C137BQyc6+b7B9VzAl1LlB+4blSiqoUpU1tzJfyOFfLyQitHx4cV
 4ceA==
X-Gm-Message-State: ABuFfohr8aWnFypvHaMtb8k2yUHO+ZlRHBTFkRy0OH99htLcucHuprUt
 QogcuJgXuu+/fYMNuM4ymh4+xf3z2fRwpQ==
X-Google-Smtp-Source: ACcGV620AafDUZ/WTmTCeGGB6jTvia69b2pa5tOmeF8mfkO4XPKruPJBlu/T5AshDw2W/ceHWZLGCw==
X-Received: by 2002:a9d:4ea:: with SMTP id 97-v6mr7313960otm.99.1538076300791; 
 Thu, 27 Sep 2018 12:25:00 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com.
 [209.85.167.170])
 by smtp.gmail.com with ESMTPSA id z2-v6sm801573oib.40.2018.09.27.12.24.59
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 12:24:59 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id j68-v6so3197032oib.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 12:24:59 -0700 (PDT)
X-Received: by 2002:aca:5217:: with SMTP id
 g23-v6mr1132684oib.293.1538076299687; 
 Thu, 27 Sep 2018 12:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
 <20180926092706.GA16644@piout.net>
 <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
In-Reply-To: <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 27 Sep 2018 14:24:48 -0500
X-Gmail-Original-Message-ID: <CADRPPNRTWSLapqLHO=y5_Rcbh27CigAjPuorLYPrzqxUGYt-9Q@mail.gmail.com>
Message-ID:
 <CADRPPNRTWSLapqLHO=y5_Rcbh27CigAjPuorLYPrzqxUGYt-9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To: alexandre.belloni@bootlin.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
Cc: Olof Johansson <olof@lixom.net>, Roy Pledge <roy.pledge@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927192448.d4W-kd7j7mQ1JJdXfPI0WwBNut2yMKASb9zHVba_Rjc@z>

On Wed, Sep 26, 2018 at 1:15 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Wed, Sep 26, 2018 at 4:28 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 25/09/2018 21:45:56+0200, Olof Johansson wrote:
> > > Hi,
> > >
> > >
> > > On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > > > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > > > unmapped page.
> > > >
> > > > This leads to a crash when probing  qman_portal as the init_pcfg function
> > > > calls qman_liodn_fixup that tries to read qman registers.
> > > >
> > > > Assume that qman didn't probe when the pool mask is 0.
> > > >
> > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > ---
> > > >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > > > index a120002b630e..4fc80d2c8feb 100644
> > > > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > > > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > > > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> > > >         }
> > > >
> > > >         pcfg->pools = qm_get_pools_sdqcr();
> > > > +       if (pcfg->pools == 0)
> > > > +               return -EPROBE_DEFER;
> > >
> > > This is quite late in the probe, after a bunch of resources have been claimed.
> > >
> > > Note that the ioremaps above this are doing unwinds, and you'll end up
> > > doing duplicate ioremaps if you come in and probe again.
> > >
> > > You should probably unwind those allocations, or move them to devm_*
> > > or do this check earlier in the function.
> > >
> >
> > The actual chance of having that happen is quite small (this was coming
> > from a non working DT) and I mainly wanted to avoid a crash so the
> > platform could still boot. I would think moving to devm_ would be the
> > right thing to do.
>
> Even if it is not failing with the upstreamed device trees, it is
> still good to harden the driver for possible issues.  Moving to devm_
> is definitely a right thing to do.  But I also think checking if the
> qman is already probed should be the first thing to do before starting
> to allocate resources and etc and rolling back later.  Probably we can
> move the qm_get_pools_sdqcr() to the begining of the probe to
> determine if qman is probed as it doesn't seem to depend on any of the
> setups done right now.

I just find out Laurentiu also included the following patches in his
SMMU patch series (although not neccessarily related to SMMU) which
also fix the same problem.  I think they are more straightforward and
can deal with the case that qman failed to probe.  So we can take
these to fix this problem instead in 4.19.

https://patchwork.kernel.org/patch/10616021/
https://patchwork.kernel.org/patch/10616019/
https://patchwork.kernel.org/patch/10615971/

Regards,
Leo
