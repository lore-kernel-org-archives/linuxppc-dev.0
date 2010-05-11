Return-Path: <muvarov@gmail.com>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by ozlabs.org (Postfix) with ESMTP id 6D949B7DCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 03:48:27 +1000 (EST)
Received: by mail-ww0-f51.google.com with SMTP id 24so70019wwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 10:48:26 -0700 (PDT)
From: Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH 2/2] powerpc new toolchains fix (crt.S)
To: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
	uvarov@dev.rtsoft.ru
Date: Tue, 11 May 2010 21:47:57 +0400
Message-ID: <20100511174757.19309.30827.stgit@muvarov>
In-Reply-To: <20100511174749.19309.44615.stgit@muvarov>
References: <20100511174749.19309.44615.stgit@muvarov>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: lists@nerdbynature.de, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch is required in case if you are using new toolchains.

Best regards,
Maxim Uvarov.

From: Maxim Uvarov <muvarov@gmail.com>

Linker does not provide some vital functions when building freestanding
applications with a new toolchain, so we have to provide our own CRT.

p.s.
Without the CRT we won't see any build errors (since the purgatory is
linked with --no-undefined), but the purgatory code won't work,
'kexec -e' will just hang the board.


I added option to configure to keep code buildable for old toolchais.
But there should be way to do this automatically.

Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 configure.ac                |    9 +++++++++
 purgatory/arch/ppc/Makefile |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index fcf50e4..63606bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -159,6 +159,15 @@ if test "$with_xen" = yes ; then
 		AC_MSG_NOTICE([Xen support disabled])))
 fi
 
+dnl new toolchains
+if test "$ARCH" = ppc; then
+AC_ARG_WITH([oldtoolchain],
+		AC_HELP_STRING([--with-oldtoolchain],[compile without crt.S
+			required for new toolchains]),
+		AC_DEFINE(PPC_OLDTOOLCHAIN, 1,
+			[Define to compile with old toolchains]))
+fi
+
 dnl ---Sanity checks
 if test "$CC"      = "no"; then AC_MSG_ERROR([cc not found]); fi
 if test "$CPP"     = "no"; then AC_MSG_ERROR([cpp not found]); fi
diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
index 72289a0..d11ec3e 100644
--- a/purgatory/arch/ppc/Makefile
+++ b/purgatory/arch/ppc/Makefile
@@ -6,6 +6,9 @@ ppc_PURGATORY_SRCS += purgatory/arch/ppc/v2wrap_32.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/misc.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/purgatory-ppc.c
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/console-ppc.c
+ifndef PPC_OLDTOOLCHAIN
+	ppc_PURGATORY_SRCS += purgatory/arch/ppc/crt.S
+endif
 
 dist += purgatory/arch/ppc/Makefile $(ppc_PURGATORY_SRCS)		\
 	purgatory/arch/ppc/purgatory-ppc.h purgatory/arch/ppc/ppc_asm.h
