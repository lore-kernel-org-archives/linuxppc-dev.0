Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26F56DDF30
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 16:54:18 +1000 (EST)
Subject: Re: AZFS file system proposal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807081642.19507.arnd@arndb.de>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
	<20080707173923.17dc6c05@mercedes-benz.boeblingen.de.ibm.com>
	<200807081642.19507.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 16:48:06 +1000
Message-Id: <1215586086.8970.348.camel@pasglop>
Mime-Version: 1.0
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Maxim Shchetynin <maxim@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, linux-fsdevel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Cc:'ing some more people that might have more of a clue on this question.
> _memcpy_fromio does a "sync" at the start and an "eieio" at the end.
> IFAICT, neither are needed here because the source is always memory.
> 
> It also handles unaligned memory accesses, which copy_to_user should
> also do correctly, so it *looks* like it should work with just a
> copy_to_user, but it still feels wrong to use an __iomem pointer
> as the source for a copy_to_user.
> 
> Any ideas?

It's a bit nasty yes. The problem is that copy_to/from_user might
do cache tricks which will blow up if the area is non-cacheable.

We have a similar problem with Mark's work on faster copy functions
since things like sys_read() can be called on userspace non-cacheable
memory such as spu local stores.

So I'm not 100% sure what the right approach here. Our copy_tofrom_user
today does dcbt on the source for example, which I hope only turns into
a no-op... The risk is if we start using dcbz.

Cheers,
Ben.
