Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: powerpc: disable floating point exceptions for init
Date: Tue, 20 Jun 2006 02:30:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606200230.34348.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Floating point exceptions should not be enabled by default,
as this setting impacts the performance on some CPUs, in
particular the Cell BE. Since the bits are inherited from
parent processes, the place to change the default is the
thread struct used for init.

glibc sets this up correctly per thread in its fesetenv
function, so user space should not be impacted by this
setting. None of the other common libc implementations
(uClibc, dietlibc, newlib, klibc) has support for fp
exceptions, so they are unlikely to be hit by this either.

There is a small risk that somebody wrote their own
application that manually sets the fpscr bits instead
of calling fesetenv, without changing the MSR bits as well.
Those programs will break with this change.

It probably makes sense to change glibc in the future
to be more clever about FE bits, so that when running
on a CPU where this is expensive, it disables exceptions
ASAP, while it keeps them enabled on CPUs where running
with exceptions on is cheaper than changing the state
often.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/include/asm-powerpc/processor.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/processor.h
+++ linus-2.6/include/asm-powerpc/processor.h
@@ -190,7 +190,7 @@ struct thread_struct {
 	.fs = KERNEL_DS, \
 	.fpr = {0}, \
 	.fpscr = { .val = 0, }, \
-	.fpexc_mode = MSR_FE0|MSR_FE1, \
+	.fpexc_mode = 0, \
 }
 #endif
 
