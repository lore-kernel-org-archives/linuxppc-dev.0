Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B29C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 16:07:04 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A212D2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 16:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OPczIJ4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A212D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DlFK3sgfzDqdn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 03:07:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="OPczIJ4F";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="OPczIJ4F"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dl9l3rb2zDqcv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 03:03:54 +1100 (AEDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wBBG3ZdB021559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 01:03:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBBG3ZdB021559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544544216;
 bh=yybUklpXv+i3ZvDZN0IW/BOVhtWK4rILiidGaAjhMpM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OPczIJ4FOYy580LZ7DS/3nKvrqqoOMHIZIKWccecRRjdvtFhKfsasloqP+Dao9mEm
 yzIvnhZYIU23eLSWDkv5eknjQSTX81s+9ltfglUEI9fvClHdaKOOIV0hO2IbCPtae5
 cU9qNLWUULDw8JVFXwonarCPtCbPoaKBO6MB1qZxmij13lnLAV6E9ZPLkrDQlccFhG
 Nvs9c5jSADVSTLnT7pFwfBpGaFqq76gCdwKJ5HV/jPocJnHYkPkZ8QYjqAq0l478+r
 Q0qx8ITQFTQfN63dUPdk+p7cMblUVHzDlDv83AUwvUQbE3b0yFbwuVZGN8cnpvfj0R
 IO0sQl7AJbqKg==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id u19so5314195uae.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 08:03:35 -0800 (PST)
X-Gm-Message-State: AA+aEWb2WTnvaFqa3a8x8ARf5Gzajpke+qVJKMEL9eu9Pa+OwFBI8/1K
 oQVfcuds2jiABfCzPx0a0u7vYqEjy16MSfuYkts=
X-Google-Smtp-Source: AFSGD/XZc79/L4SuKcG1VJ0VKvjIawgbFQtNLlqIpxPcLm8VGbMkBdVTmt2/WSQVL+Vpd0inHxvZI+sz8UNKgKFxppM=
X-Received: by 2002:ab0:849:: with SMTP id b9mr3720525uaf.93.1544544214488;
 Tue, 11 Dec 2018 08:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20181210203225.11179-1-robh@kernel.org>
 <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
 <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
In-Reply-To: <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Dec 2018 01:02:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
Message-ID: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
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

On Wed, Dec 12, 2018 at 12:13 AM Rob Herring <robh@kernel.org> wrote:

>
> > > +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> > > +       $(call if_changed,chk_binding)
> > > +
> > > +DT_TMP_SCHEMA := .schema.yaml.tmp
> >
> >
> > BTW, why does this file start with a period?
> > What is the meaning of '.tmp' extension?
>
> Nothing really. Just named it something so it gets cleaned and ignored by git.


It is cleaned whatever file name you use.


See scripts/Makefile.clean

__clean-files   := $(extra-y) $(extra-m) $(extra-)       \
                   $(always) $(targets) $(clean-files)   \
                   $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
                   $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
                   $(hostcxxlibs-y) $(hostcxxlibs-m)


$(extra-y) is cleaned.



You are adding *.example.dts to .gitignore

Why not "schema.yaml" ?




> > > +extra-y += $(DT_TMP_SCHEMA)
> > > +
> > > +quiet_cmd_mk_schema = SCHEMA  $@
> > > +      cmd_mk_schema = mkdir -p $(obj); \
> > > +                      rm -f $@; \
> > > +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
> >
> >
> > "mkdir -p $(obj)" is redundant.
> >
> >
> > Why is 'rm -f $@' necessary ?
> > Can't dt-mk-schema overwrite the output file?
>
> It is for error case when the output file is not generated. I can
> handle this within dt-mk-schema instead.
> > > +DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
> > > +DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> > > +
> > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
> > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
> >
> >
> >
> > I assume you intentionally did not do like this:
> >
> > extra-y += $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))
> >
> > From the commit description, DT_SCHEMA_FILES might be overridden by a user.
> > So, I think this is OK.
> >
> >
> >
> >
> > > +$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
> >
> > I do not understand this line.
> > Why is it necessary?
> >
> > *.example.dtb files are generated anyway
> > since they are listed in extra-y.
>
> It is enforcing the ordering. Without it, the binding checks and
> building .schema.yaml.tmp happen in parallel because both only have
> the source files as dependencies. The '|' keeps the dependencies out
> of the dependency list($^).


What kind problem would you see if
the binding checks and building .schema.yaml.tmp
happen in parallel?



-- 
Best Regards
Masahiro Yamada
