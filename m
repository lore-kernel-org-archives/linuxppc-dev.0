Return-Path: <uweigand@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACD20DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 05:54:24 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA9IsKl2185016
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 18:54:20 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.6) with
	ESMTP id lA9IsKuw2314488
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 19:54:20 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA9IsKU0027044
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 19:54:20 +0100
Message-Id: <200711091854.lA9IsJEB027041@d12av02.megacenter.de.ibm.com>
Subject: Hardware watchpoints on Cell/B.E. broken
To: linuxppc-dev@ozlabs.org
Date: Fri, 9 Nov 2007 19:54:19 +0100 (CET)
From: "Ulrich Weigand" <uweigand@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I've noticed that GDB hardware watchpoints do not work at all on Cell/B.E.
(when running without hypervisor); the kernel accepts the PTRACE_SET_DEBUGREG
call without error, but watchpoints never trigger.

This turns out to be caused by a new hardware feature in the PowerPC 2.02
architecture level: the DABRX register.  This register controls in which
modes of operation (problem state, privileged state, hypervisor state)
the DABR register takes effect.  (See Book III v 2.02 page 40.)

The default setting of that register on Cell/B.E. (at least on IBM blades),
which the Linux kernel currently never modifies, is to ignore DABR in all
modes -- thus watchpoints do not work at all.

The following hack sets the bit in the DABRX that enables the DABR for
problem state, whenever the DABR is set.  With this patch on top of the
current Fedora 8 update kernel (kernel-2.6.23.1-48.fc8) watchpoints work
again -- all relevant test cases in the GDB test suite now pass.

Obviously, the patch cannot be applied as-is; we need to make sure we are
on a machine that supports the DABRX feature.  Arnd asked me to post this
anyway as a heads-up on that problem ...

Bye,
Ulrich


--- linux-2.6.23.ppc64/arch/powerpc/kernel/process.c.orig
+++ linux-2.6.23.ppc64/arch/powerpc/kernel/process.c
@@ -229,6 +229,7 @@
 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
 #if defined(CONFIG_PPC64) || defined(CONFIG_6xx)
 	mtspr(SPRN_DABR, dabr);
+	mtspr(1015, 1);  /* enable DABR for user space */
 #endif
 	return 0;
 }
-- 
  Dr. Ulrich Weigand
  GNU Toolchain for Linux on System z and Cell BE
  Ulrich.Weigand@de.ibm.com
