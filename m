Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 21:15:21 +1100
Message-Id: <1131704121.24637.223.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>, "tom_gall@mac.com" <tom_gall@mac.com>
Subject: [PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the vdso's to arch/powerpc, adds support for the 32
bits vdso to the 32 bits kernel, rename systemcfg (finally !), and adds
some new (still untested) routines to both vdso's: clock_gettime() with
support for CLOCK_REALTIME and CLOCK_MONOTONIC, clock_getres() (same
clocks) and get_tbfreq() for glibc to retreive the timebase frequency.

Tom,Steve: The implementation of get_tbfreq() I've done for 32 bits
returns a long long (r3, r4) not a long. This is such that if we ever
add support for >4Ghz timebases on ppc32, the userland interface won't
have to change.

I have tested gettimeofday() using some glibc patches in both ppc32 and
ppc64 kernels using 32 bits userland (I haven't had a chance to test a
64 bits userland yet, but the implementation didn't change and was
tested earlier). I haven't tested yet the new functions.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Due to the size of the patch, I haven't posted it to the lists, it's
available at http://gate.crashing.org/~benh/ppc64-vdso-update.diff

Ben.
