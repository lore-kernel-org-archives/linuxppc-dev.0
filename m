Date: Thu, 8 Jul 2004 18:34:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040709013429.GN23135@smtp.west.cox.net>
References: <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de> <20040705183219.GI2146@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040705183219.GI2146@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 05, 2004 at 11:32:19AM -0700, Tom Rini wrote:
> On Sun, Jul 04, 2004 at 09:23:50AM +0200, Olaf Hering wrote:
> >  On Sun, Jul 04, Olaf Hering wrote:
> > >  On Tue, Jun 15, Tom Rini wrote:
> > >
> > > > And yes, passing -many does work on all older supported versions of
> > > > binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> > > > done with it now (and for future fixes of this sort).
> > >
> > > gcc 3.2 passes only -mppc, so all altive instructions will fail to
> > > compile without either -many or -maltivec
> > >
> > > I have tested this patch with
> > > gcc 3.2.3 + binutils-2.15.91.0.1
> > > gcc 3.3.4 + binutils-2.15.91.0.1
> > > gcc 3.4.1 + binutils-2.15.91.0.1
> > > gcc 3.2.3 + binutils-2.15
> > > gcc 3.3.4 + binutils-2.15
> > > gcc 3.4.1 + binutils-2.15
> >
> > I meant to sent this version of the patch, really use -many also for the
> > .S files.
> [snip]
>
> Kumar, Matt, can you give the following a shot on e500 and 4xx please?
> This should fix Olaf's problem, and remove some workarounds for
> previous binutils changes of this nature (to get 'foo' instruction, now
> you must pass -mbar to the assembler):

OK.  After giving this a whirl (after a NAK from Matt, privately), it looks
like some versions of binutils don't make proper use of -many (in 2.14 it
will override ppc_cpu, and PPC_OPCODE_ANY doesn't look to be used).  So
that brings us to the following patch.  Olaf, can you please verify this
still works for you?  Paul, is this OK with you?

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

===== arch/ppc/Makefile 1.78 vs edited =====
--- 1.78/arch/ppc/Makefile	2004-07-08 16:04:11 -07:00
+++ edited/arch/ppc/Makefile	2004-07-08 18:32:17 -07:00
@@ -23,7 +23,7 @@
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
 AFLAGS		+= -Iarch/$(ARCH)
-cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
+cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe -Wa,-many,-mppc \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)


--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
