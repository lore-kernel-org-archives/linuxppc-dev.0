Date: Sun, 4 Jul 2004 00:29:18 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040703222918.GA10425@suse.de>
References: <20040610001605.GH18212@smtp.west.cox.net> <20040614091530.GA18482@suse.de> <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040615174648.GC14528@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, Jun 15, Tom Rini wrote:

> And yes, passing -many does work on all older supported versions of
> binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> done with it now (and for future fixes of this sort).

gcc 3.2 passes only -mppc, so all altive instructions will fail to
compile without either -many or -maltivec

I have tested this patch with
gcc 3.2.3 + binutils-2.15.91.0.1
gcc 3.3.4 + binutils-2.15.91.0.1
gcc 3.4.1 + binutils-2.15.91.0.1
gcc 3.2.3 + binutils-2.15
gcc 3.3.4 + binutils-2.15
gcc 3.4.1 + binutils-2.15


diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7-bk16.orig/arch/ppc/Makefile linux-2.6.7-bk16/arch/ppc/Makefile
--- linux-2.6.7-bk16.orig/arch/ppc/Makefile	2004-07-03 22:33:35.000000000 +0200
+++ linux-2.6.7-bk16/arch/ppc/Makefile	2004-07-03 23:11:10.037787069 +0200
@@ -24,6 +24,9 @@ ifndef CONFIG_E500
 cflags-y	+= -mstring
 endif

+# gcc 3.2.3 passes -mppc,
+# the altivec asm code will fail to compile with binutils newer than 2.15
+cflags-$(CONFIG_6xx)		+= -Wa,-many
 cflags-$(CONFIG_4xx)		+= -Wa,-m405
 cflags-$(CONFIG_E500)		+= -Wa,-me500
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7-bk16.orig/arch/ppc/kernel/Makefile linux-2.6.7-bk16/arch/ppc/kernel/Makefile
--- linux-2.6.7-bk16.orig/arch/ppc/kernel/Makefile	2004-07-03 22:33:35.000000000 +0200
+++ linux-2.6.7-bk16/arch/ppc/kernel/Makefile	2004-07-03 22:51:16.802332774 +0200
@@ -8,6 +8,9 @@ endif
 ifdef CONFIG_4xx
 EXTRA_AFLAGS		:= -Wa,-m405
 endif
+ifdef CONFIG_6xx
+EXTRA_AFLAGS		:= -Wa,-maltivec
+endif
 ifdef CONFIG_E500
 EXTRA_AFLAGS		:= -Wa,-me500
 endif

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
