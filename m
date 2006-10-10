Return-Path: <agl@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6EBB67B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 01:39:46 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AFdclu010629
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 11:39:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AFdcGC133282
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 11:39:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AFdbX8029354
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 11:39:37 -0400
Subject: zImage wrapper broken when cross compiling on Intel
From: Adam Litke <agl@us.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 10 Oct 2006 10:39:30 -0500
Message-Id: <1160494770.9894.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Paul.  My cross compile environment has been broken by the zImage
wrapper stuff.  I set both CROSS_COMPILE and CROSS32_COMPILE and build
my pSeries kernels on an Intel box.  The current logic is setting
CROSSWRAP := -C $(CROSS32_COMPILE) but my cross32 tools don't understand
the 64bit binaries I built :)

I am not quite sure how to properly handle my case without breaking one
of the other cases you are probably accounting for with the current
logic.  For the time being I've hacked my Makefile with the following
patch (just to get things working again for me).

 Makefile |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
diff -upN reference/arch/powerpc/boot/Makefile current/arch/powerpc/boot/Makefile
--- reference/arch/powerpc/boot/Makefile
+++ current/arch/powerpc/boot/Makefile
@@ -104,13 +104,13 @@ wrapperbits	:= $(extra-y) $(addprefix $(
 #############
 # Bits for building various flavours of zImage
 
-ifneq ($(CROSS32_COMPILE),)
-CROSSWRAP := -C $(CROSS32_COMPILE)
-else
+#ifneq ($(CROSS32_COMPILE),)
+#CROSSWRAP := -C $(CROSS32_COMPILE)
+#else
 ifneq ($(CROSS_COMPILE),)
 CROSSWRAP := -C $(CROSS_COMPILE)
 endif
-endif
+#endif
 
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) vmlinux

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
