Return-Path: <paulus@ozlabs.org>
Date: Thu, 3 Jun 2010 22:20:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Anyone using "PowerPC" little-endian mode?
Message-ID: <20100603122012.GA22799@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel supports processes running in little-endian mode
on machines that have a little-endian mode (as opposed to an endian
bit in the TLB entry like most embedded PowerPC processors do, which
is a much better idea).  Little-endian mode comes in two flavours:
so-called "PowerPC" little-endian mode, which works by swizzling the
bottom 3 bits of the address, and "true" little-endian mode, which
actually swaps the order of the bytes read from or written to memory.
The classic 32-bit processors (603, 604, 750, 74xx, and derivatives)
implemented PowerPC little-endian mode, and I think some early 64-bit
processors did also.  POWER6 and POWER7 implement true little-endian
mode.  POWER4, PPC970 and POWER5 don't implement any little-endian
mode.

Is anyone actually using little-endian mode processes on processors
that implement PowerPC little-endian mode?  One of the ways that we
could make the alignment interrupt handler go faster is by removing
the code for address swizzling that we have in order to handle PowerPC
little-endian mode.  If nobody is actually using it, we should
remove it and make the code simpler and faster.

Paul.
