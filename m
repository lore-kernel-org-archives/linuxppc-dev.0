Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F632B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 16:53:48 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so3759369bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2012 23:53:45 -0700 (PDT)
Subject: RE: [PATCH] usb: fsl_udc: errata - postpone freeing current dTD
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Chen Peter-B29397 <B29397@freescale.com>
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 May 2012 08:53:41 +0200
Message-ID: <1337583221.3394.21.camel@mars>
Mime-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, Russell King <linux@arm.linux.org.uk>,
 Neil Zhang <zhangwm@marvell.com>, Fabio Estevam <festevam@gmail.com>,
 Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chen,

On Mon, 2012-05-21 at 01:05 +0000, Chen Peter-B29397 wrote:
> 
>  
> > 
> > USB controller may access a wrong address for the dTD (endpoint transfer
> > descriptor) and then hang. This happens a lot when doing tests with
> > g_ether module and iperf, a tool for measuring maximum TCP and UDP
> > bandwidth.
> > 
> > This hardware bug is explained in detail by errata number 2858 for i.MX23:
> > http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> > 
> 
> Does this patch fix your problem?

yes, it does! :-)

> > +#if defined CONFIG_ARCH_MX51 || defined CONFIG_SOC_IMX35
> > +#define POSTPONE_FREE_LAST_DTD
> > +#else
> > +#undef POSTPONE_FREE_LAST_DTD
> > +#endif
> > +
> All i.mx SoC has this problem, if PowerPC also has this problem, you can 
> delete #if defined. Else, you can define it for all i.mx SoC 
> (CONFIG_ARCH_MXC | CONFIG_ARCH_MXS)

I was unsure about this too. I can only test imx35. And mx51 was defined
in your tree. So these two should be defined anyway.

Marvell doesn't use any defines in mv_udc_core for their fix, so I would
be fine without ifdefs too. Any objections? Please see next mail with
patch v2.


Thanks,
 -- Christoph
