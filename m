Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C63C7DDF42
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 08:04:49 +1000 (EST)
Date: Fri, 02 May 2008 15:04:48 -0700 (PDT)
Message-Id: <20080502.150448.32652665.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions
	and -Os
From: David Miller <davem@davemloft.net>
In-Reply-To: <481B8B89.2030703@freescale.com>
References: <BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
	<20080502.144220.53637856.davem@davemloft.net>
	<481B8B89.2030703@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>
Date: Fri, 02 May 2008 16:45:45 -0500

> David Miller wrote:
> > If you link in libgcc, all of a sudden you have a whole new class of
> > potential problems, don't do it.
> > 
> > All it takes is one of these libgcc libcalls the kernel actually
> > references, needing something else in libc, to make this exercise
> > futile.
> 
> What in libgcc references libc, and why isn't this a problem for 
> Linux/ARM, Linux/SH, U-boot, and the many other libc-less programs that 
> use libgcc?

The problem only occurs once you reference a function that references
libc stuff, and those guys are just lucky so far.

It's also one less variable to debug if you put the implementation
in the kernel, or do you like debugging compiler induced problems?
I don't :-)
