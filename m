Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E6593DDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 22:10:03 +1100 (EST)
Date: Tue, 06 Nov 2007 03:10:01 -0800 (PST)
Message-Id: <20071106.031001.189578769.davem@davemloft.net>
To: johannes@sipsolutions.net
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
From: David Miller <davem@davemloft.net>
In-Reply-To: <1194346486.4066.13.camel@johannes.berg>
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kamalesh@linux.vnet.ibm.com, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 06 Nov 2007 11:54:46 +0100

> 
> 
> > >   CHK     include/linux/compile.h
> > >   AS      arch/powerpc/kernel/swsusp_32.o
> > > arch/powerpc/kernel/swsusp_32.S: Assembler messages:
> > > arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
> > > make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
> > > make: *** [arch/powerpc/kernel] Error 2
> > >
> > 
> > Looks suspiciously like an altivec issue. Could you compile with make
> > V=1 and/or do a git bisect and see what broke?
> 
> Looks more like a toolchain issue to me.

Or, this is another instance of the "CFLAGS environment variable"
problem.

For a few days, the kbuild stuff would integrate any CFLAGS,
AFLAGS, etc. settings you might have set in your environment.
