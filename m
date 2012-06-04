Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D2A5100880
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 21:37:42 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so3514537bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2012 04:37:39 -0700 (PDT)
Subject: Re: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <1338809424.3371.20.camel@mars>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi>  <1338809424.3371.20.camel@mars>
Content-Type: text/plain; charset="iso-8859-7"
Date: Mon, 04 Jun 2012 13:37:33 +0200
Message-ID: <1338809853.3371.31.camel@mars>
Mime-Version: 1.0
Cc: Ben Dooks <ben-linux@fluff.org>, Chen Peter-B29397 <B29397@freescale.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Fabio Estevam <festevam@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>, Christian Hemp <c.hemp@phytec.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Neil Zhang <zhangwm@marvell.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Oliver Neukum <oneukum@suse.de>, Eric Miao <eric.y.miao@gmail.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-04 at 13:30 +0200, Christoph Fritz wrote:
> Hi,
> 
> On Mon, 2012-05-21 at 22:04 +0300, Felipe Balbi wrote:
> > On Mon, May 21, 2012 at 08:57:22AM +0200, Christoph Fritz wrote:
> > > USB controller may access a wrong address for the dTD (endpoint transfer
> > > descriptor) and then hang. This happens a lot when doing tests with
> > > g_ether module and iperf, a tool for measuring maximum TCP and UDP
> > > bandwidth.
> > > 
> > > This hardware bug is explained in detail by errata number 2858 for i.MX23:
> > > http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> > > 
> > > All (?) SOCs with an IP from chipidea suffer from this problem.
> > > mv_udc_core fixes this bug by commit daec765.  There still may be
> > > unfixed drivers.
> > > 
> > > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > > Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> > > ---
> > >  drivers/usb/gadget/fsl_udc_core.c |   15 ++++++++++++++-
> > >  1 files changed, 14 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> > > index 55abfb6..72f2139 100644
> > > --- a/drivers/usb/gadget/fsl_udc_core.c
> > > +++ b/drivers/usb/gadget/fsl_udc_core.c
> > > @@ -65,6 +65,8 @@ static struct usb_sys_interface *usb_sys_regs;
> > >  /* it is initialized in probe()  */
> > >  static struct fsl_udc *udc_controller = NULL;
> > >  
> > > +static struct ep_td_struct *last_free_td;
> > 
> > I don't want to see global variables anymore. In fact, please convert
> > this to the new udc_start()/udc_stop() calls and use the generic
> > map/unmap routines.
> > 
> > That'll help you get rid of a bunch of useless code on the driver. After
> > that you should remove all <asm/*> header includes and drop the ARCH
> > dependency.
> > 
> > You can also drop the big-/little-endian helpers as you can make use of
> > generic writel()/readl() routines.
> > 
> > Please make sure these series comes in with enough time to reach v3.6
> > merge window in about 3 months.
> > 
> > You can put this fix together on that series after you drop the global.
> 
> Before I came to do the proposed changes, I stumbled upon this:
> 
> In file included from drivers/usb/gadget/fsl_udc_core.c:49:
> drivers/usb/gadget/fsl_usb2_udc.h: In function ¡get_qh_by_ep¢:
> drivers/usb/gadget/fsl_usb2_udc.h:585: error: ¡struct fsl_ep¢ has no member named ¡desc¢
> drivers/usb/gadget/fsl_udc_core.c: In function ¡done¢:
> drivers/usb/gadget/fsl_udc_core.c:187: error: ¡struct fsl_ep¢ has no member named ¡desc¢
> drivers/usb/gadget/fsl_udc_core.c:187: error: ¡struct fsl_ep¢ has no member named ¡desc¢
> <snip>
> 
> my proposed regression patch:
> ---
> From: Christoph Fritz <chf.fritz@googlemail.com>
> Date: Mon, 4 Jun 2012 12:58:21 +0200
> Subject: [PATCH] usb: gadget: regression fix - useage of usb_ep
<snip>

After that, I stumbled upon this dmesg:

Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)
fsl-usb2-udc fsl-usb2-udc: clk_get("usb") failed
fsl-usb2-udc: probe of fsl-usb2-udc failed with error -2

Sascha, could you give me a hint?

 Thanks,
  -- Christoph
