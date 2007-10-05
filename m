Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EAB9DDE43
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 03:30:57 +1000 (EST)
Date: Fri, 5 Oct 2007 12:30:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size
	support to bootwarapper
Message-ID: <20071005173054.GA4295@loki.buserror.net>
References: <20070924113627.GA30504@ru.mvista.com>
	<20070925022935.GI30338@localhost.localdomain>
	<46FD0E4D.30305@ru.mvista.com>
	<20071003055005.GD18978@localhost.localdomain>
	<20071005015849.GA9862@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071005015849.GA9862@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 04, 2007 at 06:58:49PM -0700, Mark A. Greer wrote:
> Having the link address jump around depending on the size of the kernel
> or zImage is wrong IMHO.  It just screams "weird can't boot issues."
> We need a way to specify exactly where we want the zImage linked no
> matter what the kernel or zImage size.

Why?  The zImage is relocatable.  It doesn't matter where it's linked.

> Also, being able to control the link address (that is, the download
> address with some firmwares) is not a u-boot specific issue and we
> shouldn't make a u-boot specific solution.

How is this a u-boot specific solution?

> The more general problem is that some firmwares examine the ELF header
> and download the zImage to address it was linked at.  Some firmwares let
> you override this but some don't and those are the problem ones.

That's not the more general problem; it's the same problem with a different
file format.

> I still like my idea best.  I haven't coded yet it so I don't have a patch
> but this is what I mean:
> 
> 1) add a config option (default 4MB) for the link address
> 2) add a parameter to the wrapper script thru which we pass the value in
>    the config option
> 3) the wrapper script changes the VMA/LMA to the address specified
>    (objcopy --change-addresses=<some math to get correct incr> ?).

I'd much rather it be automatic than require the user to guess an
appropriate value (and be aware in the first place that it needs to be set).

-Scott
