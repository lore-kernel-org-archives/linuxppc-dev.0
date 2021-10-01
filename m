Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E601CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Oct 2021 16:36:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD86610A3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Oct 2021 16:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BD86610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HLbMm40BVz3c5J
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Oct 2021 02:36:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V+Xg+U5n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=V+Xg+U5n; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HLbLx56KSz2yPR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Oct 2021 02:35:21 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA938610A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Oct 2021 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633106118;
 bh=nVW08TNUk03OPUkLLPVL11J+xOFZLhl1XXPfCDsxML0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=V+Xg+U5ndcyUb/3WDyMptVjyiilObg0CqSnEjRj3Y+trirRNQZIO9x/aQHmpchsEY
 718nz+4TRWo/M+EQbtNjZCVIKXfH1d821eR+S4ZFwFGKPmEue+zScfbOzNMiTbrH06
 uHP3cxFqoem4g4Y+5Oy8Fee7/zleIAuPWBJIAuVjDH9XYXKWJGFjlPu9zUtA0tHm+X
 1jILH8/pWaVDFdo9mX4RYmOGk/E5ddHAVgLgQseZaoKtKBPHKYGmotGUrPxVXsWzks
 YaTEbTdz8iOuPMwBZ9WbCO6lUNv6rsIBU31J6NhFWVJGXOSDIwZc3EUxNGt/enGO9y
 P3E8JkoIivGBg==
Received: by mail-ed1-f52.google.com with SMTP id g8so37042614edt.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Oct 2021 09:35:18 -0700 (PDT)
X-Gm-Message-State: AOAM530UN15O9zIo/QSEp7BYZpkz58J+yNzQNW0oqs4L+jw0xnC1nk9Z
 IA4i070KOpA9vQO7uLbryzkF6QVxmskG8bOnQw==
X-Google-Smtp-Source: ABdhPJzODcTe1gXJOefNR80freMbEX7WPVVHaY6R4BrgS/d3fO1+KRudSZl9TswU/WacJLi7Q/IWLZqZWEr+mcisi0Q=
X-Received: by 2002:a17:906:7217:: with SMTP id
 m23mr7160192ejk.466.1633106117370; 
 Fri, 01 Oct 2021 09:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com>
 <20211001000924.15421-2-leoyang.li@nxp.com>
 <1633094217.843390.3666440.nullmailer@robh.at.kernel.org>
 <CADRPPNQBR63pS60nmfUQx02GbBoWEbgroU5Zw-iY62TodmB91Q@mail.gmail.com>
In-Reply-To: <CADRPPNQBR63pS60nmfUQx02GbBoWEbgroU5Zw-iY62TodmB91Q@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Oct 2021 11:35:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_M2Y+CDfK95BmFJYxT2h4q8rd0BaHLk2Wth3u_U6YMQ@mail.gmail.com>
Message-ID: <CAL_JsqL_M2Y+CDfK95BmFJYxT2h4q8rd0BaHLk2Wth3u_U6YMQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml
 schema
To: Li Yang <leoyang.li@nxp.com>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 1, 2021 at 11:29 AM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Oct 1, 2021 at 8:18 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, 30 Sep 2021 19:09:20 -0500, Li Yang wrote:
> > > Convert the txt binding to yaml format and add description.  Drop the
> > > "simple-bus" compatible string from the example and not allowed by the
> > > binding any more.  This will help to enforce the correct probe order
> > > between parent device and child devices, but will require the ifc driver
> > > to probe the child devices to work properly.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > ---
> > > updates from previous submission:
> > > - Drop "simple-bus" from binding and only "fsl,ifc" as compatible
> > > - Fix one identiation problem of "reg"
> > > - Add type restriction to "little-endian" property
> > >
> > >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
> > >  .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
> > >  2 files changed, 137 insertions(+), 82 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/flash@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
> > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']
>
> These are defined in other bindings, but unfortunately they are not
> converted to yaml format yet.

Yes, I know. I'm trying to turn on this check by default and adding
more cases here doesn't help. And often, when those other bindings get
converted, it's the example here that has errors and has to get fixed.
So either convert those bindings too or drop them from the example.

Rob
