Return-Path: <R58495@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CFE1B7CB8
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 03:15:57 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1IGFdfl012613
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 09:15:49 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o1IGNGTe017921
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 10:23:17 -0600 (CST)
Subject: Re: [PATCH v3 09/11] powerpc/mpc5121: shared DIU framebuffer support
From: York Sun <yorksun@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-10-git-send-email-agust@denx.de>
	<fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Feb 2010 10:15:45 -0600
Message-ID: <1266509745.25353.16.camel@oslab-l1>
Mime-Version: 1.0
Cc: wd@denx.de, dzu@denx.de, John Rigby <jrigby@gmail.com>,
	linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-02-16 at 11:06 -0700, Grant Likely wrote:
> [...]
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index 72d68b3..29c7f31 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -34,7 +34,7 @@
> >  #include <linux/of_platform.h>
> >
> >  #include <sysdev/fsl_soc.h>
> > -#include "fsl-diu-fb.h"
> > +#include <linux/fsl-diu-fb.h>
> >
> >  /*
> >  * These parameters give default parameters
> > @@ -178,6 +178,21 @@ static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
> >                .sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> >                .vmode          = FB_VMODE_NONINTERLACED
> >        },
> > +       {
> > +               .name           = "800x480-60",
> > +               .refresh        = 60,
> > +               .xres           = 800,
> > +               .yres           = 480,
> > +               .pixclock       = 31250,
> > +               .left_margin    = 86,
> > +               .right_margin   = 42,
> > +               .upper_margin   = 33,
> > +               .lower_margin   = 10,
> > +               .hsync_len      = 128,
> > +               .vsync_len      = 2,
> > +               .sync           = FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> > +               .vmode          = FB_VMODE_NONINTERLACED
> > +       },
> >  };
> 
> This hunk bothers me.  It looks like the type of data that belongs
> either in some common shared .c file, or encoded into the device tree.
>  It seems to be data about the display panel, instead of data about
> the framebuffer driver.  I know that the driver already uses this
> pattern, but before I merge this patch and further rely on that
> pattern, I think it is worth discussing.
> 
> Kumar, York, thoughts?
> 
> g.
> 

It is a hardware related configuration. It is only used during booting
before other configuration comes available.

I am OK to move it to anywhere as long as it doesn't get confused or
lost.

York
