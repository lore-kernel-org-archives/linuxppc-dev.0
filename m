Return-Path: <sam@ravnborg.org>
Received: from asavdk3.altibox.net (asavdk3.altibox.net [109.247.116.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6jsF48mXzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 00:41:03 +1000 (AEST)
Date: Sun, 7 Aug 2016 16:40:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <20160807144054.GA14682@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
 <20160807114946.41b682f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160807114946.41b682f3@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 07, 2016 at 11:49:46AM +1000, Stephen Rothwell wrote:
> Hi Sam,
> 
> On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Did you by any chance evalue the use of INPUT in linker files.
> > Stephen back then (again based on proposal from Alan Modra),
> > also made an implementation using INPUT.
> 
> The problem with that idea was that (at least for some versions of
> binutils in use at the time) we hit a static limit to the number of
> object files and ld just stopped at that point. :-(

The ld bug was caused by opening too many linked definitions files.
We can workaround this by expanding the files.
I gave this a quick spin - see below.

Note - I have no idea if using thin archived or this method is better.
But it seems just wrong to me that we convert to thin archives when
we really do not need to do so.

Note - this was a quick spin. It build fine here and thats it.

	Sam

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 11602e5..37b8bc9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -360,10 +360,16 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 ifdef builtin-target
 quiet_cmd_link_o_target = LD      $@
 # If the list of objects to link is empty, just create an empty built-in.o
-cmd_link_o_target = $(if $(strip $(obj-y)),\
-		      $(LD) $(ld_flags) -r -o $@ $(filter $(obj-y), $^) \
-		      $(cmd_secanalysis),\
-		      rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@)
+cmd_link_o_target =                                            \
+$(if $(filter $(obj-y), $^),                                   \
+	echo $(foreach file, $(filter $(obj-y), $^),           \
+		$(if $(filter %/built-in.o, $(file)),          \
+			$(shell cat $(file)),                  \
+			$(file)                                \
+		)                                              \
+	)                                                      \
+        , echo ""                                              \
+) > $@
 
 $(builtin-target): $(obj-y) FORCE
 	$(call if_changed,link_o_target)
@@ -414,10 +420,10 @@ $($(subst $(obj)/,,$(@:.o=-y)))       \
 $($(subst $(obj)/,,$(@:.o=-m)))), $^)
 
 quiet_cmd_link_multi-y = LD      $@
-cmd_link_multi-y = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
+cmd_link_multi-y = echo INPUT\($(link_multi_deps)\) > $@
 
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(cmd_link_multi-y)
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps)
 
 $(multi-used-y): FORCE
 	$(call if_changed,link_multi-y)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 4f727eb..323c13a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -41,8 +41,8 @@ info()
 # ${1} output file
 modpost_link()
 {
-	${LD} ${LDFLAGS} -r -o ${1} ${KBUILD_VMLINUX_INIT}                   \
-		--start-group ${KBUILD_VMLINUX_MAIN} --end-group
+	${LD} ${LDFLAGS} -r -o ${1} ${vmlinux_init}            \
+		--start-group ${vmlinux_main} --end-group
 }
 
 # Link of vmlinux
@@ -54,13 +54,13 @@ vmlinux_link()
 
 	if [ "${SRCARCH}" != "um" ]; then
 		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}                  \
-			-T ${lds} ${KBUILD_VMLINUX_INIT}                     \
-			--start-group ${KBUILD_VMLINUX_MAIN} --end-group ${1}
+			-T ${lds} ${vmlinux_init}                            \
+			--start-group ${vmlinux_main} --end-group ${1}
 	else
 		${CC} ${CFLAGS_vmlinux} -o ${2}                              \
-			-Wl,-T,${lds} ${KBUILD_VMLINUX_INIT}                 \
+			-Wl,-T,${lds} ${vmlinux_init}                        \
 			-Wl,--start-group                                    \
-				 ${KBUILD_VMLINUX_MAIN}                      \
+				 ${vmlinux_main}                             \
 			-Wl,--end-group                                      \
 			-lutil -lrt -lpthread ${1}
 		rm -f linux
@@ -162,6 +162,23 @@ case "${KCONFIG_CONFIG}" in
 	. "./${KCONFIG_CONFIG}"
 esac
 
+# Expand built-in.o file as they just list .o files
+for f in ${KBUILD_VMLINUX_INIT}; do
+	if [ $(basename $f) = built-in.o ]; then
+		vmlinux_init="${vmlinux_init} $(cat $f)"
+	else
+		vmlinux_init="${vmlinux_init} $f"
+	fi
+done
+
+for f in ${KBUILD_VMLINUX_MAIN}; do
+	if [ $(basename $f) = built-in.o ]; then
+		vmlinux_main="${vmlinux_main} $(cat $f)"
+	else
+		vmlinux_main="${vmlinux_main} $f"
+	fi
+done
+
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
