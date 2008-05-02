Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 927CCDDE1F
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 08:31:01 +1000 (EST)
Date: Fri, 02 May 2008 15:30:59 -0700 (PDT)
Message-Id: <20080502.153059.91956773.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions
	and -Os
From: David Miller <davem@davemloft.net>
In-Reply-To: <481B92A7.3070302@freescale.com>
References: <481B8B89.2030703@freescale.com>
	<20080502.150448.32652665.davem@davemloft.net>
	<481B92A7.3070302@freescale.com>
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
Date: Fri, 02 May 2008 17:16:07 -0500

> If GCC generates a call to a libgcc function that calls a libc function, 
> I'd consider that a pretty serious bug, given that said libc function is 
> likely to consist of GCC-generated code, which could call the same 
> libgcc function, which calls the libc function, etc.

Not really, there are several interfaces in libgcc that need some
runtime help from the C library or the dynamic linker.

For example, EH frame support.

You really don't know what you're talking about.

> I'd say problems are more likely if you use nonstandard implementations 
> of GCC internals...

The kernel is a special environment.  Therefore even if you start
linking with libgcc, it is inevitable that you will need some
changed local version for some of those routines in the kernel.
