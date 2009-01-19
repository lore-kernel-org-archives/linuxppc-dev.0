Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A009DDF38
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 04:29:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0JHTZB1023385
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 10:29:46 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0JHTZ6k013002
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 11:29:35 -0600 (CST)
Date: Mon, 19 Jan 2009 11:29:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: Device Tree setup for 8272-based board
Message-ID: <20090119172934.GE23019@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 19, 2009 at 12:58:41PM +1100, Daniel Ng wrote:
> Hi Scott,
> On Sat, Jan 17, 2009 at 5:14 AM, Scott Wood <scottwood@freescale.com> wrote:
> >
> >> /dts-v1/;
> >>
> >> / {
> >> model = "HPXRED";
> >> compatible = "fsl,mpc8272ads";
> >
> > Is it 100% compatible?  If not, change the compatible to something else
> > (and make sure your board code matches it).
> 
> My board is similar to the mpc8272ads, so it is not 100% compatible. So I guess
> I will have to define my own DTS, correct?

Yes.

> How would I be able to tell if I need my own cuboot-*.c file as well?

The separate cuboot files are based on separate bd_t layouts -- if bd_t
is the same, you don't need a new file.  That said, if you're dealing
with modern u-boot, it'd be better to just pass a device tree and use
uImage.

> > Do you currently have mpc8272ads support enabled in the kernel?  If the
> > kernel doesn't find a matching ppc_md, you won't get any debug output.
> 
> No, since it is not an mpc8272ads board.

But the device tree claims that it is.

> What exactly are we matching here?
> Is it just the Platform Name in the .config file eg. CONFIG_MPC8272_ADS?
> If I use [compatible = "fsl,hpxred";] this doesn't seem to make a difference
> in the behaviour.

In order for the kernel to boot, there has to be platform code built in
whose probe() function recognizes the device tree as one that it
supports.

> Is the ppc_md generated from the Device Tree? Can you please point me to
> the relevant file/s to see how this is done?

ppc_md is in platform files such as
arch/powerpc/platforms/82xx/mpc8272_ads.c.

> Also, which kernel file deals with searching for/reading the ppc_md?

probe_machine() in arch/powerpc/kernel/setup-common.c.

> > You can use udbg_printf() directly after the call to udbg_early_init()
> > though.
> 
> Would I use these in cuboot-*.c?

No, this is in the kernel, not the bootwrapper.

-Scott
