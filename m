Date: Mon, 12 Jul 2004 11:06:18 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040712090618.GB32413@suse.de>
References: <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de> <20040705183219.GI2146@smtp.west.cox.net> <20040709013429.GN23135@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040709013429.GN23135@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Jul 08, Tom Rini wrote:

> OK.  After giving this a whirl (after a NAK from Matt, privately), it looks
> like some versions of binutils don't make proper use of -many (in 2.14 it
> will override ppc_cpu, and PPC_OPCODE_ANY doesn't look to be used).  So
> that brings us to the following patch.  Olaf, can you please verify this
> still works for you?  Paul, is this OK with you?

This is not enough.
as needs -many (or at least -maltivec) unconditionally for binutils 2.15
gcc needs also -maltivec because -mppc seems to disable -maltivec again.

I'm rerunning my script right now, with this patch.


diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.8-rc1.orig/arch/ppc/Makefile linux-2.6.8-rc1/arch/ppc/Makefile
--- linux-2.6.8-rc1.orig/arch/ppc/Makefile	2004-07-12 08:02:54.000000000 +0200
+++ linux-2.6.8-rc1/arch/ppc/Makefile	2004-07-12 10:48:34.838426125 +0200
@@ -22,8 +22,8 @@ endif

 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-AFLAGS		+= -Iarch/$(ARCH)
-cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
+AFLAGS		+= -Iarch/$(ARCH) -Wa,-many
+cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe -Wa,-many,-mppc,-maltivec \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
