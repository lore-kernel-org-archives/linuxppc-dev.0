Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 4F334DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:34:14 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so3852158rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 07:34:14 -0800 (PST)
Message-ID: <9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
Date: Wed, 2 Jan 2008 10:34:13 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>,
	"Liam Girdwood" <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477BAB67.4080003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
> > On 1/1/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> >>> +               ssi@16000 {
> >>> +                       compatible = "fsl,ssi";
> >>> +                       cell-index = <0>;
> >>> +                       reg = <16000 100>;
> >>> +                       interrupt-parent = <&mpic>;
> >>> +                       interrupts = <3e 2>;
> >>> +                       fsl,mode = "i2s-slave";
> >>> +                       codec {
> >>> +                               compatible = "cirrus,cs4270";
> >>> +                               /* MCLK source is a stand-alone oscillator */
> >>> +                               bus-frequency = <bb8000>;
> >>> +                       };
> >>> +               };
> >> Does this need to be bus-frequency? It's always called MCLK in all of
> >> the literature.
> >>
> >> In my case the MCLK comes from a chip on the i2c bus that is
> >> programmable How would that be encoded?.
> >
> > Looking at the cs4270 codec driver it is controlled by i2c (supports
> > SPI too).  What happened to the conversation about putting codecs on
> > the controlling bus and then linking them to the data bus?
>
> The current CS4270 driver doesn't support device trees.  When I wrote
> it, the idea of putting I2C info in the device tree was not finalized,
> and since the driver is supposed to be cross-platform, I decided to do
> it the old-fashioned way.  Before I update the code, however, I'm
> waiting for:
>
> 1) The current code to be accepted into the tree
> 2) ASoC is updated to V2
> 3) The current drivers are updated to support ASoC V2.

I've been trying to get the i2c code in for two months. Hopefully it
will go in soon, no one had made any comments on it recently. Have you
tried your code with it?

There is nothing stopping your from putting a node for the CS4270 on
the i2c bus today. It just won't trigger the loading of the driver.

Don't we want to follow the device tree policy of putting the device
on the controlling bus and then link it to the data bus?

> I think ASoC V2 will make it easier to support device trees, but I'm not
> ready yet for that.

It makes it a little easier but it doesn't fix everything. We need to
start looking at it since none of the example driver for it are device
tree based. It still has problems with wanting 'struct
platform_device' when we have 'struct of_platform_device' pointers. It
also doesn't know how to dynamically load codecs based on device
trees.

Liam messed up all of my code when he refactored it in late December.
I've switched over to the current SOC code for the moment. The big
thing that v2 fixes is that SOC is changed to being a subsystem
instead of platform driver. Being a subsystem is the correct model.

It would be good if more pieces of v2 get push forward. Then we can
sort out the device tree issues in it.


>
> > If that's the case the cs4270 should be in the i2c bus node (missing
> > currently) and then a link from the SSI bus would point to it.
>
> The CS4270 is a child of both the I2C bus *and* the SSI bus.  It needs
> to have two nodes, one under each.  Your're right in that there needs to
> be a link, but until the code is updated to ASoC V2, I think it's
> premature to add that support.

Adding the second device tree node doesn't have anything to do with
ASOC v2. It's specific to powerpc and device trees.

-- 
Jon Smirl
jonsmirl@gmail.com
