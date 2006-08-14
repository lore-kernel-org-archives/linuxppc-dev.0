Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id 893E1679A6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Aug 2006 19:13:16 +1000 (EST)
Date: Mon, 14 Aug 2006 11:10:14 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
Message-ID: <20060814111014.4506dc19@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <31155357445643c98694.1714636915.miltonm@bga.com>
References: <31155357445643c98694.1714636915.miltonm@bga.com>
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

And so it came to pass, that on Fri, 11 Aug 2006 23:37:25 -0500
Milton Miller <miltonm@bga.com> wrote as thus:

> On Mon Aug  7 2006 04:46:43 AM CDT, Benjamin Heyne wrote:
> > Peter Korsgaard <jacmet@sunsite.dk> wrote as thus:
> > > >>>>> "David" == David H Lynch <dhlii@dlasys.net> 
> > > David>     Have you tried 2.6.18.x to see if your stuff works with it
> > > David> ?
> > > 
> > > Yes, 2.6.18-rc3 + my zlib fix
> > > (http://thread.gmane.org/gmane.linux.kernel/428436) or -rc4 once it
> > > hits kernel.org works fine on my v2p-based board.
> > 
> > Well, unfortunately I am still getting the inflate error
> > as soon as the image grows >2MB (about). Have you tried with
> > images of this size? If the image is smaller, everything works
> > fine...
> 
> My first reaction when I saw this thread was that you didn't allocate 
> something in memory and overlapped something.  However, looking
> at your original post again, I think your kernel is growing larger than
> 4MB, which is the link address of the zImage.  This is based on the 
> kernel is decompressed to address 0 in
> ppc/boot/simple/misc-embedded.c, and a 50% compression factor 
> and 2MB compressed image.
> 
> You can look at the file size of vmlinux to see if this is close.
> 
> milton

Well - That's exactly the case. But looking into misc-embedded.c, I noticed
that the load address for gunzip is fixed to 0x400000...shouldn't this
be dependent on CONFIG_BOOT_LOAD_BOOL and CONFIG_BOOT_LOAD?

I've changed the line to


#ifdef CONFIG_BOOT_LOAD_BOOL
	gunzip(0, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);
#else	
	gunzip(0, 0x400000, zimage_start, &zimage_size);
#endif


and now it seems to work fine for big images (if CONFIG_BOOT_LOAD 
is set large enough of course...) - which wasn't the case before.


Best regards
-- 
Benjamin Heyne
