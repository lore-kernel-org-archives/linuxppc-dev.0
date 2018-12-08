Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A90C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 04:50:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0D42082D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 04:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tkgfdYsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0D42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BcNL0Q7zzDsmQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 15:50:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="tkgfdYsj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="tkgfdYsj"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BcKZ44sqzDscR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 15:48:17 +1100 (AEDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id wB84lgwk007216
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Dec 2018 13:47:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wB84lgwk007216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544244463;
 bh=VB9bGHxvOCr5E7IqapZQRPhpA80nL13YyrwFsjP0H5A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tkgfdYsjt6ilS88JANsIoCMje1wXdXWZVUcq9ti13lU/oI4m/Evy26OqWQ/O7cbyW
 6lKfYik6ZKIfSG6Xyv9SGAxFd6IgoHhSP77kjS+ZnvxcscUfI1jsASGkRZOfY6hkpl
 IPrjH24KYqU80U7RV1u49D2l5mmLJ+964v1+y4lVDXkIPM8l1f/D6DrXnQL/iE2g/I
 ASNKv39H26d3i7ZD2szs0W0X61tywSQW/M13qxC6uP20w7F8Od0t23t1RGN2ftumeM
 U0rej+86KE7IJr663adAvevhwqRpaZZ+Xq0oR9U+897FAvQeCfKbZqjCmb8ulXBGP3
 7RPK+iWvw0H8g==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id o130so1415814vke.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 20:47:42 -0800 (PST)
X-Gm-Message-State: AA+aEWYUXUDqhUIz7Sf4+vw5eZKJpoL+viyVlXJBQRg93olRlYMpqE6p
 oQClAM8ytwCUayfoc8wsfjazi1FMX/KmjlcdfUo=
X-Google-Smtp-Source: AFSGD/UEzO2QbuCB7Z1lLud5pOTxf1yaKX9QJnznh9Dj+hCdKETu9rIE9yOOTaHdy04vuaiEhkTG2PJs+FVF+ZlsGzI=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr1987537vki.84.1544244461522; 
 Fri, 07 Dec 2018 20:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-2-robh@kernel.org>
In-Reply-To: <20181203213223.16986-2-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 8 Dec 2018 13:47:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgyL+Pq+SCkUUKnMny4nDw1L4zEevdzqbyGGAoE+BXUA@mail.gmail.com>
Message-ID: <CAK7LNARgyL+Pq+SCkUUKnMny4nDw1L4zEevdzqbyGGAoE+BXUA@mail.gmail.com>
Subject: Re: [PATCH v2 01/34] kbuild: Add support for DT binding schema checks
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
 kumar.gala@linaro.org, arm-soc <arm@kernel.org>, darknighte@darknighte.com,
 Jonathan Corbet <corbet@lwn.net>, Frank Rowand <frowand.list@gmail.com>,
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


On Tue, Dec 4, 2018 at 6:32 AM Rob Herring <robh@kernel.org> wrote:
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
>  .gitignore                                   |  1 +
>  Documentation/Makefile                       |  2 +-
>  Documentation/devicetree/bindings/.gitignore |  1 +
>  Documentation/devicetree/bindings/Makefile   | 33 ++++++++++++++++++++
>  Makefile                                     | 11 +++++--
>  scripts/Makefile.lib                         | 24 ++++++++++++--
>  6 files changed, 67 insertions(+), 5 deletions(-)
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
> index 000000000000..ee0110dd8131
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
> +      cmd_chk_binding = (set -e; \
> +                         $(DT_DOC_CHECKER) $< ; \
> +                         mkdir -p $(dir $@) ; \
> +                         $(DT_EXTRACT_EX) $< > $@ )
> +
> +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> +       $(call if_changed,chk_binding)
> +
> +DT_TMP_SCHEMA := .schema.yaml.tmp
> +extra-y += $(DT_TMP_SCHEMA)
> +
> +quiet_cmd_mk_schema = SCHEMA  $@
> +      cmd_mk_schema = mkdir -p $(obj); \
> +                      rm -f $@; \
> +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $<


I think '$<' is wrong.

'$<' is replaced with the first prerequisite.


You can easily check what is happening here.

$ cat   Documentation/devicetree/bindings/..schema.yaml.tmp.cmd
cmd_Documentation/devicetree/bindings/.schema.yaml.tmp := mkdir -p
Documentation/devicetree/bindings; rm -f
Documentation/devicetree/bindings/.schema.yaml.tmp; dt-mk-schema  -o
Documentation/devicetree/bindings/.schema.yaml.tmp
Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml


So, the dt-validater will check only binding from ti,davinci.yaml,
which is almost useless.



If I understand it correctly,
.schema.yaml.tmp should contain all binding yaml.


I fixed it up like follows:

diff --git a/Documentation/devicetree/bindings/Makefile
b/Documentation/devicetree/bindings/Makefile
index ee0110d..267458f 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -19,7 +19,7 @@ extra-y += $(DT_TMP_SCHEMA)
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = mkdir -p $(obj); \
                       rm -f $@; \
-                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $<
+                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@
$(filter-out FORCE, $^)

 DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))



Then, I see another error.


  SCHEMA  Documentation/devicetree/bindings/.schema.yaml.tmp
Traceback (most recent call last):
  File "/home/masahiro/ref/yaml-bindings/tools/dt-mk-schema", line 32,
in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not
args.useronly))
  File "/usr/local/lib/python3.5/dist-packages/dtschema-0.0.1-py3.5.egg/dtschema/lib.py",
line 359, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.5/dist-packages/dtschema-0.0.1-py3.5.egg/dtschema/lib.py",
line 314, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.5/dist-packages/dtschema-0.0.1-py3.5.egg/dtschema/lib.py",
line 80, in load_schema
    return yaml.load(f.read())
  File "/usr/lib/python3.5/codecs.py", line 321, in decode
    (result, consumed) = self._buffer_decode(data, self.errors, final)
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xd0 in position
0: invalid continuation byte
Documentation/devicetree/bindings/Makefile:33: recipe for target
'Documentation/devicetree/bindings/.schema.yaml.tmp' failed
make[1]: *** [Documentation/devicetree/bindings/.schema.yaml.tmp] Error 1
Makefile:1278: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2







BTW, I cannot build *.dt.yaml



  DTC     arch/arm/boot/dts/alpine-db.dt.yaml
FATAL ERROR: Unknown output format "yaml"
scripts/Makefile.lib:313: recipe for target
'arch/arm/boot/dts/alpine-db.dt.yaml' failed
make[1]: *** [arch/arm/boot/dts/alpine-db.dt.yaml] Error 1
make[1]: *** Deleting file 'arch/arm/boot/dts/alpine-db.dt.yaml'
Makefile:1262: recipe for target 'dtbs_check' failed




I use linux-next.


script/dtc/dtc does not understand '-O yaml'


I also tried the upstream DTC project with no success.


Where can I get dtc with yaml support?





-- 
Best Regards
Masahiro Yamada
