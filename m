Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E77BDDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 06:26:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OJNnJO030828
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 15:23:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OKPvZE550906
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 16:25:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OKPuLC007101
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 16:25:57 -0400
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705242221.17790.arnd@arndb.de>
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
	<1180035543.3360.25.camel@zod.rchland.ibm.com>
	<200705242221.17790.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 24 May 2007 15:24:55 -0500
Message-Id: <1180038295.3360.29.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-24 at 22:21 +0200, Arnd Bergmann wrote:
> On Thursday 24 May 2007, Josh Boyer wrote:
> > 
> > > Nothing is telling GCC what CPU to compile for, so it
> > > will just use the compiler's default, which very likely
> > > is not what you want.  For files that will only ever
> > > be used on 440, the correct flags are -mcpu=440 -Wa,-m440 .
> > 
> > We could add that to the per-file flags already, right?
> 
> I think it should really use -mcpu=powerpc on all files.
> The problem that Dave saw was the result of using a compiler
> that defaults to -mcpu=8540, which uses instruction that
> don't work on 440.

You sure?  It griped about isel, and isel is implemented on all 440s
with the exception of 440GP.  Yay for consistency.

> The common files really need to be built with -mcpu flags that
> make the code work on any system if you want to be able
> to use just a single boot wrapper binary for all.

Yeah, it's finding those combinations that work for all the existing
toolchains out there that's the issue.  That, or making the wrapper not
compile all the platform files...  I don't know which makes more sense.

josh
