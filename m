Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0437F2BF08
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Oct 2004 02:41:37 +1000 (EST)
Date: Sun, 24 Oct 2004 18:09:23 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20041024160923.GA22167@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] write gas check tmp file to O= directory
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


the tmp file should be in the O= directory.

btw, why does the mftb check not use '$?'?

diff -purN linux-2.6.9.orig/arch/ppc/Makefile linux-2.6.9-olh/arch/ppc/Makefile
--- linux-2.6.9.orig/arch/ppc/Makefile	2004-10-22 19:02:37.000000000 +0200
+++ linux-2.6.9-olh/arch/ppc/Makefile	2004-10-24 11:30:46.414921904 +0200
@@ -109,10 +109,10 @@ include/asm-$(ARCH)/offsets.h: arch/$(AR
 TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
-AS_ALTIVEC	:= $(shell echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; echo $$?)
+AS_ALTIVEC	:= $(shell echo dssall | $(AS) -many -o $(objdir)$(TOUT) >/dev/null 2>&1 ; echo $$?)
 # gcc-3.4 and binutils-2.14 are a fatal combination.
 GCC_VERSION	:= $(call cc-version)
-BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o $(TOUT) >/dev/null 2>&1 && echo 0 || echo 1)
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o $(objdir)$(TOUT) >/dev/null 2>&1 && echo 0 || echo 1)
 
 checkbin:
 ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
@@ -132,5 +132,5 @@ endif
 
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s \
-		$(TOUT)
+		$(objdir)$(TOUT)
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
