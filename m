Return-Path: <B29397@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1113EB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 12:12:04 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Neil Zhang <zhangwm@marvell.com>, Christoph Fritz
 <chf.fritz@googlemail.com>, Fabio Estevam <festevam@gmail.com>, Li
 Yang-R58472 <r58472@freescale.com>, Felipe Balbi <balbi@ti.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel
 Mack <daniel@caiaq.de>
Subject: RE: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Date: Wed, 9 May 2012 02:11:56 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B91E69@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1333796272.3450.92.camel@lovely>
 <F281D0F91ED19E4D8E63A7504E8A64980AFFE3@039-SN2MPN1-022.039d.mgd.msft.net>
 <CAOMZO5AjQsNw7_4ETkB38mmuBXj4pnCwJwAsi4zC4b_83=Enfw@mail.gmail.com>
 <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49BA@SC-VEXCH4.marvell.com>
In-Reply-To: <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49BA@SC-VEXCH4.marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Estevam Fabio-R49496 <r49496@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Ido Shayevitz <idos@codeaurora.org>,
 Ben Dooks <ben-linux@fluff.org>, Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Russell King <linux@arm.linux.org.uk>, Chao Xie <cxie4@marvell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


=20
> >
> > after a while of testing and searching I can come up with a patch
> > that fixes g_ether <-> iperf for fsl_udc on ARM i.MX35.
> >
> > The sad part is that this kind of fix is already implemented for
> > marvell mv_udc driver since last year but still _not_ in the ~15
> > other *udc.c drivers.
> >
=20
It is a controller limitation (bug?) for chipidea controller when using
dtd list to handle multi-dtds situation. The controller will read dtd's
next pointer after this dtd's active bit has already been cleared.

Freescale has an errata for this problem's description and solution.
http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
See 2858

BR,
Peter
