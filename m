Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F16ACDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 03:11:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2QGBtHM023390
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 09:11:56 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2QGBsc2018554
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 11:11:55 -0500 (CDT)
Date: Thu, 26 Mar 2009 11:11:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Goldberger, Yigal" <YGoldberger@nds.com>
Subject: Re: ELDK with Xenomai for PPC
Message-ID: <20090326161154.GA26521@ld0162-tx32.am.freescale.net>
References: <7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25@ILMA1.IL.NDS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7913DB5FA7D3F643A2C10A4A8E2DFAF43A3A5D7C25@ILMA1.IL.NDS.COM>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 25, 2009 at 07:06:50PM +0200, Goldberger, Yigal wrote:
> I'll try to be as accurate as I can.
> Yesterday I downloaded ELDK 4.2 from DENX site and Installed it.
> I want to build a Xenomai enabled kernel.
> I saw that my kernel is 2.6.24-xenomai and that's what I'm trying to build.
[snip]
> Currently I did :
> > make ads8272_defconfig
> > make uImage
> 
> and I'm failing on :
>   CC      drivers/net/fs_enet/mac-fcc.o
> drivers/net/fs_enet/mac-fcc.c: In function 'fcc_cr_cmd':
> drivers/net/fs_enet/mac-fcc.c:85: error: implicit declaration of function 'cpm_command'
> make[3]: *** [drivers/net/fs_enet/mac-fcc.o] Error 1
> make[2]: *** [drivers/net/fs_enet] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2

Please try a more recent kernel; there was a lot of cleanup of 82xx
support going on in the 2.6.24 timeframe.  Also, in general you should
try building a vanilla kernel of the same version/platform, to see if it
is a problem introduced by xenomai.  Note that in vanilla 2.6.24 I do not
see any reference to cpm_command -- it looks like you have the 2.6.25
version of mac-fcc.c.

Is this arch/powerpc or arch/ppc?  If the latter, it's no longer
supported, is gone in current kernels, and was highly deprecated back
when 2.6.24 came out.  It seems that the last two releases with arch/ppc
(2.6.25 and 2.6.26) had this problem.

-Scott
