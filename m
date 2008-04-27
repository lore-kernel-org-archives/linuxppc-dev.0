Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE0B1DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Apr 2008 07:38:51 +1000 (EST)
Message-Id: <200804272036.m3RKaopf032054@rsass-homer.uncc.edu>
To: Brian Silverman <bsilverman@conceptxdesign.com>
Subject: Re: EABI 
In-reply-to: <4810B196.7000300@conceptxdesign.com> 
References: <4810B196.7000300@conceptxdesign.com>
Date: Sun, 27 Apr 2008 16:36:50 -0400
From: Ron Sass <rsass@uncc.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Unfortunately, it is not that easy.  The Xilinx tool chain use
newlib but your Linux kernel (and rootfs) is probably built
around glibc.  When we've wanted to do a quick-and-dirty test of
something that relies on Xilinx's patches to gcc, we have used
powerpc-eabi-gcc to compile to assembler and then used our own
crosstools compilers to link and load.

That doesn't solve your problem but hopefully it explains the
issue.

Ron

> Is it possible to compile a Linux application using an EABI compiler 
> (specfically, Xilinx's EDK powerpc-eabi-gcc.exe)?
>  
> The issue at hand is that we'd like for our customers to be able to use 
> the Xilinx EDK toolchain (which we know they will have) to compile Linx 
> apps without having to install another toolchain (crosstool, ELDK, etc).
>  
> So, what I'm hoping is that the EDK toolchain can be configured to be 
> Linux compatible binaries, or that there is some kind of wrapper that 
> will handle the incompatible interfaces.  Searching around, I've seen 
> some mention of Linux EABI compatibility (for Debian ARM releases), but 
> I haven't found any clear concensus...
> 
> P.S. My apologies if this message appears on the mailing list twice...
> 
> -- 
> Brian Silverman
> Concept X, LLC
