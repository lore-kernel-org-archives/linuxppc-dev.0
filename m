Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323D1C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:42:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D50620811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Y0HKxL3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D50620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DS325qNrzDqpf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="Y0HKxL3A";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="Y0HKxL3A"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DS0D111yzDqn1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 15:39:39 +1100 (AEDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id wBB4d3PQ001372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 13:39:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wBB4d3PQ001372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544503144;
 bh=Oood8TAfVHUh/TERJE8Q4Ksf5SJWTHtrCaWvyC4Mju8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Y0HKxL3AnARq5Mj2gyJpZZ6sQrKP6ZAgmjNbwPLaIMEF4bKHgWUDPnt3ulxxZoVSe
 mSlb+/iQNf8A4HAq1EXJd5yHuOEnsGZ8KJRahw2uAOL3kgPgUx72wOz5QLWh/NUuFv
 0p0oPMI61kAE7TMOrsPAY0CPK1vTOyRrItjb8oBZLAskzLfA3nx0Q5mpvmu6HE9ZiD
 ofQk0LWIDm3m1qJ95/yb8pspspuJinJcJD5pDvVcWBzqYTOh6+F/BsKe1sZ6g5YC2c
 9t9Ukq5KAehLglzo5H6z7FyIrXTIKWAgPgla781nOgPBGWGCHskM93Zfqro0Rma1r4
 MTz1oT9FiF/0A==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id v205so8128437vsc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 20:39:04 -0800 (PST)
X-Gm-Message-State: AA+aEWaHgLui3ABkBQgDJvSMvJOIRw/rAZPk/33clkHzrGQY8YQ+svHF
 lpDcb2QXT3jYmFjKutlYx2uAFtU1X6xXNHevlGU=
X-Google-Smtp-Source: AFSGD/WSCxoASVkdjL9j1CKQvTKRwFY3nYisnYvF2RHWQfsjn1uHbVVxpY3tjniQHMF/s702uLv6NKca+Msq9AIZWt4=
X-Received: by 2002:a67:a858:: with SMTP id r85mr6427130vse.215.1544503142862; 
 Mon, 10 Dec 2018 20:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20181210203225.11179-1-robh@kernel.org>
In-Reply-To: <20181210203225.11179-1-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 11 Dec 2018 13:38:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
Message-ID: <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
 darknighte@darknighte.com, Jonathan Corbet <corbet@lwn.net>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, grant.likely@arm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

On Tue, Dec 11, 2018 at 5:50 AM Rob Herring <robh@kernel.org> wrote:
>
> This adds the build infrastructure for checking DT binding schema
> documents and validating dts files using the binding schema.
>
> Check DT binding schema documents:
> make dt_binding_check
>
> Build dts files and check using DT binding schema:
> make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can passed in with a schema file(s) to use


Perhaps, "can be passed" ?



> for validation. This makes it easier to find and fix errors generated by
> a specific schema.
>
> Currently, the validation targets are separate from a normal build to
> avoid a hard dependency on the external DT schema project and because
> there are lots of warnings generated.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-doc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
> - Fix error causing only 1st schema file to get used.
> - Add a more useful error message when dtc is missing YAML support
> telling the user they need to install libyaml devel package.
>
>
>  .gitignore                                   |  1 +
>  Documentation/Makefile                       |  2 +-
>  Documentation/devicetree/bindings/.gitignore |  1 +
>  Documentation/devicetree/bindings/Makefile   | 33 +++++++++++++++++
>  Makefile                                     | 11 ++++--
>  scripts/Makefile.lib                         | 37 ++++++++++++++++++--
>  6 files changed, 80 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/.gitignore
>  create mode 100644 Documentation/devicetree/bindings/Makefile
>
> diff --git a/.gitignore b/.gitignore
> index 97ba6b79834c..a20ac26aa2f5 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -15,6 +15,7 @@
>  *.bin
>  *.bz2
>  *.c.[012]*.*
> +*.dt.yaml
>  *.dtb
>  *.dtb.S
>  *.dwo
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2ca77ad0f238..9786957c6a35 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Sphinx documentation
>  #
>
> -subdir-y :=
> +subdir-y := devicetree/bindings/
>
>  # You can set these variables from the command line.
>  SPHINXBUILD   = sphinx-build
> diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
> new file mode 100644
> index 000000000000..d9194c02dd08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/.gitignore
> @@ -0,0 +1 @@
> +*.example.dts
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> new file mode 100644
> index 000000000000..43f8657ab070
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +DT_DOC_CHECKER ?= dt-doc-validate
> +DT_EXTRACT_EX ?= dt-extract-example
> +DT_MK_SCHEMA ?= dt-mk-schema
> +DT_MK_SCHEMA_FLAGS := $(if $(DT_SCHEMA_FILES), -u)
> +
> +quiet_cmd_chk_binding = CHKDT   $<


In convention, the short log displays the target name
instead of the prerequisite.

If O=foo/bar is given, $< shows the full path,
then log will look like follows:


  CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/calxeda.yaml
  DTC     Documentation/devicetree/bindings/arm/calxeda.example.dtb
  CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/qcom.yaml
  DTC     Documentation/devicetree/bindings/arm/qcom.example.dtb
  CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/xilinx.yaml
  DTC     Documentation/devicetree/bindings/arm/xilinx.example.dtb
  CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/ti/nspire.yaml
  DTC     Documentation/devicetree/bindings/arm/ti/nspire.example.dtb
  CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
  DTC     Documentation/devicetree/bindings/arm/ti/ti,davinci.example.dtb
  CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/altera.yaml

You might think it is ugly.




> +      cmd_chk_binding = (set -e; \
> +                         $(DT_DOC_CHECKER) $< ; \
> +                         mkdir -p $(dir $@) ; \
> +                         $(DT_EXTRACT_EX) $< > $@ )


- 'set -e' is redundant because if_changed already has it.

- 'mkdir mkdir -p $(dir $@)' is also redundant because
   scripts/Makefile.build automatically creates it.

-  You do not need to execute this in a sub-shell



You can simplify like this:

       cmd_chk_binding = $(DT_DOC_CHECKER) $< ; \
                         $(DT_EXTRACT_EX) $< > $@



> +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> +       $(call if_changed,chk_binding)
> +
> +DT_TMP_SCHEMA := .schema.yaml.tmp


BTW, why does this file start with a period?
What is the meaning of '.tmp' extension?



> +extra-y += $(DT_TMP_SCHEMA)
> +
> +quiet_cmd_mk_schema = SCHEMA  $@
> +      cmd_mk_schema = mkdir -p $(obj); \
> +                      rm -f $@; \
> +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)


"mkdir -p $(obj)" is redundant.


Why is 'rm -f $@' necessary ?
Can't dt-mk-schema overwrite the output file?




> +DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
> +DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> +
> +extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
> +extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))



I assume you intentionally did not do like this:

extra-y += $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))

From the commit description, DT_SCHEMA_FILES might be overridden by a user.
So, I think this is OK.




> +$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))

I do not understand this line.
Why is it necessary?

*.example.dtb files are generated anyway
since they are listed in extra-y.




> +$(obj)/$(DT_TMP_SCHEMA): $(addprefix $(srctree)/, $(DT_SCHEMA_FILES)) FORCE
> +       $(call if_changed,mk_schema)


You do not need to prefix $(srctree)/ because Kbuild uses VPATH.


$(obj)/$(DT_TMP_SCHEMA): $(DT_SCHEMA_FILES) FORCE
       $(call if_changed,mk_schema)


is fine.







> +cmd_dtc_yaml_chk = \
> +       if ! echo "/dts-v1/; /{};" | $(DTC) -I dts -O yaml > /dev/null ; then \
> +               echo "*"; \
> +               echo "* dtc needs libyaml for DT schema validation support."; \
> +               echo "* Install the necessary libyaml development package from your distro."; \
> +               echo "*"; \
> +               false; \
> +       fi; \
> +       touch $@
> +
> +$(objtree)/scripts/dtc/.dtc-yaml-chk.tmp: $(DTC) FORCE
> +       $(call if_changed,dtc_yaml_chk)


Hmm, this is kind of ugly.

I'd rather check this in scripts/dtc/Makefile



How about something like below?



diff --git a/Makefile b/Makefile
index ff59adf..a3e2db2 100644
--- a/Makefile
+++ b/Makefile
@@ -1233,11 +1233,11 @@ ifneq ($(dtstree),)
        $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@

 PHONY += dtbs dtbs_install dt_binding_check
-dtbs: prepare3 scripts_dtc
+dtbs dtbs_check: prepare3 scripts_dtc
        $(Q)$(MAKE) $(build)=$(dtstree)

-dtbs_check: prepare3 dt_binding_check
-       $(Q)$(MAKE) $(build)=$(dtstree) CHECK_DTBS=1
+dtbs_check: export CHECK_DTBS=1
+dtbs_check: dt_binding_check

 dtbs_install:
        $(Q)$(MAKE) $(dtbinst)=$(dtstree)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8a7d622..5017175 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -309,20 +309,7 @@ define rule_dtc_dt_yaml
        $(call echo-cmd,dtb_check) $(cmd_dtb_check)
 endef

-cmd_dtc_yaml_chk = \
-       if ! echo "/dts-v1/; /{};" | $(DTC) -I dts -O yaml > /dev/null ; then \
-               echo "*"; \
-               echo "* dtc needs libyaml for DT schema validation support."; \
-               echo "* Install the necessary libyaml development
package from your distro."; \
-               echo "*"; \
-               false; \
-       fi; \
-       touch $@
-
-$(objtree)/scripts/dtc/.dtc-yaml-chk.tmp: $(DTC) FORCE
-       $(call if_changed,dtc_yaml_chk)
-
-$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE |
$(objtree)/scripts/dtc/.dtc-yaml-chk.tmp
+$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
        $(call if_changed_rule,dtc_dt_yaml)

 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 056d5da..3e497f1 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -12,6 +12,10 @@ dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
 HOST_EXTRACFLAGS := -I$(src)/libfdt

 ifeq ($(wildcard /usr/include/yaml.h),)
+ifeq ($(CHECK_DTBS),1)
+$(error dtc needs libyaml for DT schema validation support. \
+        Install the necessary libyaml development package.)
+endif
 HOST_EXTRACFLAGS += -DNO_YAML
 else
 dtc-objs       += yamltree.o





One drawback of this approach is,
this is not checked if you are using out-of-tree DTC.
Probably, Rob is the only person that overrides DTC.







-- 
Best Regards
Masahiro Yamada
