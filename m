Date: Thu, 15 Jul 2004 16:24:47 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040715142447.GA30652@suse.de>
References: <20040713134945.GA5104@suse.de> <20040713140127.GJ16877@smtp.west.cox.net> <20040713140220.GA20213@suse.de> <20040713142015.GK16877@smtp.west.cox.net> <20040713151854.GA7858@suse.de> <20040713152633.GL16877@smtp.west.cox.net> <20040713152950.GB7858@suse.de> <20040714232336.GO21856@smtp.west.cox.net> <20040715125032.GA20266@suse.de> <20040715141540.GQ21856@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040715141540.GQ21856@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Jul 15, Tom Rini wrote:

> On Thu, Jul 15, 2004 at 02:50:32PM +0200, Olaf Hering wrote:
>
> >  On Wed, Jul 14, Tom Rini wrote:
> >
> >
> > > +BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null 2>/dev/null 2>&1 && echo 0 || echo 1)
> > >
> > > -ifneq ($(NEW_AS),0)
> > >  checkbin:
> > > +ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
> >
> > How is this supposed to work? You get either 0 or 1.
>
> OK.  The intent was that GCC_VERSION is always run, which will give
> '0304' on gcc-3.4 (tested) and if the binutils test also fails it will
> always give '1'.

It should be '-o /dev/null >/dev/null 2>&1 ; echo $$?'
A @false is also missing.


diff -purN linux-2.6.8-rc1.trini/arch/ppc/Makefile linux-2.6.8-rc1/arch/ppc/Makefile
--- linux-2.6.8-rc1.trini/arch/ppc/Makefile	2004-07-15 16:22:12.355246237 +0200
+++ linux-2.6.8-rc1/arch/ppc/Makefile	2004-07-15 16:23:18.693626129 +0200
@@ -114,13 +114,14 @@ NEW_AS	:= 0
 endif
 # gcc-3.4 and binutils-2.14 are a fatal combination.
 GCC_VERSION	:= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
-BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null 2>/dev/null 2>&1 && echo 0 || echo 1)
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null >/dev/null 2>&1 ; echo $$?)

 checkbin:
 ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
-	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no lonber build '
+	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
 	@echo 'correctly with gcc-3.4 and your version of binutils.'
 	@echo '*** Please upgrade your binutils or downgrade your gcc'
+	@false
 endif
 ifneq ($(NEW_AS),0)
 	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
