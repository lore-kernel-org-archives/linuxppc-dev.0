Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4783367A72
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 08:15:13 +1100 (EST)
Date: Sun, 6 Feb 2005 22:15:06 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050206211506.GA31123@suse.de>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
	<20050206200431.GC7686@smtp.west.cox.net>
	<20050206200802.GA28652@suse.de>
	<20050206202154.GD7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206202154.GD7686@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 06, Tom Rini wrote:

> I agree you shouldn't have to see it.  I'm saying the problem is the
> variable shouldn't be evaluated.

This patch seems to work for me.


diff -purNx tags ../linux-2.6.11-rc3.orig/arch/ppc/Makefile ./arch/ppc/Makefile
--- ../linux-2.6.11-rc3.orig/arch/ppc/Makefile	2005-02-03 02:57:05.000000000 +0100
+++ ./arch/ppc/Makefile	2005-02-06 22:13:01.093237836 +0100
@@ -112,26 +112,27 @@ include/asm-$(ARCH)/offsets.h: arch/$(AR
 TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
-AS_ALTIVEC	:= $(shell echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; echo $$?)
 # gcc-3.4 and binutils-2.14 are a fatal combination.
 GCC_VERSION	:= $(call cc-version)
-BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o $(TOUT) >/dev/null 2>&1 && echo 0 || echo 1)
 
 checkbin:
-ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
-	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
-	@echo 'correctly with gcc-3.4 and your version of binutils.'
-	@echo '*** Please upgrade your binutils or downgrade your gcc'
-	@false
-endif
-ifneq ($(AS_ALTIVEC),0)
-	echo $(AS_ALTIVEC)
-	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
-	@echo 'correctly with old versions of binutils.'
-	@echo '*** Please upgrade your binutils to 2.12.1 or newer'
-	@false
-endif
-	@true
+	@if test "$(GCC_VERSION)" = "0304" ; then \
+		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
+			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '; \
+			echo 'correctly with gcc-3.4 and your version of binutils.'; \
+			echo '*** Please upgrade your binutils or downgrade your gcc'; \
+			rm -f $(TOUT) ;\
+			false; \
+		fi ; \
+	fi
+	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
+		echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build ' ; \
+		echo 'correctly with old versions of binutils.' ; \
+		echo '*** Please upgrade your binutils to 2.12.1 or newer' ; \
+		rm -f $(TOUT) ; \
+		false ; \
+	fi
+	@rm -f $(TOUT)
 
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s \
