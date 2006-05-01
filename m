Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 01 May 2006 10:53:41 +1000
Subject: [RFC/PATCH 0/4] powerpc: Use pr_debug() for debugging
Message-Id: <1146444821.660434.518701003988.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we have a macro called DBG() defined in most files in arch/powerpc,
which is used to do debugging printks.

In some files DBG evaluates to printk() and in others it becomes udbg_printf(),
but there doesn't seem to be any logic to explain why it's one or the other.
In fact in some files it'd be nice if it was both, so you could have early
debugging (udbg_printf), but then have things hit the dmesg buffer later (via
printk).

Using udbg_printf() in general is suboptimal IMHO because it bypasses the
printk buffer, so if you miss the messages on the screen you can't go back and
see them in dmesg.

So this series of patches rejiggers things so that we register the udbg
console really early, and therefore can always use printk. It then goes on to
change all the home spun DBG() macros into pr_debug() calls, from
include/linux/kernel.h

I haven't tested this extensively because I wanted to gauge people's reaction
first. It "works" on pSeries LPAR, and iSeries, but I haven't tested on 32-bit,
and I don't know that code well so I'm all ears on that.

cheers
