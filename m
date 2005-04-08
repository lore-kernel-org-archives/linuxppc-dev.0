Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai02.cox.net (fed1rmmtai02.cox.net [68.230.241.57])
	by ozlabs.org (Postfix) with ESMTP id 0C96367B25
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 00:46:02 +1000 (EST)
Date: Fri, 8 Apr 2005 07:46:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20050408144600.GX3396@smtp.west.cox.net>
References: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cross-compiling under cygwin?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 10:13:09AM -0400, Robert P. J. Day wrote:

>   i've just had a request from a colleague who wants to do all the
> cross-compilation for our 8xx board on a windows box, rather than
> linux.
> 
>   there was talk of cygwin, and kdevelop as well.  i'm still parsing
> the rest of the email but is there a canonical URL that discusses
> working in the windows environment?
> 
>   i'm just about to head over to denx.de to see what i can find.
> thanks for any pointers.

The cross-tool list has had some of this.  As of 2.6.10 at least, the
following was still needed, and too ugly and/or cygwin version specific
to be submitted to the kernel proper (still applies cleanly to
2.6.12-rc2, but untested in Cygwin env):

Source: MontaVista Software, Inc.
MR: 8836
Type: Defect Fix
Disposition: local
Signed-off-by: Tom Rini <trini@mvista.com>
Description:
	A collection of unmergeable Cygwin fixes:
	- Cygwin doesn't have <inttypes.h> nor <stdint.h>, but doesn't
	  need them for certain values anyhow.
	- For certain ELF things, we rely on libelf being provided by
	  the MVL environment.
	- /usr/include/asm/byteorder.h provided ntohl/htonl.
	- <limits.h> defines PATH_MAX as an expression, which means
	it cannot be used in some places.

Index: linux-2.6.11.2/arch/ppc/boot/utils/mktree.c
===================================================================
--- linux-2.6.11.2.orig/arch/ppc/boot/utils/mktree.c
+++ linux-2.6.11.2/arch/ppc/boot/utils/mktree.c
@@ -15,9 +15,9 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <netinet/in.h>
-#ifdef __sun__
+#if defined(__sun__)
 #include <inttypes.h>
-#else
+#elif !defined(__CYGWIN__)
 #include <stdint.h>
 #endif
 
Index: linux-2.6.11.2/scripts/mod/modpost.h
===================================================================
--- linux-2.6.11.2.orig/scripts/mod/modpost.h
+++ linux-2.6.11.2/scripts/mod/modpost.h
@@ -7,7 +7,11 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
+#ifdef __CYGWIN__
+#include <libelf/libelf.h>
+#else
 #include <elf.h>
+#endif
 
 #include "elfconfig.h"
 
Index: linux-2.6.11.2/scripts/mod/mk_elfconfig.c
===================================================================
--- linux-2.6.11.2.orig/scripts/mod/mk_elfconfig.c
+++ linux-2.6.11.2/scripts/mod/mk_elfconfig.c
@@ -1,7 +1,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#ifdef __CYGWIN__
+#include <libelf/libelf.h>
+#else
 #include <elf.h>
+#endif
 
 int
 main(int argc, char **argv)
Index: linux-2.6.11.2/scripts/mod/sumversion.c
===================================================================
--- linux-2.6.11.2.orig/scripts/mod/sumversion.c
+++ linux-2.6.11.2/scripts/mod/sumversion.c
@@ -1,7 +1,10 @@
+#if defined(__sun__)
 #include <netinet/in.h>
-#ifdef __sun__
 #include <inttypes.h>
+#elif defined(__CYGWIN__)
+#include <asm/byteorder.h>	/* For ntohl/htonl */
 #else
+#include <netinet/in.h>
 #include <stdint.h>
 #endif
 #include <ctype.h>
Index: linux-2.6.11.2/scripts/mod/file2alias.c
===================================================================
--- linux-2.6.11.2.orig/scripts/mod/file2alias.c
+++ linux-2.6.11.2/scripts/mod/file2alias.c
@@ -19,9 +19,9 @@ typedef Elf32_Addr	kernel_ulong_t;
 #else
 typedef Elf64_Addr	kernel_ulong_t;
 #endif
-#ifdef __sun__
+#if defined(__sun__)
 #include <inttypes.h>
-#else
+#elif !defined(__CYGWIN__)
 #include <stdint.h>
 #endif
 
Index: linux-2.6.11.2/arch/ppc/boot/utils/mkbugboot.c
===================================================================
--- linux-2.6.11.2.orig/arch/ppc/boot/utils/mkbugboot.c
+++ linux-2.6.11.2/arch/ppc/boot/utils/mkbugboot.c
@@ -21,9 +21,9 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
-#ifdef __sun__
+#if defined(__sun__)
 #include <inttypes.h>
-#else
+#elif !defined(__CYGWIN__)
 #include <stdint.h>
 #endif
 
Index: linux-2.6.11.2/lib/gen_crc32table.c
===================================================================
--- linux-2.6.11.2.orig/lib/gen_crc32table.c
+++ linux-2.6.11.2/lib/gen_crc32table.c
@@ -1,6 +1,8 @@
 #include <stdio.h>
 #include "crc32defs.h"
+#ifndef __CYGWIN__
 #include <inttypes.h>
+#endif
 
 #define ENTRIES_PER_LINE 4
 
Index: linux-2.6.11.2/usr/gen_init_cpio.c
===================================================================
--- linux-2.6.11.2.orig/usr/gen_init_cpio.c
+++ linux-2.6.11.2/usr/gen_init_cpio.c
@@ -10,6 +10,12 @@
 #include <ctype.h>
 #include <limits.h>
 
+/* Cygwin's <limits.h> defines PATH_MAX as (260 - 1) which just won't do. */
+#ifdef __CYGWIN__
+#undef PATH_MAX
+#define PATH_MAX	259
+#endif
+
 /*
  * Original work by Jeff Garzik
  *

-- 
Tom Rini
http://gate.crashing.org/~trini/
