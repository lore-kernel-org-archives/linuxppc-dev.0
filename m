Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A09C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:38:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317BA20851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317BA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437yz71nGNzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:38:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrY22pKzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:29 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id t204so12342416oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7EpOZvqiCsR+9JpM0lO49UA9keAvCjxXYgZJ9W+uvqQ=;
 b=d4ArROV+XTW4ey9nSH6q2xBxbeyLWGw31qyaM8SuyEtLWNnpMDYsjNMXPeVJUg+6OJ
 IlX/ayNHelTsnV0rxyV8Sv7wkdH/8L2lakJFhOl9T0OJLm/RBpoWuAMMQcQIIjwM7czM
 MhHSXj+sm0bOe7UeCOqKOj4OFytbqfM1Rp6hnWdXt2sPJLXyuQZgkTn2+iNywHYQl6qg
 kASuMFH8Mh3oXRzMjHnUm3aq66BSpcGWYQP/IMQrCjJBrDLVkVdXQ6lKq44NCNBPs5en
 J5VRgm+TksuYkq/70M6DMsiI260Zr8aUIxEmz2z7he5VquiWW4ArFv7cvxdKzgfCqW+v
 e/qQ==
X-Gm-Message-State: AA+aEWYlGyHq1BDR57hYsqBQFiq4gIjVccrCAfhOFALJ+eEDP71Hjo22
 tBYoXtxGPdrYcprGyg29SA==
X-Google-Smtp-Source: AFSGD/Xa3bqIgHi7emij+183Fy1u3j4lDkl11nzvHDis/8up1RGFIVphqGtJWv9uAgwQIR0YChi9JA==
X-Received: by 2002:a05:6808:159:: with SMTP id
 h25mr7801309oie.285.1543872747087; 
 Mon, 03 Dec 2018 13:32:27 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:26 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/34] kbuild: Add support for DT binding schema checks
Date: Mon,  3 Dec 2018 15:31:50 -0600
Message-Id: <20181203213223.16986-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Jonathan Corbet <corbet@lwn.net>, Frank Rowand <frowand.list@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <grant.likely@arm.com>, Michal Marek <michal.lkml@markovi.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds the build infrastructure for checking DT binding schema
documents and validating dts files using the binding schema.

Check DT binding schema documents:
make dt_binding_check

Build dts files and check using DT binding schema:
make dtbs_check

Optionally, DT_SCHEMA_FILES can passed in with a schema file(s) to use
for validation. This makes it easier to find and fix errors generated by
a specific schema.

Currently, the validation targets are separate from a normal build to
avoid a hard dependency on the external DT schema project and because
there are lots of warnings generated.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .gitignore                                   |  1 +
 Documentation/Makefile                       |  2 +-
 Documentation/devicetree/bindings/.gitignore |  1 +
 Documentation/devicetree/bindings/Makefile   | 33 ++++++++++++++++++++
 Makefile                                     | 11 +++++--
 scripts/Makefile.lib                         | 24 ++++++++++++--
 6 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/.gitignore
 create mode 100644 Documentation/devicetree/bindings/Makefile

diff --git a/.gitignore b/.gitignore
index 97ba6b79834c..a20ac26aa2f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@
 *.bin
 *.bz2
 *.c.[012]*.*
+*.dt.yaml
 *.dtb
 *.dtb.S
 *.dwo
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ca77ad0f238..9786957c6a35 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Sphinx documentation
 #
 
-subdir-y :=
+subdir-y := devicetree/bindings/
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
new file mode 100644
index 000000000000..d9194c02dd08
--- /dev/null
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -0,0 +1 @@
+*.example.dts
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
new file mode 100644
index 000000000000..ee0110dd8131
--- /dev/null
+++ b/Documentation/devicetree/bindings/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+DT_DOC_CHECKER ?= dt-doc-validate
+DT_EXTRACT_EX ?= dt-extract-example
+DT_MK_SCHEMA ?= dt-mk-schema
+DT_MK_SCHEMA_FLAGS := $(if $(DT_SCHEMA_FILES), -u)
+
+quiet_cmd_chk_binding = CHKDT   $<
+      cmd_chk_binding = (set -e; \
+                         $(DT_DOC_CHECKER) $< ; \
+                         mkdir -p $(dir $@) ; \
+                         $(DT_EXTRACT_EX) $< > $@ )
+
+$(obj)/%.example.dts: $(src)/%.yaml FORCE
+	$(call if_changed,chk_binding)
+
+DT_TMP_SCHEMA := .schema.yaml.tmp
+extra-y += $(DT_TMP_SCHEMA)
+
+quiet_cmd_mk_schema = SCHEMA  $@
+      cmd_mk_schema = mkdir -p $(obj); \
+                      rm -f $@; \
+                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $<
+
+DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
+DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
+
+extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
+extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
+
+$(obj)/$(DT_TMP_SCHEMA): $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
+
+$(obj)/$(DT_TMP_SCHEMA): $(addprefix $(srctree)/, $(DT_SCHEMA_FILES)) FORCE
+	$(call if_changed,mk_schema)
diff --git a/Makefile b/Makefile
index 2f36db897895..ff59adf43300 100644
--- a/Makefile
+++ b/Makefile
@@ -1232,10 +1232,13 @@ ifneq ($(dtstree),)
 %.dtb: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install
+PHONY += dtbs dtbs_install dt_binding_check
 dtbs: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+dtbs_check: prepare3 dt_binding_check
+	$(Q)$(MAKE) $(build)=$(dtstree) CHECK_DTBS=1
+
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
 
@@ -1249,6 +1252,9 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
+
 # ---------------------------------------------------------------------------
 # Modules
 
@@ -1611,7 +1617,8 @@ clean: $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
-		-o -name '*.ko.*' -o -name '*.dtb' -o -name '*.dtb.S' \
+		-o -name '*.ko.*' \
+		-o -name '*.dtb' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su'  \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468f9bda..d1c5630ba24c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -61,6 +61,11 @@ real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))
 extra-y				+= $(dtb-y)
 extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
 
+ifneq ($(CHECK_DTBS),)
+extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
+extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
+endif
+
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
@@ -284,13 +289,28 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(DTC) -O dtb -o $@ -b 0 \
+	$(DTC) -O $(2) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtc)
+	$(call if_changed_dep,dtc,dtb)
+
+DT_CHECKER ?= dt-validate
+DT_BINDING_DIR := Documentation/devicetree/bindings
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/.schema.yaml.tmp
+
+quiet_cmd_dtb_check =	CHECK  $@
+      cmd_dtb_check =	$(DT_CHECKER) -p $(DT_TMP_SCHEMA) $@ ;
+
+define rule_dtc_dt_yaml
+	$(call cmd_and_fixdep,dtc,yaml)		\
+	$(call echo-cmd,dtb_check) $(cmd_dtb_check)
+endef
+
+$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_rule,dtc_dt_yaml)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
-- 
2.19.1

