Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDA0367B5C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:47:49 +1000 (EST)
In-Reply-To: <45104304.3000205@genesi-usa.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
	<45103DF0.9050409@genesi-usa.com>
	<9E674786-9AF3-4322-B642-7BAA58462B74@kernel.crashing.org>
	<45104304.3000205@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93D19BAC-3F4A-43C4-8624-DDE747A12466@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] convert string i/o operations to C
Date: Tue, 19 Sep 2006 21:47:30 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But it couldn't hurt, right? There has to be an application note  
> per-CPU on the correct sequence of operations for such an access (I  
> seem to have collected a directory full for firmware development),

The architecture describes the rules already, not many CPUs
have "faster"/"better" sequences.

> it seems a little odd to pick and choose one instruction over  
> another for one thing, and then say you need to do it to support  
> the 601 of all things, and run this code against the G3/G4/G5 which  
> perhaps doesn't care or is more intelligent about it (or is  
> guaranteed to have a more intelligent host bridge at least).

The comment you're referring to is old; it doesn't talk about
synchronisation requirements, but focuses on having the CPU
trap on exactly these instructions when an access causes a
(asynchronous) machine check.  Asynchronous exceptions don't
necessarily return the instruction pointer where the real
failure was, so it's no surprise different CPUs have a different
idea about it.  It's pretty safe to assume (but not guaranteed)
that it will always be somewhere between the load and the insn
after the isync, inclusive, though.


Segher
