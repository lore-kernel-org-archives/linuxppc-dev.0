Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 2590BB6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 18:28:37 +1000 (EST)
Received: by eyh6 with SMTP id 6so6231531eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 01:28:36 -0700 (PDT)
Date: Wed, 28 Jul 2010 12:28:34 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
Message-ID: <20100728082834.GA21186@oksana.dev.rtsoft.ru>
References: <1279815922-27198-1-git-send-email-agust@denx.de>
	<1279815922-27198-3-git-send-email-agust@denx.de>
	<AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 28, 2010 at 02:16:08AM -0600, Grant Likely wrote:
[...]
> > +static int __devinit fsl_usb2_mph_dr_of_probe(struct of_device *ofdev,
> > +                                          const struct of_device_id *match)
> > +{
> > +       struct device_node *np = ofdev->dev.of_node;
> > +       struct platform_device *usb_dev;
> > +       struct fsl_usb2_platform_data data, *pdata;
> > +       struct fsl_usb2_dev_data *dev_data;
> > +       const unsigned char *prop;
> > +       static unsigned int idx;
> > +       int i;
> > +
> > +       if (!of_device_is_available(np))
> > +               return -ENODEV;
> 
> What is this for?

USB pins/clocks might be muxed away to other peripherals, like
eSDHC. In such cases firmware marks USB as unavailable (status
= "disabled").

If you try to access USB while it is disabled the SOC will hang.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
