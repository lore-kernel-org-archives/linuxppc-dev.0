Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6EE7067A83
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Feb 2005 23:51:02 +1100 (EST)
Date: Sun, 6 Feb 2005 13:50:56 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050206125056.GA6394@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] remove .tmp_gas_check 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


make ARCH=ppc tags leaves a .tmp_gas_check file behind.
Just remove it after the as test.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags ../linux-2.6.11-rc3.orig/arch/ppc/Makefile ./arch/ppc/Makefile
--- ../linux-2.6.11-rc3.orig/arch/ppc/Makefile	2005-02-03 02:57:05.000000000 +0100
+++ ./arch/ppc/Makefile	2005-02-06 10:51:21.000000000 +0100
@@ -112,10 +112,10 @@ include/asm-$(ARCH)/offsets.h: arch/$(AR
 TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
-AS_ALTIVEC	:= $(shell echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; echo $$?)
+AS_ALTIVEC	:= $(shell echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; echo $$? ; rm -f $(TOUT))
 # gcc-3.4 and binutils-2.14 are a fatal combination.
 GCC_VERSION	:= $(call cc-version)
-BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o $(TOUT) >/dev/null 2>&1 && echo 0 || echo 1)
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o $(TOUT) >/dev/null 2>&1 ; echo $$? ; rm -f $(TOUT))
 
 checkbin:
 ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
