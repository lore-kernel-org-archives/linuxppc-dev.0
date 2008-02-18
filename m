Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9372EDDF29
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:39:42 +1100 (EST)
Date: Mon, 18 Feb 2008 12:42:40 -0600
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: arch_initcall time
Message-ID: <20080218184240.GA17898@lixom.net>
References: <47B9CE4D.1020303@pikatech.com>
	<fa686aa40802181031s4ba6ec4eie949040f0bf23ad6@mail.gmail.com>
	<fa686aa40802181032lffff9e2yf079c277c250b430@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40802181032lffff9e2yf079c277c250b430@mail.gmail.com>
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

On Mon, Feb 18, 2008 at 11:32:14AM -0700, Grant Likely wrote:
> On Feb 18, 2008 11:31 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Feb 18, 2008 11:28 AM, Sean MacLennan <smaclennan@pikatech.com> wrote:
> > > I need to call i2c_register_board_info for the new i2c style ad7414
> > > driver. This needs to be called at arch initcall time. Currently I just
> > > do this:
> > >
> > > static int __init warp_arch_init(void)
> > > {
> > >         i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
> > >         return 0;
> > > }
> > > arch_initcall(warp_arch_init);
> >
> > Yes, this is the right thing to do, but use machine_arch_initcall()
> > instead so that it doesn't get called if it is not your board.
> 
> That being said, I believe there is infrastructure to handle the
> creation of your i2c board info from the device tree.  Your i2c board
> info should not be hard coded.

Jon Smirl's patches? Not yet, unfortunately. It didn't make .25, but
maybe for .26.

(I will need to do it specifically on my platform, like fsl_soc already
does, as a stopgap until then).


-Olof
