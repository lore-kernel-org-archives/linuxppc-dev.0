Date: Sat, 5 Jun 2004 09:43:41 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix typo in binutils version check
Message-ID: <20040605074341.GA15279@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The binutils check is bogus, it doesnt work with the just released
binutils. A space is needed in the error message.

pomegranate:~# echo dssall | /usr/bin/as -o /tmp/x
{standard input}: Assembler messages:
{standard input}:1: Error: Unrecognized opcode: `dssall'
pomegranate:~# /usr/bin/as -v
GNU assembler version 2.15.91.0.1 (powerpc-suse-linux) using BFD version 2.15.91.0.1 20040527 (SuSE Linux)


*** 2.6 kernels no longer buildcorrectly with old versions of binutils.
*** Please upgrade your binutils to 2.12.1 or newer
make: *** [checkbin] Error 1
make: Target `all' not remade because of errors.


--- linux-2.6.7-rc2-bk5.orig/arch/ppc/Makefile	2004-06-05 09:31:28.000000000 +0200
+++ linux-2.6.7-rc2-bk5/arch/ppc/Makefile	2004-06-05 09:38:02.000000000 +0200
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
