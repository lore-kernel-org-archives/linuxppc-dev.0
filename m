Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13155679E9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 15:19:40 +1000 (EST)
Subject: Re: 2.6.16 backtrace at boot (Ibook G4) (related to "PowerBook5,4
	-- no sound?")
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87r73u19b1.fsf@briny.internal.ondioline.org>
References: <Pine.LNX.4.44.0604181714400.12545-100000@zirkon.biophys.uni-duesseldorf.de>
	<1145397523.4705.94.camel@localhost.localdomain>
	<87r73u19b1.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 15:19:22 +1000
Message-Id: <1145423962.9924.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "\[ATR\]Dj-Death" <djdeath@gmx.fr>, linuxppc-dev@ozlabs.org,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>   arch/powerpc/platforms/powermac/setup.c:721: error: 'mach_powermac' undeclared here (not in a function)
>   arch/powerpc/platforms/powermac/setup.c:721: warning: type defaults to 'int' in declaration of 'mach_powermac'
>   make[2]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
>   make[1]: *** [arch/powerpc/platforms/powermac] Error 2
>   make: *** [arch/powerpc/platforms] Error 2
> 
> It looks like the EXPORT_SYMBOL() needs to be after the definition.
> 
> However, I tried adding "EXPORT_SYMBOL(mach_powermac);" after the
> define_machine(powermac) and now sound works for me with my original
> I2C_POWERMAC=y SND_POWERMAC=m configuration.

Yup, Paul has a working patch already, will be in 2.6.17 soonish. 

Cheers,
Ben.
