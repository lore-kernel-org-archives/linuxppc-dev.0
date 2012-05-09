Return-Path: <chf.fritz@googlemail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B14DB6F13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 15:38:36 +1000 (EST)
Received: by wibhr2 with SMTP id hr2so39425wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2012 22:38:32 -0700 (PDT)
Date: Wed, 9 May 2012 07:38:27 +0200
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Chen Peter-B29397 <B29397@freescale.com>, Chao Xie <cxie4@marvell.com>
Subject: Re: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Message-ID: <20120509053826.GA3492@lovely.krouter>
References: <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49BA@SC-VEXCH4.marvell.com>
 <F281D0F91ED19E4D8E63A7504E8A649803B91E69@039-SN2MPN1-022.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B91E69@039-SN2MPN1-022.039d.mgd.msft.net>
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Russell King <linux@arm.linux.org.uk>, Neil Zhang <zhangwm@marvell.com>,
 Fabio Estevam <festevam@gmail.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

 thanks you for your help.

On Wed, May 09, 2012 at 02:11:56AM +0000, Chen Peter-B29397 wrote:
> 
>  
> > >
> > > after a while of testing and searching I can come up with a patch
> > > that fixes g_ether <-> iperf for fsl_udc on ARM i.MX35.
> > >
> > > The sad part is that this kind of fix is already implemented for
> > > marvell mv_udc driver since last year but still _not_ in the ~15
> > > other *udc.c drivers.
> > >
>  
> It is a controller limitation (bug?) for chipidea controller when using
> dtd list to handle multi-dtds situation. The controller will read dtd's
> next pointer after this dtd's active bit has already been cleared.
> 
> Freescale has an errata for this problem's description and solution.
> http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> See 2858

I'm hacking here an i.MX35 not an i.MX23. So I already had a look at its
errata sheet http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
but didn't find a similar "limitation" as you now pointed out by errata
number 2858 for i.MX23.

What about the fix for mv_udc, shouldn't they have a similar
"limitation"? How do you explain?
Or maybe someone from Marvell has an answer?


Thanks,
 -- Christoph
