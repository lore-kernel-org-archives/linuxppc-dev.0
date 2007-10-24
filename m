Return-Path: <oxymoron@waste.org>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D13C4DDF40
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 06:00:17 +1000 (EST)
Date: Wed, 24 Oct 2007 14:46:40 -0500
From: Matt Mackall <mpm@selenic.com>
To: linuxppc-embedded@ozlabs.org
Subject: Apparent kernel bug with GDB on ppc405
Message-ID: <20071024194640.GB19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gdb@sourceware.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to debug a trivial statically-linked hello world program on
a Xilinx PPC 405 and I'm seeing the following behavior:

With direct gdb on target, I can set a breakpoint at main, run, and
the breakpoint is triggered.

With gdbserver and gdb with "target remote localhost:1234", the above
still works.

With gdb on target redirected to a PC and tunneled back
to the target, everything still works.

With gdb on a PC, execution continues past the breakpoint. Comparing
the gdb protocol streams here and and on the previous (working) case
are identical up to the point of hitting the breakpoint (which never
happens in the latter case).

Raising the load on the PC to 4 and running gdb under nice -n 19 makes
things work again. So this begins to look like a kernel cache or
timing bug rather than a problem with the PC tool. It appears that the
breakpoint written to the executable at continue time is not visible
to the CPU at execute time.

My first suspicion was a dcache/icache coherency issue in
copy_to_user_page, so I added flush_dcache_icache_page(page) here to
no avail. On closer inspection, it looks like both icache and dcache
are already being flushed by flush_icache_user_range().

Adding printk(".") (or any printk) in this function here fixes things
(serial console at 115k), while printk("") and udelay(100) do not.
Which still suggests an icache bug..?

Any suggestions?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
