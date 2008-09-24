Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id CD314DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 16:46:05 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: Regarding select() on PPC
Date: Wed, 24 Sep 2008 08:45:51 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<200809240823.12484.arnd@arndb.de>
	<1222237739.8277.62.camel@pasglop>
In-Reply-To: <1222237739.8277.62.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809240845.52262.arnd@arndb.de>
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Benjamin Herrenschmidt wrote:
> Why do we want it ?
> 
> It's an int, it's zero extended, but that should still be a valid signed
> 32 bits int in compat_sys_select() or do I miss something ?

IIRC, the calling conventions on 64 bit ppc assume that a signed int
argument is sign-extended into a 64 bit register. The compat syscall
entry point does not know which registers are signed or unsigned, so
it will always to zero-extend, making the register contain an undefined
bit pattern (e.g. 0x00000000fffffffe), which may be interpreted as being
a positive number. An explicit cast as it is done in ppc32_select turns
this into a well-defined 32-bit number stored in a 64-bit register (e.g.
0xfffffffffffffffe).

	Arnd <><
