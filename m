Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 92E7F67A86
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 19:24:12 +1100 (EST)
Date: Mon, 7 Feb 2005 09:23:56 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050207082356.GA29823@suse.de>
References: <20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
	<20050206200431.GC7686@smtp.west.cox.net>
	<20050206200802.GA28652@suse.de>
	<20050206202154.GD7686@smtp.west.cox.net>
	<20050206211506.GA31123@suse.de>
	<20050206214951.GE7686@smtp.west.cox.net>
	<20050206215600.GA2062@suse.de>
	<20050206224306.GG7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206224306.GG7686@smtp.west.cox.net>
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

> On Sun, Feb 06, 2005 at 10:56:00PM +0100, Olaf Hering wrote:
> >  On Sun, Feb 06, Tom Rini wrote:
> > 
> > > On Sun, Feb 06, 2005 at 10:15:06PM +0100, Olaf Hering wrote:
> > > 
> > > >  On Sun, Feb 06, Tom Rini wrote:
> > > > 
> > > > > I agree you shouldn't have to see it.  I'm saying the problem is the
> > > > > variable shouldn't be evaluated.
> > > > 
> > > > This patch seems to work for me.
> > > 
> > > What I don't like is that checkbin shouldn't be evaluated for 'tags' or
> > > other non-compile targets, so you don't need those explicit rm's.  Also,
> > > you forgot the signed-off-by line :)
> > 
> > Why should make tags or oldconfig ever care about the installed toolchain?
> 
> It shouldn't, and 'tags' at least shouldn't depend on 'checkbin'

tags does not call checkbin, so this part is ok.

> > How should the tmpfile disappear if one calls make checkbin with success?
> 
> On make clean, like the other .tmp files that are around at the end of a
> kernel compile (kallsyms/modules/maybe something else).

Thats ok now.

> > Maybe I misunderstood you.
> 
> I think so.  We both agree there should be no ppc-specific .tmp files
> around after certain make targets.  I'm saying that there's always some
> .tmp files generated on every arch for certain targets, and removed with
> a clean.  PPC should only create .tmp files (And leave them alone) in
> the cases where every arch generates some .tmp files.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags ../linux-2.6.11-rc3.orig/arch/ppc/Makefile ./arch/ppc/Makefile
--- ../linux-2.6.11-rc3.orig/arch/ppc/Makefile	2005-02-03 02:57:05.000000000 +0100
+++ ./arch/ppc/Makefile	2005-02-07 09:21:25.941904406 +0100
@@ -112,26 +112,24 @@ include/asm-$(ARCH)/offsets.h: arch/$(AR
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
+			false; \
+		fi ; \
+	fi
+	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
+		echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build ' ; \
+		echo 'correctly with old versions of binutils.' ; \
+		echo '*** Please upgrade your binutils to 2.12.1 or newer' ; \
+		false ; \
+	fi
 
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s \
