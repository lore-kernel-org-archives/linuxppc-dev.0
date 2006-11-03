Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6927367CC7
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 09:56:37 +1100 (EST)
Subject: Re: [PATCH/RFC] Hookable IO operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611032348.38402.arnd@arndb.de>
References: <1162588367.10630.100.camel@localhost.localdomain>
	<200611032320.34762.arnd@arndb.de>
	<1162593121.10630.132.camel@localhost.localdomain>
	<200611032348.38402.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 09:56:29 +1100
Message-Id: <1162594589.10630.135.camel@localhost.localdomain>
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

]
> Actually I meant all of the I/O pointers, not just these three. When
> you were describing your idea to me, I was thinking of something like
> 
> struct ppc_io {
> 	void (*writeb)(u8 val);
> 	void (*writew)(u16 val);
> 	void (*writel)(u32 val);
> 	void (*writeq)(u64 val);
> 	...
> 	void (*memset_io)(volatile void __iomem *addr, int c,
> 				 unsigned long n);
> 	void (*__memcpy_fromio)(void *dest,
> 			const volatile void __iomem *src, unsigned long n);
> 	void (*__memcpy_toio)(volatile void __iomem *dest,
> 			const void *src, unsigned long n);
> } *ppc_io;
> 
> Did you never consider this, or did you make your mind up in the
> process?

I considered this and decided against it while doing the macro since I
could get the hooks auto-generated easier as globals, but I can still
change it, it's not that much bloat and might indeed look nicer.

> Is your current code more efficient?

I don't think there is a difference is ppc_io is a global struct rather
than a pointer, like ppc_md.

Ben.
