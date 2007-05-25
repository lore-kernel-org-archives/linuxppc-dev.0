Return-Path: <dgibson@ozlabs.org>
Date: Fri, 25 May 2007 13:19:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix compiler/assembler flags for Ebony platform boot files
Message-ID: <20070525031917.GC13575@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The recent addition of assembler flags for 44x.c and ebony.c in the
bootwrapper to make them compile on certain toolchains was not correct
and could break other platforms.  This patch switches to using a
compiler flag instead, which implies the appropriate assembler flag,
and also stops the compiler itself generating instructions which are
invalid for the platform in question.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-25 12:57:26.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-25 12:57:48.000000000 +1000
@@ -33,8 +33,8 @@ endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
-$(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
-$(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke
+$(obj)/44x.o: BOOTCFLAGS += -mcpu=440
+$(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
