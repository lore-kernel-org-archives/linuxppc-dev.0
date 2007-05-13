Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACBD2DDEC7
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 11:46:15 +1000 (EST)
Subject: Re: [PATCH] powerpc: make ioport_map() handle already mapped ranges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705130155.42414.arnd@arndb.de>
References: <20070512143221.GB12890@lixom.net>
	<200705130018.42612.arnd@arndb.de> <20070512223623.GA16045@lixom.net>
	<200705130155.42414.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 13 May 2007 11:46:04 +1000
Message-Id: <1179020764.32247.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There is a global io space range for all buses, which is maintained
> by the reserve_phb_iospace() call. You should get your I/O ports in there
> if you want them to just work. Note that while the reserve_phb_iospace() 
> logic works in practice, it does have a few shortcomings that should
> eventually be resolved:

The solution is to use proper allocators for these.

As you pointed out on irc, it seems like the current __get_vm_area()
could match our needs. It might allow us to also get rid of imalloc.

I'll give that a go tomorrow.

Ben.
