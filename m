Return-Path: <pku.leo@gmail.com>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kb003vBFzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 08:12:00 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so2843044oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 15:12:00 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id m4-v6sm1049211oic.34.2018.09.25.15.11.56
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Sep 2018 15:11:57 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id q4-v6so12966841otf.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 15:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
In-Reply-To: <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 25 Sep 2018 17:11:44 -0500
Message-ID: <CADRPPNSwGDsLctOe_yiFBfYVQU3Jm7Z724wyhBFuWmaTZq0T9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To: Olof Johansson <olof@lixom.net>
Cc: alexandre.belloni@bootlin.com, Roy Pledge <roy.pledge@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2018 at 2:47 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
>
> On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > unmapped page.
> >
> > This leads to a crash when probing  qman_portal as the init_pcfg function
> > calls qman_liodn_fixup that tries to read qman registers.
> >
> > Assume that qman didn't probe when the pool mask is 0.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > index a120002b630e..4fc80d2c8feb 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> >         }
> >
> >         pcfg->pools = qm_get_pools_sdqcr();
> > +       if (pcfg->pools == 0)
> > +               return -EPROBE_DEFER;
>
> This is quite late in the probe, after a bunch of resources have been claimed.
>
> Note that the ioremaps above this are doing unwinds, and you'll end up
> doing duplicate ioremaps if you come in and probe again.
>
> You should probably unwind those allocations, or move them to devm_*
> or do this check earlier in the function.

Hi Roy,

Is there any more straightforward indicator on if qman has been
probed?  So that we can check it at the begining of the probe?

Regards,
Leo
