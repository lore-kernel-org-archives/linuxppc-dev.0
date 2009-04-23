Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51901DE133
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 00:03:02 +1000 (EST)
Message-ID: <49F07509.8030603@freescale.com>
Date: Thu, 23 Apr 2009 09:02:49 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
In-Reply-To: <20090423135005.GA18462@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> And note that most developers are using up-to-date firmwares
> (U-Boots), device trees, and kernels. 

Developers? Yes.
End-users? No.

Updating U-Boot itself is often unacceptable for end-users.  There's
also a strong connection between U-Boot and the device tree.  That
connection gets stronger with every release, as U-Boot makes more and
more changes to the device tree before passing it to the kernel.  This
means that if you cannot update U-Boot, you might not be able to update
your device tree either.

We've run into plenty of situations where customers will update the
kernel, but insist that U-Boot and the device tree remain unchanged.

> And that means that old
> device-tree + new kernel combination is left untested for years.
> And untested stuff is broken stuff, by definition.

I'm not saying that should officially support it.  I'm saying we should
make an effort to minimize the problem.  Adding a few isolated lines of
code to maintain that compatibility, and running a few tests, is not a
bad idea and can save headaches for some people in the future.

-- 
Timur Tabi
Linux kernel developer at Freescale
