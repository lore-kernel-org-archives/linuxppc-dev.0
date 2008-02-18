Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.240])
	by ozlabs.org (Postfix) with ESMTP id 985BEDDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:49:16 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so716262hsb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 10:49:15 -0800 (PST)
Date: Mon, 18 Feb 2008 12:49:09 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: arch_initcall time
Message-ID: <20080218124909.52796859@weaponx>
In-Reply-To: <20080218184240.GA17898@lixom.net>
References: <47B9CE4D.1020303@pikatech.com>
	<fa686aa40802181031s4ba6ec4eie949040f0bf23ad6@mail.gmail.com>
	<fa686aa40802181032lffff9e2yf079c277c250b430@mail.gmail.com>
	<20080218184240.GA17898@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Feb 2008 12:42:40 -0600
Olof Johansson <olof@lixom.net> wrote:

> On Mon, Feb 18, 2008 at 11:32:14AM -0700, Grant Likely wrote:
> > On Feb 18, 2008 11:31 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > On Feb 18, 2008 11:28 AM, Sean MacLennan <smaclennan@pikatech.com> wrote:
> > > > I need to call i2c_register_board_info for the new i2c style ad7414
> > > > driver. This needs to be called at arch initcall time. Currently I just
> > > > do this:
> > > >
> > > > static int __init warp_arch_init(void)
> > > > {
> > > >         i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
> > > >         return 0;
> > > > }
> > > > arch_initcall(warp_arch_init);
> > >
> > > Yes, this is the right thing to do, but use machine_arch_initcall()
> > > instead so that it doesn't get called if it is not your board.
> > 
> > That being said, I believe there is infrastructure to handle the
> > creation of your i2c board info from the device tree.  Your i2c board
> > info should not be hard coded.
> 
> Jon Smirl's patches? Not yet, unfortunately. It didn't make .25, but
> maybe for .26.
> 
> (I will need to do it specifically on my platform, like fsl_soc already
> does, as a stopgap until then).

That, and Sean is still working on getting the iic device-tree-compliant driver through as
well :)

josh
