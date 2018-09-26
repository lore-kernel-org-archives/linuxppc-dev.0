Return-Path: <pku.leo@gmail.com>
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L5lK12FmzF3LF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 04:17:48 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id c12-v6so29134768otl.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 11:17:48 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com.
 [209.85.210.49])
 by smtp.gmail.com with ESMTPSA id 63-v6sm5573749oti.68.2018.09.26.11.17.45
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Sep 2018 11:17:45 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id j9-v6so29159595otl.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 11:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
 <20180926092706.GA16644@piout.net>
In-Reply-To: <20180926092706.GA16644@piout.net>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 26 Sep 2018 13:15:15 -0500
Message-ID: <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To: alexandre.belloni@bootlin.com
Cc: Olof Johansson <olof@lixom.net>, Roy Pledge <roy.pledge@nxp.com>,
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

On Wed, Sep 26, 2018 at 4:28 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 25/09/2018 21:45:56+0200, Olof Johansson wrote:
> > Hi,
> >
> >
> > On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > > unmapped page.
> > >
> > > This leads to a crash when probing  qman_portal as the init_pcfg function
> > > calls qman_liodn_fixup that tries to read qman registers.
> > >
> > > Assume that qman didn't probe when the pool mask is 0.
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> > >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > > index a120002b630e..4fc80d2c8feb 100644
> > > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> > >         }
> > >
> > >         pcfg->pools = qm_get_pools_sdqcr();
> > > +       if (pcfg->pools == 0)
> > > +               return -EPROBE_DEFER;
> >
> > This is quite late in the probe, after a bunch of resources have been claimed.
> >
> > Note that the ioremaps above this are doing unwinds, and you'll end up
> > doing duplicate ioremaps if you come in and probe again.
> >
> > You should probably unwind those allocations, or move them to devm_*
> > or do this check earlier in the function.
> >
>
> The actual chance of having that happen is quite small (this was coming
> from a non working DT) and I mainly wanted to avoid a crash so the
> platform could still boot. I would think moving to devm_ would be the
> right thing to do.

Even if it is not failing with the upstreamed device trees, it is
still good to harden the driver for possible issues.  Moving to devm_
is definitely a right thing to do.  But I also think checking if the
qman is already probed should be the first thing to do before starting
to allocate resources and etc and rolling back later.  Probably we can
move the qm_get_pools_sdqcr() to the begining of the probe to
determine if qman is probed as it doesn't seem to depend on any of the
setups done right now.

Regards,
Leo
