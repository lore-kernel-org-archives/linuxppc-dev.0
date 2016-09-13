Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYJqX60JjzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 19:12:56 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z84so1021587pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:12:56 -0700 (PDT)
Date: Tue, 13 Sep 2016 19:12:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
Message-ID: <20160913191244.117b544f@roar.ozlabs.ibm.com>
In-Reply-To: <14221699.K7eb6JGeeL@wuerfel>
References: <20160912113224.792b24f0@canb.auug.org.au>
 <20160913093945.521a28b4@canb.auug.org.au>
 <20160913140257.6d2de178@canb.auug.org.au>
 <14221699.K7eb6JGeeL@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Sep 2016 09:48:03 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday, September 13, 2016 2:02:57 PM CEST Stephen Rothwell wrote:
> > [For the new cc's, we are discussing the "thin archives" and "link dead
> > code/data elimination" patches in the kbuild tree.]
> > 
> > On Tue, 13 Sep 2016 09:39:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > >
> > > On Mon, 12 Sep 2016 11:03:08 +0200 Michal Marek <mmarek@suse.cz> wrote:  
> > > >
> > > > On 2016-09-12 04:53, Nicholas Piggin wrote:    
> > > > > Question, what is the best way to merge dependent patches? Considering
> > > > > they will need a good amount of architecture testing, I think they will
> > > > > have to go via arch trees. But it also does not make sense to merge these
> > > > > kbuild changes upstream first, without having tested them.      
> > > > 
> > > > I think it makes sense to merge the kbuild changes via kbuild.git, even
> > > > if they are unused and untested. Any follow-up fixes required to enable
> > > > the first architecture can go through the respective architecture tree.
> > > > Does that sound OK?    
> > > 
> > > And if you guarantee not to rebase the kbuild tree (or at least the
> > > subset containing these patches), then each of the architecture trees
> > > can just merge your tree (or a tag?) and then implement any necessary
> > > arch dependent changes.  I fixes are necessary, they can also be merged
> > > into the architecture trees.  
> > 
> > Except, of course, the kbuild tree still has the asm EXPORT_SYMBOL
> > patches that produce warnings on PowerPC  (And I am still reverting
> > the PowerPC specific one of those patches).  
> 
> Is that really powerpc specific? I have the same problem on ARM
> and I don't see how any architecture would not have it.
> 
> I prototyped the patch below, which fixes it for me, but I have
> not dared submit that workaround because it's butt ugly.

No it's not powerpc specific, it's just that powerpc build dies
if there are unresolved relocations.

Interesting approach. I have something different that may rival
yours for ugliness, but maybe keeps the muck a bit more contained.
I was just about to submit it, but now I'll wait to see if there is
a preference between the approaches:

(Note this patch alone does not resolve all export symbols, each
arch next needs to add C prototypes for their .S exports)

 scripts/Makefile.build | 71 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 11602e5..1e89908 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -158,7 +158,8 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(src)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
-cmd_gensymtypes =                                                           \
+# These mirror gensymtypes_S and co below, keep them in synch.
+cmd_gensymtypes_c =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
@@ -168,7 +169,7 @@ cmd_gensymtypes =                                                           \
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_c =                                                         \
     set -e;                                                                 \
-    $(call cmd_gensymtypes,true,$@) >/dev/null;                             \
+    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
 $(obj)/%.symtypes : $(src)/%.c FORCE
@@ -197,9 +198,10 @@ else
 #   the actual value of the checksum generated by genksyms
 
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
-cmd_modversions =								\
+
+cmd_modversions_c =								\
 	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
-		$(call cmd_gensymtypes,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
+		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
@@ -267,13 +269,14 @@ endif # CONFIG_STACK_VALIDATION
 define rule_cc_o_c
 	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
 	$(call cmd_and_fixdep,cc_o_c)					  \
-	$(cmd_modversions)						  \
+	$(cmd_modversions_c)						  \
 	$(cmd_objtool)						          \
 	$(call echo-cmd,record_mcount) $(cmd_record_mcount)
 endef
 
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)					  \
+	$(cmd_modversions_S)						  \
 	$(cmd_objtool)
 endef
 
@@ -313,6 +316,32 @@ modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
 $(real-objs-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 
+# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
+# or a file that it includes, in order to get versioned symbols. We build a
+# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
+# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
+#
+# These mirror gensymtypes_c and co above, keep them in synch.
+cmd_gensymtypes_S =                                                         \
+    (echo "\#include <linux/kernel.h>" ;                                    \
+     echo "\#include <asm/asm-prototypes.h>" ;                              \
+     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
+    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
+    $(GENKSYMS) $(if $(1), -T $(2))                                         \
+     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
+     $(if $(KBUILD_PRESERVE),-p)                                            \
+     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
+
+quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
+cmd_cc_symtypes_S =                                                         \
+    set -e;                                                                 \
+    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
+    test -s $@ || rm -f $@
+
+$(obj)/%.symtypes : $(src)/%.S FORCE
+	$(call cmd,cc_symtypes_S)
+
+
 quiet_cmd_cpp_s_S = CPP $(quiet_modtag) $@
 cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<
 
@@ -320,7 +349,37 @@ $(obj)/%.s: $(src)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
+
+ifndef CONFIG_MODVERSIONS
+cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
+
+else
+
+ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
+
+ifeq ($(ASM_PROTOTYPES),)
+cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
+
+else
+
+# versioning matches the C process described above, with difference that
+# we parse asm-prototypes.h C header to get function definitions.
+
+cmd_as_o_S = $(CC) $(a_flags) -c -o $(@D)/.tmp_$(@F) $<
+
+cmd_modversions_S =								\
+	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
+		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
+		    > $(@D)/.tmp_$(@F:.o=.ver);					\
+										\
+		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
+			-T $(@D)/.tmp_$(@F:.o=.ver);				\
+		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
+	else									\
+		mv -f $(@D)/.tmp_$(@F) $@;					\
+	fi;
+endif
+endif
 
 $(obj)/%.o: $(src)/%.S $(objtool_obj) FORCE
 	$(call if_changed_rule,as_o_S)
-- 
2.9.3
