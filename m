Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17653.25129.512456.33157@cargo.ozlabs.ibm.com>
Date: Wed, 30 Aug 2006 20:02:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Fwd: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
In-Reply-To: <20060830092827.GB19689@flint.arm.linux.org.uk>
References: <20060830092827.GB19689@flint.arm.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Russell King writes:

> Maybe this should've gone to linuxppc-dev?  Can PPC folk please look
> at the PPC bits of this patch, and also decide whether the following
> can also have asm/serial.h removed:
> 
> arch/ppc/4xx_io/serial_sicc.c
> arch/ppc/boot/simple/mpc52xx_tty.c
> arch/ppc/boot/simple/mv64x60_tty.c

The situation is that arch/ppc is the old world.  Platforms are being
moved over to arch/powerpc as fast as we can manage, where things will
be much cleaner because the information about type and location of
serial ports (among other things) will be supplied via a device tree
rather than hardcoded in header files.  This means, though, that there
isn't much motivation for cleaning up stuff in arch/ppc.

The two users in arch/ppc/boot aren't really part of the kernel
proper.  The compressed image bootwrapper uses definitions from
serial.h on some platforms to access a serial port for interaction
with the user.  It may be possible to replicate the string of #ifdefs
and #includes from serial.h in those files.  Tom Rini can best advise
about that.

The serial_sicc.c code looks like it should be converted to use the
serial_core stuff.  I hope that will get done in the process of moving
4xx over to arch/powerpc.

Paul.
