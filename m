Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7EF34DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 08:47:05 +1000 (EST)
Date: Fri, 02 May 2008 15:39:21 -0700 (PDT)
Message-Id: <20080502.153921.23372774.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions
	and -Os
From: David Miller <davem@davemloft.net>
In-Reply-To: <481B97DD.5070103@freescale.com>
References: <481B92A7.3070302@freescale.com>
	<20080502.153059.91956773.davem@davemloft.net>
	<481B97DD.5070103@freescale.com>
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
Date: Fri, 02 May 2008 17:38:21 -0500

> David Miller wrote:
> > The kernel is a special environment.  Therefore even if you start
> > linking with libgcc, it is inevitable that you will need some
> > changed local version for some of those routines in the kernel.
> 
> Such as?

When I added the software multiply and divide implemenations
to the 32-bit sparc port, I ended up using a different software
trap for signalling divide by zero in the handler so that it
was easier to detect the "from kernel" kernel case.

We're not talking about big complicated routines, we're talking about
quite simple stubs whose interfaces really are not going to change.
