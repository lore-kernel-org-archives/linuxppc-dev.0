Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jan Dittmer <jdi@l4x.org>
Subject: Re: Define termios_1 functions for powerpc, s390, avr32 and frv 
In-reply-to: <46E8DF49.7090402@l4x.org> 
References: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
	<46E8DF49.7090402@l4x.org>
Date: Thu, 13 Sep 2007 17:22:36 +1000
Message-ID: <5058.1189668156@neuling.org>
Cc: hskinnemoen@atmel.com, heiko.carstens@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Alan Cox <alan@redhat.com>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Commit f629307c857c030d5a3dd777fee37c8bb395e171 introduced uses of
> > kernel_termios_to_user_termios_1 and user_termios_to_kernel_termios_1
> > on all architectures.  However, powerpc, s390, avr32 and frv don't
> > currently define those functions since their termios struct didn't
> > need to be changed when the arbitrary baud rate stuff was added, and
> > thus the kernel won't currently build on those architectures.
> 
> alpha, parisc, sh, sparc{64,}, xtensa are still broken with this error...

They need to include <asm-generic/termios.h> in asm-<arch>/termios.h
like in powerpc.

Alternatively tonyb's patch should fix them.  Could also do that?

Mikey
