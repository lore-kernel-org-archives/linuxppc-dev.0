Date: Tue, 8 Jun 2004 13:25:56 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix missing option in binutils version check
Message-ID: <20040608112556.GA21447@suse.de>
References: <20040605074341.GA15279@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040605074341.GA15279@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sat, Jun 05, Olaf Hering wrote:

> pomegranate:~# echo dssall | /usr/bin/as -o /tmp/x
> {standard input}: Assembler messages:
> {standard input}:1: Error: Unrecognized opcode: `dssall'
> pomegranate:~# /usr/bin/as -v
> GNU assembler version 2.15.91.0.1 (powerpc-suse-linux) using BFD version 2.15.91.0.1 20040527 (SuSE Linux)
>
>
> *** 2.6 kernels no longer buildcorrectly with old versions of binutils.
> *** Please upgrade your binutils to 2.12.1 or newer
> make: *** [checkbin] Error 1
> make: Target `all' not remade because of errors.

I talked to Alan, and -many is the correct fix.



diff -p -purN linux-2.6.7-rc3.orig/arch/ppc/Makefile linux-2.6.7-rc3/arch/ppc/Makefile
--- linux-2.6.7-rc3.orig/arch/ppc/Makefile	2004-06-08 09:10:00.000000000 +0200
+++ linux-2.6.7-rc3/arch/ppc/Makefile	2004-06-08 12:37:06.000000000 +0200
@@ -86,7 +86,7 @@ include/asm-$(ARCH)/offsets.h: arch/$(AR

 ifdef CONFIG_6xx
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later
-NEW_AS	:= $(shell echo dssall | $(AS) -o /dev/null >/dev/null 2>&1 ; echo $$?)
+NEW_AS	:= $(shell echo dssall | $(AS) -many -o /dev/null >/dev/null 2>&1 ; echo $$?)
 GOODVER	:= 2.12.1
 else
 NEW_AS	:= 0
@@ -94,7 +94,7 @@ endif

 ifneq ($(NEW_AS),0)
 checkbin:
-	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build'
+	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
 	@echo 'correctly with old versions of binutils.'
 	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
 	@false

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
