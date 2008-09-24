Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2062CDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 17:09:16 +1000 (EST)
Subject: Re: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200809240845.52262.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<200809240823.12484.arnd@arndb.de> <1222237739.8277.62.camel@pasglop>
	<200809240845.52262.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 17:08:50 +1000
Message-Id: <1222240130.8277.67.camel@pasglop>
Mime-Version: 1.0
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-24 at 08:45 +0200, Arnd Bergmann wrote:
> On Wednesday 24 September 2008, Benjamin Herrenschmidt wrote:
> > Why do we want it ?
> > 
> > It's an int, it's zero extended, but that should still be a valid signed
> > 32 bits int in compat_sys_select() or do I miss something ?
> 
> IIRC, the calling conventions on 64 bit ppc assume that a signed int
> argument is sign-extended into a 64 bit register. The compat syscall
> entry point does not know which registers are signed or unsigned, so
> it will always to zero-extend, making the register contain an undefined
> bit pattern (e.g. 0x00000000fffffffe), which may be interpreted as being
> a positive number. An explicit cast as it is done in ppc32_select turns
> this into a well-defined 32-bit number stored in a 64-bit register (e.g.
> 0xfffffffffffffffe).

If that is true, then _any_ syscall that takes an int value must have
a ppc specific sign-extending compat wrapper, are you sure that is
the case ?

Ben.
