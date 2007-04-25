Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 91893DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 14:24:21 +1000 (EST)
Date: Tue, 24 Apr 2007 21:24:28 -0700 (PDT)
Message-Id: <20070424.212428.35800490.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: David Miller <davem@davemloft.net>
In-Reply-To: <1177459235.14873.155.camel@localhost.localdomain>
References: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223930.1dab0e28.sfr@canb.auug.org.au>
	<1177459235.14873.155.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Apr 2007 10:00:35 +1000

> On Tue, 2007-04-24 at 22:39 +1000, Stephen Rothwell wrote:
> > The only change here is that a readlock is taken while the property list
> > is being traversed on Sparc where it was not taken previously.
> > 
> > Also, Sparc uses strcasecmp to compare property names while PowerPC
> > uses strcmp.
> 
> Ok, so that's the opposite as the previous one... property names are
> supposed to be case sensitive though, no ? Dave, how do you think we
> should converge here ? I don't think we would take much risk on ppc by
> using strncasecmp but it shouldn't be necessary...

The difference is that some properties are all-caps on powerpc
when they are lowecase on sparc, the Radeon properties are a
good example.

I think if we use strncasecmp across the board, nothing will
break.
