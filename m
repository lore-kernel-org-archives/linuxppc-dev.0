Date: Mon, 5 Jul 2004 11:32:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>, Kumar Gala <kumar.gala@freescale.com>,
	Matt Porter <mporter@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040705183219.GI2146@smtp.west.cox.net>
References: <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040704072350.GA7060@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 04, 2004 at 09:23:50AM +0200, Olaf Hering wrote:
>
>  On Sun, Jul 04, Olaf Hering wrote:
>
> >
> >  On Tue, Jun 15, Tom Rini wrote:
> >
> > > And yes, passing -many does work on all older supported versions of
> > > binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> > > done with it now (and for future fixes of this sort).
> >
> > gcc 3.2 passes only -mppc, so all altive instructions will fail to
> > compile without either -many or -maltivec
> >
> > I have tested this patch with
> > gcc 3.2.3 + binutils-2.15.91.0.1
> > gcc 3.3.4 + binutils-2.15.91.0.1
> > gcc 3.4.1 + binutils-2.15.91.0.1
> > gcc 3.2.3 + binutils-2.15
> > gcc 3.3.4 + binutils-2.15
> > gcc 3.4.1 + binutils-2.15
>
> I meant to sent this version of the patch, really use -many also for the
> .S files.
[snip]

Kumar, Matt, can you give the following a shot on e500 and 4xx please?
This should fix Olaf's problem, and remove some workarounds for
previous binutils changes of this nature (to get 'foo' instruction, now
you must pass -mbar to the assembler):

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

===== arch/ppc/Makefile 1.54 vs edited =====
--- 1.54/arch/ppc/Makefile	2004-06-26 14:10:12 -07:00
+++ edited/arch/ppc/Makefile	2004-07-05 11:27:18 -07:00
@@ -15,17 +15,15 @@

 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-AFLAGS		+= -Iarch/$(ARCH)
+AFLAGS		+= -Iarch/$(ARCH) -Wa,-many
 cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
-		-ffixed-r2 -Wno-uninitialized -mmultiple
+		-ffixed-r2 -Wno-uninitialized -mmultiple -Wa,-many
 CPP		= $(CC) -E $(CFLAGS)

 ifndef CONFIG_E500
 cflags-y	+= -mstring
 endif

-cflags-$(CONFIG_4xx)		+= -Wa,-m405
-cflags-$(CONFIG_E500)		+= -Wa,-me500
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge

 CFLAGS += $(cflags-y)
===== arch/ppc/kernel/Makefile 1.47 vs edited =====
--- 1.47/arch/ppc/kernel/Makefile	2004-06-17 23:41:08 -07:00
+++ edited/arch/ppc/kernel/Makefile	2004-07-05 11:27:22 -07:00
@@ -5,12 +5,6 @@
 ifdef CONFIG_PPC64BRIDGE
 EXTRA_AFLAGS		:= -Wa,-mppc64bridge
 endif
-ifdef CONFIG_4xx
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-ifdef CONFIG_E500
-EXTRA_AFLAGS		:= -Wa,-me500
-endif

 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
 extra-$(CONFIG_40x)		:= head_4xx.o

If this does take care of everything, Paul, is this OK with you?
(and it might also remove the need for the -mppc64bridge bit, if
you'd like to test that. :))

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
