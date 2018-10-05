Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E84C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 19:09:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005DB2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 19:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC+DJiEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005DB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RfT86Y5MzF3dC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 05:09:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CC+DJiEq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="CC+DJiEq"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RfMv02rvzF3dL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 05:05:14 +1000 (AEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F8192147C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538766312;
 bh=6k9069I+PGl0uims8OkanuL5u5WPHx3rohj/vmFAKwU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CC+DJiEqkNrviw+go2H2Une9sHnN7e+9mTvJgecOAvDYF+YfkPe0ddK1BbZir0zGO
 hnPl2o3gakr7/HuhdDmujo4DPI36dUx4ZYRhHc7gk6+f8OTxs9j/pJTD6IH3GdCEgj
 2jnNnskzA4wgPJx23uvR3xdR/qhQCHD0llf8gK/E=
Received: by mail-qt1-f172.google.com with SMTP id d14-v6so6329028qto.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 12:05:12 -0700 (PDT)
X-Gm-Message-State: ABuFfogH0Yp/IGPzEZ2/eMiTEgwtskS4obX0iXZvGfOqekjD28iaZ4Wu
 12EASPCS1+A4t4atgPk4LzOPP7NrCEtrJ9tQFQ==
X-Google-Smtp-Source: ACcGV60G+MYBSEmWjNyEjxIEeTO59tmZUsjEhbK9fDk1zKQt8Lh32DpxZYEezpu8NngygJCAOTtCMyahdCfptYt7ecA=
X-Received: by 2002:ac8:2ac9:: with SMTP id
 c9-v6mr10565192qta.188.1538766311677; 
 Fri, 05 Oct 2018 12:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
 <f39a84d3-f706-d31e-db22-4e3ebc72c447@gmail.com>
In-Reply-To: <f39a84d3-f706-d31e-db22-4e3ebc72c447@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 5 Oct 2018 14:04:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+53znm=LHxH8bZZJ2wN4uUez8D7E2V03+Zc9nvYBNjrg@mail.gmail.com>
Message-ID: <CAL_Jsq+53znm=LHxH8bZZJ2wN4uUez8D7E2V03+Zc9nvYBNjrg@mail.gmail.com>
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To: Frank Rowand <frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 5, 2018 at 1:53 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/05/18 08:07, Rob Herring wrote:
> > On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
> >>
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> If overlay properties #address-cells or #size-cells are already in
> >> the live devicetree for any given node, then the values in the
> >> overlay must match the values in the live tree.
> >>
> >> If the properties are already in the live tree then there is no
> >> need to create a changeset entry to add them since they must
> >> have the same value.  This reduces the memory used by the
> >> changeset and eliminates a possible memory leak.  This is
> >> verified by 12 fewer warnings during the devicetree unittest,
> >> as the possible memory leak warnings about #address-cells and
> >
> > and...?
>
> #size-cells no longer occur.
>
> (Thanks for catching that.)
>
>
> >>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 35 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >> index 29c33a5c533f..e6fb3ffe9d93 100644
> >> --- a/drivers/of/overlay.c
> >> +++ b/drivers/of/overlay.c
> >> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
> >>   * @target may be either in the live devicetree or in a new subtree that
> >>   * is contained in the changeset.
> >>   *
> >> - * Some special properties are not updated (no error returned).
> >> + * Some special properties are not added or updated (no error returned):
> >> + * "name", "phandle", "linux,phandle".
> >> + *
> >> + * Properties "#address-cells" and "#size-cells" are not updated if they
> >> + * are already in the live tree, but if present in the live tree, the values
> >> + * in the overlay must match the values in the live tree.
> >
> > Perhaps this should be generalized to apply to any property? We can't
> > really deal with property values changing on the fly anyways.
>
> That is a bigger discussion.  I'd prefer to not hold up this series for that
> question to be resolved.  It will be easy enough to generalize in an add-on
> patch later.

Fair enough.

> >> +               if (prop->length != 4 || new_prop->length != 4 ||
> >> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> >
> > Technically these are __be32 types. This could use a helper (of_prop_val_eq).
>
> These are in a unpacked form, so cpu byte order, not FDT byte order.

You sure about that? Unpacking doesn't change the order. It can't
because the type is unknown. The value of 'value' is the address of
the data in the FDT.

> > I'm not sure we really need to validate the length here as dtc does
> > that (but yes, not everything is from dtc).
>
> Since I'm accessing 4 bytes of the values, I need to be sure the lengths
> are at least 4.  For #address-cells and #size-cells the property is
> specified as four bytes, so I could simplify the code for the specific case.
>
> If this gets extended to any arbitrary property then a new of_prop_val_eq()
> would check that the lengths are equal and the values (of size length) are
> also equal.

Right, that's what I was thinking. Check lengths are equal and then
you can just do a memcmp().

Rob
