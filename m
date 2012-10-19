Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F0C82C007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:46:58 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so120616bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:46:55 -0700 (PDT)
Subject: Re: [PATCH 5/7] usb: gadget: fsl_udc: postpone freeing current dTD
From: Christoph Fritz <chf.fritz@googlemail.com>
To: balbi@ti.com
In-Reply-To: <20121019103039.GF11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
 <20121019103039.GF11191@arwen.pp.htv.fi>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Oct 2012 12:46:48 +0200
Message-ID: <1350643608.3709.78.camel@mars>
Mime-Version: 1.0
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, linuxppc-dev@lists.ozlabs.org,
 Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-10-19 at 13:30 +0300, Felipe Balbi wrote:
> On Fri, Oct 19, 2012 at 12:24:43PM +0200, Christoph Fritz wrote:
> > USB controller may access a wrong address for the dTD (endpoint transfer
> > descriptor) and then hang. This happens a lot when doing tests with
> > g_ether module and iperf, a tool for measuring maximum TCP and UDP
> > bandwidth.
> > 
> > This hardware bug is explained in detail by errata number 2858 for i.MX23:
> > http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> > 
> > All (?) SOCs with an IP from chipidea suffer from this problem.
> > mv_udc_core fixes this bug by commit daec765.  There still may be
> > unfixed drivers.
> 
> why aren't you using that driver instead ? Is it really necessary to
> keep this driver around ? I would really like to see uniformization
> towards that, if you use the same IP, then the same driver ought to
> suffice.
> 
> What's the reason for not using drivers/usb/chipidea ?
> 

I thought about this too but wasn't able to use chipidea with
MXC_EHCI_INTERNAL_PHY as it's called in fsl_udc.

Sascha, do you know if i.mx35 works with usb/chipidea?

Thanks
 -- Christoph
