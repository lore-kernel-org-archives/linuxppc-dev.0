Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 299ADDDECD
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 04:41:18 +1000 (EST)
Date: Fri, 19 Oct 2007 20:42:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>, ppcdev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Merge dtc
Message-ID: <20071019184249.GA32015@uranus.ravnborg.org>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
	<20071018195926.GA22887@uranus.ravnborg.org>
	<20071019014510.GD30283@localhost.localdomain>
	<1b5c57d93e45d94d007b543ea5e2de02@bga.com>
	<20071019065530.GA27017@localhost.localdomain>
	<20071019070718.GA28099@uranus.ravnborg.org>
	<20071019071033.GB27017@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019071033.GB27017@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David.

> > Give me a day or two then I shall give it a try and see what I can
> > do about it.  I will use the previsous posted URL as basis if you do
> > not tell me otherwise.
> 
> Thank you.  The previous URL should be fine, I've made no changes
> since then.

I decided to go for a kbuild specific version integrated
in boot/Makefile.
This is much more readable because this syntax is explicit.
We do not favour 3 levels of variabls to avoid rewriting the same
filename two times.
I have tested the change only with a O=.. crosscompile build.

I have tested the patch with and without DTC_GENPARSER=1.
It does not rebuild if not needed and is OK with -j10 builds.

Please consider this version in favour of your old version.

Take this as review feedback.

You can add:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org> [kbuild integration only]

Thanks,
	Sam

 arch/powerpc/boot/Makefile |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..064dc07 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -108,17 +108,53 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S FORCE
 $(obj)/wrapper.a: $(obj-wlib) FORCE
 	$(call if_changed,bootar)
 
-hostprogs-y	:= addnote addRamDisk hack-coff mktree
+hostprogs-y	:= addnote addRamDisk hack-coff mktree dtc
 
 targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree dtc) \
 			$(wrapper) FORCE
 
 #############
+# Bits for building dtc
+# DTC_GENPARSER	:= 1	# Uncomment to rebuild flex/bison output
+
+dtc-objs := dtc.o flattree.o fstree.o data.o livetree.o treesource.o srcpos.o
+dtc-objs += dtc-lexer.lex.o dtc-parser.tab.o
+dtc-objs := $(addprefix dtc-src/, $(dtc-objs))
+
+# prerequisites on generated files needs to be explicit
+$(obj)/dtc-src/dtc-parser.tab.o: $(obj)/dtc-src/dtc-parser.tab.c $(obj)/dtc-src/dtc-parser.tab.h
+$(obj)/dtc-src/dtc-lexer.lex.o:  $(obj)/dtc-src/dtc-lexer.lex.c
+$(obj)/dtc-src/data.o:           $(obj)/dtc-src/dtc-parser.tab.h
+
+HOSTCFLAGS += -I$(src)/dtc-src/
+
+targets += dtc-src/dtc-parser.tab.c
+targets += dtc-src/dtc-lexer.lex.c
+
+ifdef DTC_GENPARSER
+BISON = bison
+FLEX = flex
+
+quiet_cmd_bison = BISON   $@
+      cmd_bison = $(BISON) -o$@ -d $<; cp $@ $@_shipped
+quiet_cmd_flex = FLEX    $@
+      cmd_flex = $(FLEX) -o$@ $<; cp $@ $@_shipped
+
+$(obj)/dtc-src/dtc-parser.tab.c: $(src)/dtc-src/dtc-parser.y FORCE
+	$(call if_changed,bison)
+
+$(obj)/dtc-src/dtc-parser.tab.h: $(obj)/dtc-src/dtc-parser.tab.c
+
+$(obj)/dtc-src/dtc-lexer.lex.c: $(src)/dtc-src/dtc-lexer.l FORCE
+	$(call if_changed,flex)
+endif
+
+#############
 # Bits for building various flavours of zImage
 
 ifneq ($(CROSS32_COMPILE),)
