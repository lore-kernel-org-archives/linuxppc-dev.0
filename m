Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0D187DDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 14:25:50 +1000 (EST)
Date: Wed, 11 Apr 2007 21:25:48 -0700 (PDT)
Message-Id: <20070411.212548.95037188.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH,RFC] Split out common parts of prom.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
References: <20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 12 Apr 2007 14:19:05 +1000

> This applies on top of all the previous patches I sent (including a merge
> of the sparc64 and powerpc for-2.6.22 trees).  So if people can't get it
> to apply, at least I would like some comments on the direction. (I told
> Rusty about the circular inclusion below and he didn't throw up, so I
> figure it isn't too bad as a temporary measure.)
> 
> I have built allmodconfig (modified slightly) for Powerpc, Sparc64 and
> Sparc.  (All of which fail during the module post processing but for
> reasons not related to these patches as far as I can see.)

This is one approach, and I'm not against it.

Another way is to create a linux/openfw.h that does nothing
but include asm/prom.h as step 1.  Step 2 is to convert all
the include sites, and step 3 is to move the relevant
prom.h bits into openfw.h

To be honest, since you're the one doing all of the hard work I think
you should be allowed to make the choice on how to go about this :-)
