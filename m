Return-Path: <sam@ravnborg.org>
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6FQS6DHQzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 06:19:44 +1000 (AEST)
Date: Sat, 6 Aug 2016 22:10:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <20160806201045.GA25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470399123-8455-2-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas.

On Fri, Aug 05, 2016 at 10:11:59PM +1000, Nicholas Piggin wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> ld -r is an incremental link used to create built-in.o files in build
> subdirectories. It produces relocatable object files containing all
> its input files, and these are are then pulled together and relocated
> in the final link. Aside from the bloat, this constrains the final
> link relocations, which has bitten large powerpc builds with
> unresolvable relocations in the final link.
> 
> Alan Modra has recommended the kernel use thin archives for linking.
> This is an alternative and means that the linker has more information
> available to it when it links the kernel.
> 
> This patch enables a config option architectures can select,
If we want to do this, then I suggest to make the logic reverse.
Architectures that for some reasons cannot use this should
have the possibility to avoid it. But let it be enabled by default.

> which
> causes all built-in.o files to be built as thin archives. built-in.o
> files in subdirectories do not get symbol table or index attached,
> which improves speed and size. The final link pass creates a
> built-in.o archive in the root output directory which includes the
> symbol table and index. The linker then uses takes this file to link.
> 
> The --whole-archive linker option is required, because the linker now
> has visibility to every individual object file, and it will otherwise
> just completely avoid including those without external references
> (consider a file with EXPORT_SYMBOL or initcall or hardware exceptions
> as its only entry points). The traditional built works "by luck" as
> built-in.o files are large enough that they're going to get external
> references. However this optimisation is unpredictable for the kernel
> (due to above external references), ineffective at culling unused, and
> costly because the .o files have to be searched for references.
> Superior alternatives for link-time culling should be used instead.
> 
> Build characteristics for inclink vs thinarc, on a small powerpc64le
> pseries VM with a modest .config:
> 
>                                   inclink       thinarc
> sizes
> vmlinux                        15 618 680    15 625 028
> sum of all built-in.o          56 091 808     1 054 334
> sum excluding root built-in.o                   151 430
> 
> find -name built-in.o | xargs rm ; time make vmlinux
> real                              22.772s       21.143s
> user                              13.280s       13.430s
> sys                                4.310s        2.750s
> 
> - Final kernel pulled in only about 6K more, which shows how
>   ineffective the object file culling is.
> - Build performance looks improved due to less pagecache activity.
>   On IO constrained systems it could be a bigger win.
> - Build size saving is significant.

Good to see this old proposal picked up again!

Did you by any chance evalue the use of INPUT in linker files.
Stephen back then (again based on proposal from Alan Modra),
also made an implementation using INPUT.
See below for an updated simple patch on top of mainline.

Build statistics for "make defconfig" on my i7 box:

find -name built-in.o; xargs rm; time make -j16 vmlinux
	standard	singlelink	delta
real	0m6.368s	0m7.040s	+672ms
user	0m15.577s	0m14.960s	-617ms
sys	0m7.601s	0m6.226s	-1375ms

vmlinux size:		standard	singlelink	delta
text			10.250.675	10.250.675	0
data			4.369.632	4.374.816	+5184
bss			1.110.016	1.110.016	0

I had expected to see improvements in build time - but
we serialize the heavy link phase, so it is actually slower.

I did not investigate why data section got larger,
but I think you already touch the reasons.

The patch does not change how we link modules.

Please consider if this approach is better / worse than
using archieves.

Note that this patch remove the possibility to run section
mismatch anylysis on a per-directory basis.

	Sam

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 11602e5..954e7cb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -360,10 +360,9 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 ifdef builtin-target
 quiet_cmd_link_o_target = LD      $@
 # If the list of objects to link is empty, just create an empty built-in.o
-cmd_link_o_target = $(if $(strip $(obj-y)),\
-		      $(LD) $(ld_flags) -r -o $@ $(filter $(obj-y), $^) \
-		      $(cmd_secanalysis),\
-		      rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@)
+cmd_link_o_target = $(if $(filter $(obj-y), $^),                   \
+                        echo INPUT\($(filter $(obj-y), $^)\) > $@, \
+                        echo "/* empty */" > $@)
 
 $(builtin-target): $(obj-y) FORCE
 	$(call if_changed,link_o_target)
@@ -414,10 +413,10 @@ $($(subst $(obj)/,,$(@:.o=-y)))       \
 $($(subst $(obj)/,,$(@:.o=-m)))), $^)
 
 quiet_cmd_link_multi-y = LD      $@
-cmd_link_multi-y = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
+cmd_link_multi-y = echo INPUT\($(link_multi_deps)\) > $@
 
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(cmd_link_multi-y)
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps)
 
 $(multi-used-y): FORCE
 	$(call if_changed,link_multi-y)
