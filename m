Message-ID: <40C88A1B.4020102@g-house.de>
Date: Thu, 10 Jun 2004 18:19:39 +0200
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix missing option in binutils version check
Content-Type: multipart/mixed;
 boundary="------------020605080409010006080000"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020605080409010006080000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On Sat, Jun 05, Olaf Hering wrote:
 >> pomegranate:~# echo dssall | /usr/bin/as -o /tmp/x
 >> {standard input}: Assembler messages:
 >> {standard input}:1: Error: Unrecognized opcode: `dssall'
 >> pomegranate:~# /usr/bin/as -v
 >> GNU assembler version 2.15.91.0.1 (powerpc-suse-linux) using BFD
 >> version 2.15.91.0.1 20040527 (SuSE Linux)
 >>
 >>
 >> *** 2.6 kernels no longer buildcorrectly with old versions of binutils.
 >> *** Please upgrade your binutils to 2.12.1 or newer
 >> make: *** [checkbin] Error 1
 >> make: Target `all' not remade because of errors.
 >
 > I talked to Alan, and -many is the correct fix.
 >

seeing your new patch now which indeed exports "as" with this needed
option i seem to understand now. somehow i was unable to apply your
patch, so i patched by hand / made a new patch:

evil@sheep:/usr/src/linux-2.6$ cat ../as-dssall.diff | patch -p1 -s \
--dry-run
patch: **** malformed patch at line 6: ifdef CONFIG_6xx

Thank you,
Christian.
--
BOFH excuse #377:

Someone hooked the twisted pair wires into the answering machine.

--------------020605080409010006080000
Content-Type: text/x-diff;
 name="as-dssall.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-dssall.diff"

--- linux-2.6/arch/ppc/Makefile.orig	2004-06-10 18:07:35.000000000 +0200
+++ linux-2.6/arch/ppc/Makefile	2004-06-10 18:10:24.000000000 +0200
@@ -86,7 +86,7 @@

 ifdef CONFIG_6xx
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later
-NEW_AS	:= $(shell echo dssall | $(AS) -o /dev/null >/dev/null 2>&1 ; echo $$?)
+NEW_AS := $(shell echo dssall | $(AS) -many -o /dev/null >/dev/null 2>&1 ; echo $$?)
 GOODVER	:= 2.12.1
 else
 NEW_AS	:= 0
@@ -94,7 +94,7 @@

 ifneq ($(NEW_AS),0)
 checkbin:
-	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build'
+	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
 	@echo 'correctly with old versions of binutils.'
 	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
 	@false

--------------020605080409010006080000--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
