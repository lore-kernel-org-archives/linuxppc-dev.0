Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A112B2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 21:49:31 +1100 (EST)
Received: by mail-ie0-f178.google.com with SMTP id c13so6200825ieb.37
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 02:49:28 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20130217101958.GR17833@n2100.arm.linux.org.uk>
References: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
 <1358473200-17886-2-git-send-email-grant.likely@secretlab.ca>
 <20130217030331.GA15048@S2101-09.ap.freescale.net>
 <20130217074317.GB16632@S2101-09.ap.freescale.net>
 <20130217101958.GR17833@n2100.arm.linux.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 17 Feb 2013 10:49:08 +0000
Message-ID: <CACxGe6sJfRZ4AaDDtoQv6c-xOdB6-=cCJSn6fKawB0ULnzQFoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: use platform_device_add
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 17, 2013 at 10:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Feb 17, 2013 at 03:43:20PM +0800, Shawn Guo wrote:
> > The patch introduce a regression on imx6q boot.  The IOMUXC block on
> > imx6q is special.  It acts not only a pin controller but also a system
> > controller with a bunch of system level registers in there.  That's why
> > we currently have the following two nodes in imx6q device tree with the
> > same start "reg" address, which work with drivers/mfd/syscon.c and
> > drivers/pinctrl/pinctrl-imx6q.c respectively.
> >
> >         gpr: iomuxc-gpr@020e0000 {
> >                 compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> >                 reg = <0x020e0000 0x38>;
> >         };
> >
> >         iomuxc: iomuxc@020e0000 {
> >                 compatible = "fsl,imx6q-iomuxc";
> >                 reg = <0x020e0000 0x4000>;
> >         };
> >
> > With the patch in place, pinctrl-imx6q fails to register like below.
> >
> > syscon 20e0000.iomuxc: syscon regmap start 0x20e0000 end 0x20e3fff registered
> > imx6q-pinctrl 20e0000.iomuxc: can't request region for resource [mem 0x020e0000-0x020e3fff]
> > imx6q-pinctrl: probe of 20e0000.iomuxc failed with error -16

Strictly you're not supposed to do that with the device tree. There
shouldn't be two nodes using the same overlapping memory region unless
they are parent/child. That rule has been around for a long time, but
the core never checked for it. What /should/ happen is the two drivers
should be cooperating for the register region and only one device
driver probe sets up both behaviours.

However, neither is it okay to just break the existing device trees.
Best thing to do I think is to deprecate one of the nodes.

>> It also breaks all of_amba_device users.
>>
>> of_amba_device_create() --> amba_device_add() --> request_resource()
>> and fails.
>
> Presumably that's because we no longer know what the parent resource
> is supposed to be?

Hmmm, it looks that way, yes. Currently the OF code is using
iomem_resource as the parent for all amba_device_add() calls
(driver/of/platform.c), but if the parent node gets registered as a
platform device and it has the resources then the parenthood chain
doesn't match up. It isn't immediately obvious to me how to fix this.
I'm going to drop the patch from my tree. I could use some help
figuring out what the correct behaviour really should be here.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
