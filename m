Return-Path: <pku.leo@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420P8N05JnzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 08:49:39 +1000 (AEST)
Received: by mail-io0-f195.google.com with SMTP id v14-v6so2877549iob.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 15:49:39 -0700 (PDT)
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com.
 [209.85.214.45])
 by smtp.gmail.com with ESMTPSA id a11-v6sm1263381ita.21.2018.08.28.15.49.37
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Aug 2018 15:49:37 -0700 (PDT)
Received: by mail-it0-f45.google.com with SMTP id j81-v6so5049756ite.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 15:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 28 Aug 2018 17:49:25 -0500
Message-ID: <CADRPPNRJFii=ybTVm=NMGMT8U02JKsjYsgA6PR52owK=Bc3cgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To: Roy Pledge <roy.pledge@nxp.com>
Cc: alexandre.belloni@bootlin.com,
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

On Fri, Aug 24, 2018 at 9:54 AM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> On 8/23/2018 5:36 PM, Alexandre Belloni wrote:
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

Series applied to the fix branch of soc/fsl.

> > ---
> >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > index a120002b630e..4fc80d2c8feb 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> >       }
> >
> >       pcfg->pools = qm_get_pools_sdqcr();
> > +     if (pcfg->pools == 0)
> > +             return -EPROBE_DEFER;
> >
> >       spin_lock(&qman_lock);
> >       cpu = cpumask_next_zero(-1, &portal_cpus);
>
> Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
>
>
