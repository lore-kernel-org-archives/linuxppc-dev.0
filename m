Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 7D768B70DF
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 19:31:20 +1000 (EST)
Received: by eyg24 with SMTP id 24so1787365eyg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 02:31:18 -0700 (PDT)
Date: Fri, 10 Sep 2010 13:31:13 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 1/3 v2][MTD] P4080/eLBC: Make Freescale elbc interrupt
	common to elbc devices
Message-ID: <20100910093113.GA22204@oksana.dev.rtsoft.ru>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<20100909115338.GA12320@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FBF4A@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1FBF4A@zch01exm23.fsl.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 10, 2010 at 02:58:15PM +0800, Zang Roy-R61911 wrote:
[...]
> > > +static struct of_platform_driver fsl_lbc_ctrl_driver = {
> > 
> > Need linux/of_platform.h for this.
> It has been include by
> fsl_lbc.h->linux/of_platform.h-> linux/platform_device.h
> Before submitting the patch, I have built and tested it.

In Linux we try to include all the headers explicitly (except
for asm/* if the same header name exists in linux/).

That's to avoid problems if for some reason fsl_lbc.h will stop
including of_plaform.h some day.

Oh, and by the way, there is absolutely no reason to add
linux/of_platform.h and interrupts.h into fsl_lbc.h, they're
is simply not needed in fsl_lbc.h.

> Do you think I do not build the tree before I send out the patch?

Nope, that's not what I think. I didn't say that the file
won't build w/o these fixes, but they're still needed.

> > > +
> > > +static struct of_platform_driver fsl_lbc_ctrl_driver = {
> > 
> > Need linux/of_platform.h for this.
> > 
> > But you actually don't need of_platform_driver, as for the
> > new code you can use platform_driver (and thus
> > linux/platform_device.h).
> I'd prefer using of_platform_driver here for simplified code.
> Any special reason to use platform_device here?

In the new kernels, of_platform_driver is almost a synonym of
platform_driver, and 'of_platform_driver' stuff is soon to be
deleted. You can use platform_driver just like
of_platform_driver nowadays.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
