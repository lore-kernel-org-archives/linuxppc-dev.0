Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id 0BD9B67BB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 00:42:40 +1000 (EST)
Date: Mon, 14 Aug 2006 16:42:07 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
Message-ID: <20060814164207.4eb13b03@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <d81b12fdf4409d827c83f98985a96822@bga.com>
References: <31155357445643c98694.1714636915.miltonm@bga.com>
	<20060814111014.4506dc19@bob.dt.e-technik.uni-dortmund.de>
	<d81b12fdf4409d827c83f98985a96822@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

And so it came to pass, that on Mon, 14 Aug 2006 09:00:33 -0500
Milton Miller <miltonm@bga.com> wrote as thus:

> >>
> >> I think your kernel is growing larger than
> >> 4MB, which is the link address of the zImage.
> >
> > Well - That's exactly the case. But looking into misc-embedded.c, I 
> > noticed
> > that the load address for gunzip is fixed to 0x400000...shouldn't this
> > be dependent on CONFIG_BOOT_LOAD_BOOL and CONFIG_BOOT_LOAD?
> >
> > I've changed the line to
> >
> > #ifdef CONFIG_BOOT_LOAD_BOOL
> > 	gunzip(0, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);
> > #else	
> > 	gunzip(0, 0x400000, zimage_start, &zimage_size);
> > #endif
> >
> > and now it seems to work fine for big images (if CONFIG_BOOT_LOAD
> > is set large enough of course...) - which wasn't the case before.
> 
> It shouldn't depend on CONFIG_BOOT_LOAD_BOOL.   CONFIG_BOOT_LOAD is
> set all the time (the question is dependent on _BOOL not the variable
> and the default is used).
> 
> milton
> 

OK - Thanks. So replacing

	gunzip(0, 0x400000, zimage_start, &zimage_size);
with
	gunzip(0, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);

should do the trick. Maybe we should report this to the file maintainer,
if you'd consider this to be a bug, too....

Best regards
-- 
Benjamin Heyne
