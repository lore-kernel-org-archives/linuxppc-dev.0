Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0DEF3DDF6C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 04:28:13 +1000 (EST)
Date: Tue, 03 Apr 2007 11:28:13 -0700 (PDT)
Message-Id: <20070403.112813.35016105.davem@davemloft.net>
To: segher@kernel.crashing.org
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
From: David Miller <davem@davemloft.net>
In-Reply-To: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
References: <20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
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

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 3 Apr 2007 17:39:52 +0200

> Why?  It should logically be an u8 * (and nothing
> should ever cast it to anything else, accessor
> functions should be used instead to get 32-bit ints
> from it, etc.)

Ummm, no.

There are structures there, and other types of objects.

Look at how some of the sparc64 code does this, it's not a "u8 *" by
even the largest stretch of the imagination.
