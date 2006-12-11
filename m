Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B84E767BE1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 17:48:46 +1100 (EST)
Subject: Re: Is in_le32 and out_le32 atomic?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612082115.38812.arnd@arndb.de>
References: <4579C586.5040809@grandegger.com>
	<200612082115.38812.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 17:48:38 +1100
Message-Id: <1165819718.7260.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2006-12-08 at 21:15 +0100, Arnd Bergmann wrote:
> On Friday 08 December 2006 21:05, Wolfgang Grandegger wrote:
> > Can anybody tell me why the spin_* protection is needed? I thought that 
> > 32-bit read and write operations are atomic.
> > 
> The spinlocks are needed to guarantee ordering between the completion of
> the i/o access and other code. A typical problem is that a store is
> still on its way to the I/O device while the CPU has already left the
> function that initiated it, and might call code that relies on the
> value having arrived there.

That will not help much with the spinlock, especially not seeing how
they are used in the code.

I think the lock is totally spurrious in that case.

Ben.
