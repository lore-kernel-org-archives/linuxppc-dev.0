Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D2C8C14009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 08:38:51 +1100 (EST)
Message-ID: <1396388317.32034.14.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] Make the diu driver work without board level
 initilization
From: Scott Wood <scottwood@freescale.com>
To: Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
Date: Tue, 1 Apr 2014 16:38:37 -0500
In-Reply-To: <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
 <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
 <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Xiubo Li-B47053 <Li.Xiubo@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "timur@tabi.org" <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-01 at 02:28 -0500, Jin Zhengxiong-R64188 wrote:
> > > +	if (!diu_ops.set_pixel_clock) {
> > > +		data->pixelclk_reg = of_iomap(np, 1);
> > > +		if (!data->pixelclk_reg) {
> > > +			dev_err(&pdev->dev, "Cannot map pixelclk registers,
> > please \
> > > +				provide the diu_ops for pixclk setting
> > instead.\n");
> > 
> > The error message should be in one line if possible, or it will hard to
> > grep.
> > If cannot, should split it into two or more lines, like:
> >  +			dev_err(&pdev->dev, "Cannot map pixelclk registers,\n"
> >  +				"please provide the diu_ops for pixclk setting
> > instead.\n");
> Thanks, This has been fixed in the update version, please help to review it at:
> http://patchwork.ozlabs.org/patch/335225/
> I forgot to add the V2 information in the subject in the update patch so this may confuse the reviewer, sorry for that.

It is not fixed in that patch (or did you link the wrong version?).  You
should never use \ to continue a line in C, other than in macros.

Further, it is not permitted to wrap kernel output strings.  This is an
exception to the 80-column rule.  Checkpatch should have told you this.

-Scott
