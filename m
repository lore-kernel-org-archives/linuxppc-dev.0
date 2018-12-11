Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8162C67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:38:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3986E20855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWQ81JFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3986E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dpbp1JHHzDqWw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:38:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OWQ81JFK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OWQ81JFK"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DpXs5krCzDqdq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 05:35:41 +1100 (AEDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 921A920989
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544553339;
 bh=p8EYJ/W+tstdk9YOyWSoVKU0GF7Ar/LYqGAocqTKjN4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OWQ81JFKXZTiHWodKIjRr+PHBOP1poJulI2bqPwB6Dw9OgiKT9r5Bt9tJT9LED/ON
 qY6kCVSeQIrh7w35A/PMsdTz5nYfAaEsvglLfTQITTa4rdrM6DcR6z41Uvm9yEnPjh
 AwQ8ZkQpf4FXa0veSWmAmxFqskHCGIa1/xUXNrmE=
Received: by mail-qt1-f179.google.com with SMTP id l11so17609210qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 10:35:39 -0800 (PST)
X-Gm-Message-State: AA+aEWYwUgZfucdYtN/xjZwb9bvK0eUaUiKr6/TfE07Z8HzG7w0picCb
 KV+1LlHb3HXIUy9ItXR34cQK8vNyBnMiVqdngA==
X-Google-Smtp-Source: AFSGD/XseHpa+vQVxHR9GEAcS6cxLcCfOLfE/L6WOZfoUsMgmKGeQvPeV58OCxEJnc4x9BXpjTkrK4b0fW9kWb7Db+w=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr16930766qtj.76.1544553338724; 
 Tue, 11 Dec 2018 10:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20181210203225.11179-1-robh@kernel.org>
 <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
 <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
 <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
In-Reply-To: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Dec 2018 12:35:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_1RukAZx5tCpp+X8mdNuOT6LTAdYOzN5UyhRK6SAo2Q@mail.gmail.com>
Message-ID: <CAL_JsqJ_1RukAZx5tCpp+X8mdNuOT6LTAdYOzN5UyhRK6SAo2Q@mail.gmail.com>
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

On Tue, Dec 11, 2018 at 10:03 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Dec 12, 2018 at 12:13 AM Rob Herring <robh@kernel.org> wrote:
>
> >
> > > > +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> > > > +       $(call if_changed,chk_binding)
> > > > +
> > > > +DT_TMP_SCHEMA := .schema.yaml.tmp
> > >
> > >
> > > BTW, why does this file start with a period?
> > > What is the meaning of '.tmp' extension?
> >
> > Nothing really. Just named it something so it gets cleaned and ignored by git.
>
>
> It is cleaned whatever file name you use.
>
>
> See scripts/Makefile.clean
>
> __clean-files   := $(extra-y) $(extra-m) $(extra-)       \
>                    $(always) $(targets) $(clean-files)   \
>                    $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
>                    $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
>                    $(hostcxxlibs-y) $(hostcxxlibs-m)
>
>
> $(extra-y) is cleaned.

True.

>
>
> You are adding *.example.dts to .gitignore
>
> Why not "schema.yaml" ?

Okay. I'll do "processed-schema.yaml" to give a bit better name of
what it contains.

>
> > > > +extra-y += $(DT_TMP_SCHEMA)
> > > > +
> > > > +quiet_cmd_mk_schema = SCHEMA  $@
> > > > +      cmd_mk_schema = mkdir -p $(obj); \
> > > > +                      rm -f $@; \
> > > > +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
> > >
> > >
> > > "mkdir -p $(obj)" is redundant.
> > >
> > >
> > > Why is 'rm -f $@' necessary ?
> > > Can't dt-mk-schema overwrite the output file?
> >
> > It is for error case when the output file is not generated. I can
> > handle this within dt-mk-schema instead.
> > > > +DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
> > > > +DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> > > > +
> > > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
> > > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
> > >
> > >
> > >
> > > I assume you intentionally did not do like this:
> > >
> > > extra-y += $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))
> > >
> > > From the commit description, DT_SCHEMA_FILES might be overridden by a user.
> > > So, I think this is OK.
> > >
> > >
> > >
> > >
> > > > +$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
> > >
> > > I do not understand this line.
> > > Why is it necessary?
> > >
> > > *.example.dtb files are generated anyway
> > > since they are listed in extra-y.
> >
> > It is enforcing the ordering. Without it, the binding checks and
> > building .schema.yaml.tmp happen in parallel because both only have
> > the source files as dependencies. The '|' keeps the dependencies out
> > of the dependency list($^).
>
>
> What kind problem would you see if
> the binding checks and building .schema.yaml.tmp
> happen in parallel?

In case of no errors in the binding docs, it doesn't matter. If there
are errors, I don't want the dtbs validation to run if any schema
doesn't validate. However, I played around with this a bit more and it
seems like having the examples' dts/dtb in extra-y prevents that from
happening. Does that match your expections? If so, then I think we can
remove the dependency.

Here's an example.

  SCHEMA  Documentation/devicetree/bindings/.schema.yaml.tmp
  CHKDT   Documentation/devicetree/bindings/arm/vt8500.yaml
  CHKDT   Documentation/devicetree/bindings/arm/zte.yaml
  CHKDT   Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
  CHKDT   Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
  CHKDT   Documentation/devicetree/bindings/arm/ti/nspire.yaml
  CHKDT   Documentation/devicetree/bindings/arm/spear.yaml
  CHKDT   Documentation/devicetree/bindings/arm/altera.yaml
warning: no schema found in file:
../Documentation/devicetree/bindings/arm/xilinx.yaml
/home/rob/proj/git/linux-2.6/Documentation/devicetree/bindings/arm/xilinx.yaml:
ignoring, error in schema 'onOf'
  CHKDT   Documentation/devicetree/bindings/arm/sti.yaml
  CHKDT   Documentation/devicetree/bindings/arm/qcom.yaml
  CHKDT   Documentation/devicetree/bindings/arm/primecell.yaml
  CHKDT   Documentation/devicetree/bindings/arm/cpus.yaml
  CHKDT   Documentation/devicetree/bindings/arm/sirf.yaml
  CHKDT   Documentation/devicetree/bindings/arm/calxeda.yaml
  CHKDT   Documentation/devicetree/bindings/arm/xilinx.yaml
  CHKDT   Documentation/devicetree/bindings/example-schema.yaml
/home/rob/proj/git/linux-2.6/Documentation/devicetree/bindings/arm/xilinx.yaml:
properties:compatible:onOf: 'onOf' is not one of ['$ref',
'additionalItems', 'allOf', 'const', 'contains', 'default',
'dependencies', 'description', 'enum', 'items', 'minItems', 'minimum',
'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternProperties',
'properties', 'required', 'type', 'typeSize']
make[2]: *** [../Documentation/devicetree/bindings/Makefile:12:
Documentation/devicetree/bindings/arm/xilinx.example.dts] Error 1

Rob
