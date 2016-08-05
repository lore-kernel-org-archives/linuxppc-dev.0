Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Qg046kszDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 22:12:44 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so19297891pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 05:12:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: [PATCH 1/5] kbuild: allow architectures to use thin archives instead
 of ld -r
Date: Fri,  5 Aug 2016 22:11:59 +1000
Message-Id: <1470399123-8455-2-git-send-email-npiggin@gmail.com>
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

ld -r is an incremental link used to create built-in.o files in build
subdirectories. It produces relocatable object files containing all
its input files, and these are are then pulled together and relocated
in the final link. Aside from the bloat, this constrains the final
link relocations, which has bitten large powerpc builds with
unresolvable relocations in the final link.

Alan Modra has recommended the kernel use thin archives for linking.
This is an alternative and means that the linker has more information
available to it when it links the kernel.

This patch enables a config option architectures can select, which
causes all built-in.o files to be built as thin archives. built-in.o
files in subdirectories do not get symbol table or index attached,
which improves speed and size. The final link pass creates a
built-in.o archive in the root output directory which includes the
symbol table and index. The linker then uses takes this file to link.

The --whole-archive linker option is required, because the linker now
has visibility to every individual object file, and it will otherwise
just completely avoid including those without external references
(consider a file with EXPORT_SYMBOL or initcall or hardware exceptions
as its only entry points). The traditional built works "by luck" as
built-in.o files are large enough that they're going to get external
references. However this optimisation is unpredictable for the kernel
(due to above external references), ineffective at culling unused, and
costly because the .o files have to be searched for references.
Superior alternatives for link-time culling should be used instead.

Build characteristics for inclink vs thinarc, on a small powerpc64le
pseries VM with a modest .config:

                                  inclink       thinarc
sizes
vmlinux                        15 618 680    15 625 028
sum of all built-in.o          56 091 808     1 054 334
sum excluding root built-in.o                   151 430

find -name built-in.o | xargs rm ; time make vmlinux
real                              22.772s       21.143s
user                              13.280s       13.430s
sys                                4.310s        2.750s

- Final kernel pulled in only about 6K more, which shows how
  ineffective the object file culling is.
- Build performance looks improved due to less pagecache activity.
  On IO constrained systems it could be a bigger win.
- Build size saving is significant.

Side note, the toochain understands archives, so there's some tricks,
$ ar t built-in.o          # list all files you linked with
$ size built-in.o          # and their sizes
$ objdump -d built-in.o    # disassembly (unrelocated) with filenames

Implementation by sfr, minor tweaks by npiggin.

Cc: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alan Modra <amodra@gmail.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig            |  6 +++++
 scripts/Makefile.build  | 23 +++++++++++++---
 scripts/link-vmlinux.sh | 71 +++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d794384..1330bf4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -424,6 +424,12 @@ config CC_STACKPROTECTOR_STRONG
 
 endchoice
 
+config THIN_ARCHIVES
+	bool
+	help
+	  Select this if the architecture wants to use thin archives
+	  instead of ld -r to create the built-in.o files.
+
 config HAVE_CONTEXT_TRACKING
 	bool
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0d1ca5b..7fab825 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -358,12 +358,22 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 # Rule to compile a set of .o files into one .o file
 #
 ifdef builtin-target
-quiet_cmd_link_o_target = LD      $@
+
+ifdef CONFIG_THIN_ARCHIVES
+  cmd_make_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS)
+  cmd_make_empty_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS)
+  quiet_cmd_link_o_target = AR      $@
+else
+  cmd_make_builtin = $(LD) $(ld_flags) -r -o
+  cmd_make_empty_builtin = rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS)
+  quiet_cmd_link_o_target = LD      $@
+endif
+
 # If the list of objects to link is empty, just create an empty built-in.o
 cmd_link_o_target = $(if $(strip $(obj-y)),\
-		      $(LD) $(ld_flags) -r -o $@ $(filter $(obj-y), $^) \
+		      $(cmd_make_builtin) $@ $(filter $(obj-y), $^) \
 		      $(cmd_secanalysis),\
-		      rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@)
+		      $(cmd_make_empty_builtin) $@)
 
 $(builtin-target): $(obj-y) FORCE
 	$(call if_changed,link_o_target)
@@ -389,7 +399,12 @@ $(modorder-target): $(subdir-ym) FORCE
 #
 ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
-cmd_link_l_target = rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@ $(lib-y)
+
+ifdef CONFIG_THIN_ARCHIVES
+  cmd_link_l_target = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS) $@ $(lib-y)
+else
+  cmd_link_l_target = rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@ $(lib-y)
+endif
 
 $(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f0f6d9d..a234ffe 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -37,12 +37,40 @@ info()
 	fi
 }
 
+# Thin archive build here makes a final archive with
+# symbol table and indexes from vmlinux objects, which can be
+# used as input to linker.
+#
+# Traditional incremental style of link does not require this step
+#
+# built-in.o output file
+#
+archive_builtin()
+{
+	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+		info AR built-in.o
+		rm -f built-in.o;
+		${AR} rcsT${KBUILD_ARFLAGS} built-in.o			\
+					${KBUILD_VMLINUX_INIT}		\
+					${KBUILD_VMLINUX_MAIN}
+	fi
+}
+
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
 {
-	${LD} ${LDFLAGS} -r -o ${1} ${KBUILD_VMLINUX_INIT}                   \
-		--start-group ${KBUILD_VMLINUX_MAIN} --end-group
+	local objects
+
+	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+		objects="--whole-archive built-in.o"
+	else
+		objects="${KBUILD_VMLINUX_INIT}				\
+			--start-group					\
+			${KBUILD_VMLINUX_MAIN}				\
+			--end-group"
+	fi
+	${LD} ${LDFLAGS} -r -o ${1} ${objects}
 }
 
 # Link of vmlinux
@@ -51,18 +79,36 @@ modpost_link()
 vmlinux_link()
 {
 	local lds="${objtree}/${KBUILD_LDS}"
+	local objects
 
 	if [ "${SRCARCH}" != "um" ]; then
-		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}                  \
-			-T ${lds} ${KBUILD_VMLINUX_INIT}                     \
-			--start-group ${KBUILD_VMLINUX_MAIN} --end-group ${1}
+		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+			objects="--whole-archive built-in.o ${1}"
+		else
+			objects="${KBUILD_VMLINUX_INIT}			\
+				--start-group				\
+				${KBUILD_VMLINUX_MAIN}			\
+				--end-group				\
+				${1}"
+		fi
+
+		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}		\
+			-T ${lds} ${objects}
 	else
-		${CC} ${CFLAGS_vmlinux} -o ${2}                              \
-			-Wl,-T,${lds} ${KBUILD_VMLINUX_INIT}                 \
-			-Wl,--start-group                                    \
-				 ${KBUILD_VMLINUX_MAIN}                      \
-			-Wl,--end-group                                      \
-			-lutil -lrt -lpthread ${1}
+		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+			objects="-Wl,--whole-archive built-in.o ${1}"
+		else
+			objects="${KBUILD_VMLINUX_INIT}			\
+				-Wl,--start-group			\
+				${KBUILD_VMLINUX_MAIN}			\
+				-Wl,--end-group				\
+				${1}"
+		fi
+
+		${CC} ${CFLAGS_vmlinux} -o ${2}				\
+			-Wl,-T,${lds} ${KBUILD_VMLINUX_INIT}		\
+			-lutil -lrt -lpthread				\
+			${objects}
 		rm -f linux
 	fi
 }
@@ -119,6 +165,7 @@ cleanup()
 	rm -f .tmp_kallsyms*
 	rm -f .tmp_version
 	rm -f .tmp_vmlinux*
+	rm -f built-in.o
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.o
@@ -162,6 +209,8 @@ case "${KCONFIG_CONFIG}" in
 	. "./${KCONFIG_CONFIG}"
 esac
 
+archive_builtin
+
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
-- 
2.8.1
