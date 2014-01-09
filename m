Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63DA72C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 21:37:56 +1100 (EST)
Date: Thu, 9 Jan 2014 18:34:54 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Set default slot number for
 common cases
Message-ID: <20140109103453.GC14809@MrMyself>
References: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOMZO5C8hGYehqJ6WFUKye8wENuAejT-YXggeYy7V+DQ2_OMHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOMZO5C8hGYehqJ6WFUKye8wENuAejT-YXggeYy7V+DQ2_OMHg@mail.gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fabio,

On Thu, Jan 09, 2014 at 08:24:24AM -0200, Fabio Estevam wrote:
> On Thu, Jan 9, 2014 at 7:41 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
> > For those platforms using DAI master mode like I2S, it's better to pre-set
> > a default slot number so that there's no need for these common cases to set
> > the slot number from its machine driver any more.
> >
> > Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> > ---
> >  sound/soc/fsl/fsl_ssi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index 94dedcb..57ab45b 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> > @@ -711,6 +711,16 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
> >         if (ssi_private->imx_ac97)
> >                 fsl_ssi_setup_ac97(ssi_private);
> >
> > +       /* Set a default slot number so that there is no need for those common
> > +        * cases like I2S mode to call the extra set_tdm_slot() any more.
> > +        */
> 
> Incorrect style for multi-line comment.

Is this for the initial line? The CodingStyle contains two types of multi-line
comment, one of which drops the initial line just like mine, even though it's
saying 'For files in net/ and drivers/net/ the preferred style', so I thought
it shouldn't be quite bother.

I don't mind to add it up though.

Thank you,
Nicolin
