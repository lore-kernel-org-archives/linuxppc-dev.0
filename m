Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id BAA28DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:22:12 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1051055anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 09:22:11 -0800 (PST)
Message-ID: <fa686aa40801020922q6fbda176l5fc7c80b5e61281f@mail.gmail.com>
Date: Wed, 2 Jan 2008 10:22:11 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <9e4733910801020912k50dceaebm11b59c1cee571e56@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
	<fa686aa40801020832y373c091dn925bfe64afddcb81@mail.gmail.com>
	<9e4733910801020912k50dceaebm11b59c1cee571e56@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 1/2/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 1/2/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> > > mpc8610_hpcd is the harder one to load since it doesn't have a device
> > > tree entry. What you want to do it match on the compatible field of
> > > the root node.
> > >
> > > static struct of_device_id fabric_of_match[] = {
> > >         {
> > >                 .compatible     = "fsl,MPC8610HPCD",
> > >         },
> > >         {},
> > > };
> > >
> > > But this doesn't work since the root is the device tree isn't passed
> > > down into the device probe code. (Could this be fixed?)
> >
> > The driver can always get the root node.  But better yet, instantiate
> > the correct fabric device (probably as a platform_device) from the
> > platform code.  Then the correct fabric driver can probe against it.
>
> The meaning of this has finally sunk into my consciousness. The
> platform code can create a device that isn't bound to a driver. So why
> not make this an of_platform_device?  This is basically a pseudo
> device that isn't in the device tree.

Simply because it doesn't have a device node.  That's the prime
characteristc that differentiates platform_bus from of_platform_bus.
What do you bind against in of_platform_bus if you don't have a
specific node for it?

> Alternatively, the best place for this device would be on the ASOC
> bus, but the ASOC bus hasn't been created when the platform code runs.
> Maybe I can figure out a place in the platform code to create this
> device after the ASOC driver has loaded and created the bus. Does the
> platform code get control back after loading all of the device
> drivers?

Yes, but it requires the core ASoC code to not be a module.  Then you
can use machine_device_initcall() to register the device at a later
time.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
