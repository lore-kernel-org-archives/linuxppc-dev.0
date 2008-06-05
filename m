Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39C31DEBF0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 04:41:32 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55IfT55004214
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 14:41:29 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55IfMGS1540244
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 14:41:23 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55IfIlC024723
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 12:41:19 -0600
Date: Thu, 5 Jun 2008 13:40:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605134057.346e1149@zod.rchland.ibm.com>
In-Reply-To: <484831E6.8090509@freescale.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
	<484831E6.8090509@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 05 Jun 2008 13:35:18 -0500
Timur Tabi <timur@freescale.com> wrote:

> Josh Boyer wrote:
> 
> > I don't understand this statement.  Are your I2C macros hot-pluggable?
> > Can you dynamically add/remove an I2C engine on your hardware somehow?
> > Are you mucking about with the DTB and randomly moving around the I2C
> > node blobs so they probe order differs from boot to boot?
> > 
> > If not, then the probe order will be static for every boot. 
> 
> You're making two assumptions:
> 
> 1) That every I2C adapter will be present in the device tree.  Some device trees
> don't list I2C adapters if there are no devices on them.

Which isn't a problem.

> 2) That the nodes in the device tree are put in order

Which isn't a problem.

> Besides, let's say I have a pointer to a specific I2C device node in the tree.
> How do I find out the bus number it's on?  With my way, it's easy:
> 
> iprop = of_get_property(of_get_parent(codec_np), "cell-index", NULL);
> bus = *iprop;
> 
> With your way, I'll need to scan the entire device tree, poking inside each I2C
> adapter node looking for my I2C device node while keeping track of the I2C adapters.
> 
> > You can
> > assign the index 
> 
> Assign it to where?  When the fabric driver goes to find codec nodes, the only
> information it has is the device tree.  So when I assign this index to some
> random variable that you're talking about, my fabric driver will know nothing
> about that.

Your driver is sufficiently different then.  The i2c-ibm_iic driver
keeps an index property in it's private device structure.

> > using a static int that is incremented after each node
> > is discovered and the ordering of the devices will never change.  Can
> > you explain why something like that isn't possible or sufficient?
> 
> Yes, I just did.

Sort of.

> > (And I'm talking about I2C, not DMA.  I don't care about DMA because
> > this conversation will go off into the weeds if we start talking about
> > cell-index and every possible device out there.)
> 
> But we are talking about every device.  It's the same problem for every device.
>  Making this problem I2C-specific is not going to solve anything.

I've been driven to the point of not caring anymore.

If you need a simple index property, then maybe Sean was right to just
call the damn thing "index".  Overloading "cell-index", which already
has a specific semantic associated with it, seems odd to me.

josh
