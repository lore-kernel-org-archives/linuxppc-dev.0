Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC25C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 10:07:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BC520657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q+WMSljV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BC520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gKW4621zzDqpL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 21:07:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.78; helo=conuserg-11.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="q+WMSljV"; 
 dkim-atps=neutral
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gKT70Wk3zDqng
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 21:05:30 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id x0HA38Gs009525;
 Thu, 17 Jan 2019 19:03:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0HA38Gs009525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547719391;
 bh=uCbD1NfqujoHfNDZGzPP15V6qMGvWE1LwqUSGy/cdrU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q+WMSljVwSbbUNvetGMOyIpBMNZil8tXGaZIghXUAFcOvzAYtt2eObZt9OHQw+EsB
 VT9HrMRyw6g63duXILjG1mKDgq4fpgl7WAT8lo5hXojP6VWw5VEn6h+9a8DgEAWkOr
 dCZxB+yBv+1dYL+BbKusReRxctJzlVQShc8vrLRAX2YzdQcr/wd6wCVGj+Id8wUkJ0
 /hYoPQbh5sDapigvEMpqz9bGv1m04i5vi91v24AX1sDuyhiyopo8i6tAOWzlNXVoea
 vCw6MHmNSVtEr2bEvsgcsWwQuInqKc29A9sIs2RvzIaWtWkMBpnXljjQGVMFBLouVQ
 8BAb374SJhAnw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH v2 3/4] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
Date: Thu, 17 Jan 2019 19:02:43 +0900
Message-Id: <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 James Hogan <jhogan@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>,
 linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In Kbuild, if_changed and friends must have FORCE as a prerequisite.

Hence, $(filter-out FORCE,$^) or $(filter-out $(PHONY),$^) is a common
pattern to get the names of all the prerequisites except phony targets.

Add real-prereqs as a shorthand.

Note:
We cannot replace $(filter %.o,$^) in cmd_link_multi-m because $^ may
include auto-generated dependencies from the .*.cmd file when a single
object module is changed into a multi object module. Refer to commit
69ea912fda74 ("kbuild: remove unneeded link_multi_deps"). I added some
comment to avoid accidental breakage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The patch context depends on some other ones.
Please use 'git am -C1' if you want to test this
on Linus' tree.


Changes in v2:
  - clean up arch/s390/boot/Makefile as well

 Documentation/devicetree/bindings/Makefile |  2 +-
 arch/mips/boot/Makefile                    |  2 +-
 arch/powerpc/boot/Makefile                 |  2 +-
 arch/s390/boot/Makefile                    |  2 +-
 arch/x86/realmode/rm/Makefile              |  3 +--
 scripts/Kbuild.include                     |  4 ++++
 scripts/Makefile.build                     |  9 ++++++---
 scripts/Makefile.lib                       | 18 +++++++++---------
 scripts/Makefile.modpost                   |  2 +-
 9 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 6e5cef0..e4eb5d1 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -15,7 +15,7 @@ DT_TMP_SCHEMA := processed-schema.yaml
 extra-y += $(DT_TMP_SCHEMA)
 
 quiet_cmd_mk_schema = SCHEMA  $@
-      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
+      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
 
 DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 35704c2..3ce4dd5 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -115,7 +115,7 @@ endif
 targets += vmlinux.its.S
 
 quiet_cmd_its_cat = CAT     $@
-      cmd_its_cat = cat $(filter-out $(PHONY), $^) >$@
+      cmd_its_cat = cat $(real-prereqs) >$@
 
 $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
 	$(call if_changed,its_cat)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0e8dadd..73d1f35 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -218,7 +218,7 @@ quiet_cmd_bootas = BOOTAS  $@
       cmd_bootas = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootar = BOOTAR  $@
-      cmd_bootar = $(BOOTAR) $(BOOTARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
+      cmd_bootar = $(BOOTAR) $(BOOTARFLAGS) $@.$$$$ $(real-prereqs); mv $@.$$$$ $@
 
 $(obj-libfdt): $(obj)/%.o: $(srctree)/scripts/dtc/libfdt/%.c FORCE
 	$(call if_changed_dep,bootcc)
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index b4d8a42..11ca879 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -58,7 +58,7 @@ $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 quiet_cmd_ar = AR      $@
-      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(filter $(OBJECTS), $^)
+      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(obj)/startup.a: $(OBJECTS) FORCE
 	$(call if_changed,ar)
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 4463fa7..394377c 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -37,8 +37,7 @@ REALMODE_OBJS = $(addprefix $(obj)/,$(realmode-y))
 sed-pasyms := -n -r -e 's/^([0-9a-fA-F]+) [ABCDGRSTVW] (.+)$$/pa_\2 = \2;/p'
 
 quiet_cmd_pasyms = PASYMS  $@
-      cmd_pasyms = $(NM) $(filter-out FORCE,$^) | \
-		   sed $(sed-pasyms) | sort | uniq > $@
+      cmd_pasyms = $(NM) $(real-prereqs) | sed $(sed-pasyms) | sort | uniq > $@
 
 targets += pasyms.h
 $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3081603..d93250b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -24,6 +24,10 @@ depfile = $(subst $(comma),_,$(dot-target).d)
 basetarget = $(basename $(notdir $@))
 
 ###
+# real prerequisites without phony targets
+real-prereqs = $(filter-out $(PHONY), $^)
+
+###
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 681ab58..9800178 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -399,8 +399,7 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 ifdef builtin-target
 
 quiet_cmd_ar_builtin = AR      $@
-      cmd_ar_builtin = rm -f $@; \
-                     $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(filter $(real-obj-y), $^)
+      cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(builtin-target): $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
@@ -428,7 +427,7 @@ ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
 
 # lib target archives do get a symbol table and index
-cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(lib-y)
+cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
@@ -453,6 +452,10 @@ targets += $(obj)/lib-ksyms.o
 
 endif
 
+# NOTE:
+# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
+# module is turned into a multi object module, $^ will contain header file
+# dependencies recorded in the .*.cmd file.
 quiet_cmd_link_multi-m = LD [M]  $@
 cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ebaa348..c6fc295 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -231,7 +231,7 @@ $(obj)/%: $(src)/%_shipped
 # ---------------------------------------------------------------------------
 
 quiet_cmd_ld = LD      $@
-cmd_ld = $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
+      cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
 
 # Objcopy
 # ---------------------------------------------------------------------------
@@ -243,7 +243,7 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------
 
 quiet_cmd_gzip = GZIP    $@
-      cmd_gzip = cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@
+      cmd_gzip = cat $(real-prereqs) | gzip -n -f -9 > $@
 
 # DTC
 # ---------------------------------------------------------------------------
@@ -321,7 +321,7 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 # append the size as a 32-bit littleendian number as gzip does.
 size_append = printf $(shell						\
 dec_size=0;								\
-for F in $(filter-out FORCE,$^); do					\
+for F in $(real-prereqs); do					\
 	fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);	\
 	dec_size=$$(expr $$dec_size + $$fsize);				\
 done;									\
@@ -335,19 +335,19 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-      cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
+      cmd_bzip2 = (cat $(real-prereqs) | bzip2 -9 && $(size_append)) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-      cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
+      cmd_lzma = (cat $(real-prereqs) | lzma -9 && $(size_append)) > $@
 
 quiet_cmd_lzo = LZO     $@
-      cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
+      cmd_lzo = (cat $(real-prereqs) | lzop -9 && $(size_append)) > $@
 
 quiet_cmd_lz4 = LZ4     $@
-      cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
+      cmd_lz4 = (cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
                   $(size_append)) > $@
 
 # U-Boot mkimage
@@ -390,11 +390,11 @@ quiet_cmd_uimage = UIMAGE  $@
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-cmd_xzkern = (cat $(filter-out FORCE,$^) | \
+      cmd_xzkern = (cat $(real-prereqs) | \
 	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
-cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
+      cmd_xzmisc = (cat $(real-prereqs) | \
 	xz --check=crc32 --lzma2=dict=1MiB) > $@
 
 # ASM offsets
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 7d4af0d0..c0b7f52 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -122,7 +122,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =                                                     \
 	$(LD) -r $(KBUILD_LDFLAGS)                                      \
                  $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
-                 -o $@ $(filter-out FORCE,$^) ;                         \
+                 -o $@ $(real-prereqs) ;                                \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 $(modules): %.ko :%.o %.mod.o FORCE
-- 
2.7.4

