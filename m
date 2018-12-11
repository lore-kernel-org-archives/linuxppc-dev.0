Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665CC5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 15:14:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6642081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKhCOW2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6642081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dk590RMrzDqnc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 02:14:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DKhCOW2N";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DKhCOW2N"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dk2Q4BKSzDqjN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 02:12:30 +1100 (AEDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53B0620855
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544541148;
 bh=8rdO4cZxt6xReUlC0rdEaykJNgyVG46s2ZIBuuHkODI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DKhCOW2N+zbs4bqGinIj4uROtK12ZWwT5ga5lJWjMhUqsUzIKsMl42n21R9mCeXqt
 mued0cG8TsdiT1DRQNHLHQByFIFebeW0eS/dOvVbu0iD3wzcNqgHBr22cKg+jqchSl
 7vPMose8YidGuHGyYuvHkR/3Owr3/UjE1KOXPwu0=
Received: by mail-qk1-f178.google.com with SMTP id 189so8752358qkj.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 07:12:28 -0800 (PST)
X-Gm-Message-State: AA+aEWabVAu2+SJ/MzY3Zxo722yEENu4V/FCTwtCkHljb2YIES1h/9Py
 jJUM/ljZPyUChczkMGyCcaIjnfNjZn/e2PkGbQ==
X-Google-Smtp-Source: AFSGD/V3f26Ch4DAfmZuZLq2FicXTg6QAR2pNTWHGlCMwtI3VbwyQWvG5J7FwQTDt18OKG/uBw9e9YtJ5itSx2oBQnI=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr15157892qkg.147.1544541147417; 
 Tue, 11 Dec 2018 07:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20181210203225.11179-1-robh@kernel.org>
 <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
In-Reply-To: <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Dec 2018 09:12:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
Message-ID: <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add support for DT binding schema checks
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Jonathan Corbet <corbet@lwn.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 10, 2018 at 10:39 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
> On Tue, Dec 11, 2018 at 5:50 AM Rob Herring <robh@kernel.org> wrote:
> >
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dts files using the binding schema.
> >
> > Check DT binding schema documents:
> > make dt_binding_check
> >
> > Build dts files and check using DT binding schema:
> > make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can passed in with a schema file(s) to use
>
>
> Perhaps, "can be passed" ?

Yes.

[...]

> > +quiet_cmd_chk_binding = CHKDT   $<
>
>
> In convention, the short log displays the target name
> instead of the prerequisite.

Yes, but here there is no target. We're just running a check on the source.


> If O=foo/bar is given, $< shows the full path,
> then log will look like follows:
>
>
>   CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/calxeda.yaml
>   DTC     Documentation/devicetree/bindings/arm/calxeda.example.dtb
>   CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/qcom.yaml
>   DTC     Documentation/devicetree/bindings/arm/qcom.example.dtb
>   CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/xilinx.yaml
>   DTC     Documentation/devicetree/bindings/arm/xilinx.example.dtb
>   CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/ti/nspire.yaml
>   DTC     Documentation/devicetree/bindings/arm/ti/nspire.example.dtb
>   CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
>   DTC     Documentation/devicetree/bindings/arm/ti/ti,davinci.example.dtb
>   CHKDT   /home/masahiro/ref/linux-devicetree/Documentation/devicetree/bindings/arm/altera.yaml
>
> You might think it is ugly.

I've changed it to this:

quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)

[...]

> > +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> > +       $(call if_changed,chk_binding)
> > +
> > +DT_TMP_SCHEMA := .schema.yaml.tmp
>
>
> BTW, why does this file start with a period?
> What is the meaning of '.tmp' extension?

Nothing really. Just named it something so it gets cleaned and ignored by git.

> > +extra-y += $(DT_TMP_SCHEMA)
> > +
> > +quiet_cmd_mk_schema = SCHEMA  $@
> > +      cmd_mk_schema = mkdir -p $(obj); \
> > +                      rm -f $@; \
> > +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
>
>
> "mkdir -p $(obj)" is redundant.
>
>
> Why is 'rm -f $@' necessary ?
> Can't dt-mk-schema overwrite the output file?

It is for error case when the output file is not generated. I can
handle this within dt-mk-schema instead.

> > +DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
> > +DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> > +
> > +extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
> > +extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
>
>
>
> I assume you intentionally did not do like this:
>
> extra-y += $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))
>
> From the commit description, DT_SCHEMA_FILES might be overridden by a user.
> So, I think this is OK.
>
>
>
>
> > +$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
>
> I do not understand this line.
> Why is it necessary?
>
> *.example.dtb files are generated anyway
> since they are listed in extra-y.

It is enforcing the ordering. Without it, the binding checks and
building .schema.yaml.tmp happen in parallel because both only have
the source files as dependencies. The '|' keeps the dependencies out
of the dependency list($^).

[...]

> > +cmd_dtc_yaml_chk = \
> > +       if ! echo "/dts-v1/; /{};" | $(DTC) -I dts -O yaml > /dev/null ; then \
> > +               echo "*"; \
> > +               echo "* dtc needs libyaml for DT schema validation support."; \
> > +               echo "* Install the necessary libyaml development package from your distro."; \
> > +               echo "*"; \
> > +               false; \
> > +       fi; \
> > +       touch $@
> > +
> > +$(objtree)/scripts/dtc/.dtc-yaml-chk.tmp: $(DTC) FORCE
> > +       $(call if_changed,dtc_yaml_chk)
>
>
> Hmm, this is kind of ugly.
>
> I'd rather check this in scripts/dtc/Makefile
>
>
>
> How about something like below?

Looks good.

>  ifeq ($(wildcard /usr/include/yaml.h),)
> +ifeq ($(CHECK_DTBS),1)

I'm going to change this to "ifneq ($CHECK_DTBS),)" in case we start
supporting more than 1 value such as warning levels.

> +$(error dtc needs libyaml for DT schema validation support. \
> +        Install the necessary libyaml development package.)
> +endif
>  HOST_EXTRACFLAGS += -DNO_YAML
>  else
>  dtc-objs       += yamltree.o
>
>
>
>
>
> One drawback of this approach is,
> this is not checked if you are using out-of-tree DTC.
> Probably, Rob is the only person that overrides DTC.

Sadly, that's probably true.

Thanks for your thorough review.

Rob
