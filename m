Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 6C682DDED5
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 05:57:02 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so3901281rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 10:56:59 -0800 (PST)
Message-ID: <9e4733910801021056y67172c4cif54faea48effe66d@mail.gmail.com>
Date: Wed, 2 Jan 2008 13:56:58 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <fa686aa40801021050v7476fe54uc5589092d0661ac5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
	<fa686aa40801020832y373c091dn925bfe64afddcb81@mail.gmail.com>
	<9e4733910801020912k50dceaebm11b59c1cee571e56@mail.gmail.com>
	<fa686aa40801020922q6fbda176l5fc7c80b5e61281f@mail.gmail.com>
	<9e4733910801021043l7571ea00o7b8072b04ca68ad5@mail.gmail.com>
	<fa686aa40801021050v7476fe54uc5589092d0661ac5@mail.gmail.com>
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

On 1/2/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 1/2/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 1/2/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > > Alternatively, the best place for this device would be on the ASOC
> > > > bus, but the ASOC bus hasn't been created when the platform code runs.
> > > > Maybe I can figure out a place in the platform code to create this
> > > > device after the ASOC driver has loaded and created the bus. Does the
> > > > platform code get control back after loading all of the device
> > > > drivers?
> > >
> > > Yes, but it requires the core ASoC code to not be a module.  Then you
> > > can use machine_device_initcall() to register the device at a later
> > > time.
> >
> > How about this for a simpler solution? My mpc5200-psc-ac97 and
> > mpc5200-psc-i2c drivers can create a device on the ASOC bus named
> > after the first entry in the compatible field of the root node. That
> > will cause the correct driver to get activated. I'm in the process of
> > making ASOC drivers dynamically loadable like the i2c ones.
>
> I little icky, but it doesn't sound dangerous (as in shouldn't cause
> any name conflicts).  That may be the best we can do for the time
> being.  But I don't think it is a good idea for the long term.

Simplest long term fix is to allow drivers to bind on the root node.
Make this work:

> static struct of_device_id fabric_of_match[] = {
>         {
>                 .compatible     = "fsl,MPC8610HPCD",
>         },
>         {},
> };



>
> Cheers,
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Jon Smirl
jonsmirl@gmail.com
