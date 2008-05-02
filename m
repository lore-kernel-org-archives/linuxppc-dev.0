Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 35B21DE076
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 07:42:21 +1000 (EST)
Date: Fri, 02 May 2008 14:42:20 -0700 (PDT)
Message-Id: <20080502.144220.53637856.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions
	and -Os
From: David Miller <davem@davemloft.net>
In-Reply-To: <BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
References: <F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
	<03e9cbca081bff8f6db9862bf3d8d028@kernel.crashing.org>
	<BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 2 May 2008 16:34:13 -0500

> We'll hopefully this thread might spark either an explanation for why  
> we aren't just linking libgcc in a statement that says we should and  
> we can remove the code that implements libgcc functionality.
> 
> How would libgcc linking intermix with modules?  Would we have to  
> EXPORT_SYMBOL() all functions that libgcc implements?  I'm guessing  
> that's varies w/different gcc versions.

If you link in libgcc, all of a sudden you have a whole new class of
potential problems, don't do it.

All it takes is one of these libgcc libcalls the kernel actually
references, needing something else in libc, to make this exercise
futile.
