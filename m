Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED9EC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34D720645
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y5Ffomd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34D720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TTwC4gCQzF3F3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:51:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="y5Ffomd+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="y5Ffomd+"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TTqh12XxzF3Bd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 05:47:12 +1100 (AEDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23655214FE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539024430;
 bh=FQ1+NFEIQx7zQORwnZtOKLLT2wTpOxHUv3M95cb+kPA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=y5Ffomd+KlQgPz75uI3IIqS5CM/6SrYqkTHlJoaU2cp1QzLYgjFVF9/3wBECfPQ27
 6GdLHt+aYZt7+P6e84Z5V5gyQSaNjlqfgi/Cq7lp5ppG8LD3fzDHQlv2uHFyZSLgGA
 4bkht3A3t3NcOSIynezE8UOZCDos+fRJLL2UNsE0=
Received: by mail-ed1-f41.google.com with SMTP id b7-v6so11921158edd.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 11:47:10 -0700 (PDT)
X-Gm-Message-State: ABuFfoin51AtWNB7J860/hWhNb/yUUnYqgZovyIpwq624VhtvsCzxb2d
 ThIsVX6btUtWcBDdJV74f1g4ruymJ+vAZbqeIuo=
X-Google-Smtp-Source: ACcGV602UGSqxjOFjZjD6Ayly2eHh1Cm74lOkBBpEwLHE+50+6Nv2ql59x/Q/OfXX+VA333UGOYRZiPLsBTqfF8bCg4=
X-Received: by 2002:a17:906:32d9:: with SMTP id
 k25-v6mr24852369ejk.211.1539024428448; 
 Mon, 08 Oct 2018 11:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CANk1AXQFTfdwy9n+WH2k98w6oyqLj3wLDRfaMmtTGk66sJjqUw@mail.gmail.com>
In-Reply-To: <CANk1AXQFTfdwy9n+WH2k98w6oyqLj3wLDRfaMmtTGk66sJjqUw@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 8 Oct 2018 13:46:31 -0500
X-Gmail-Original-Message-ID: <CANk1AXRi90nFNTji+7RVPC-hb9NFX5+gJo6OpCKvyuVx8eX3Fw@mail.gmail.com>
Message-ID: <CANk1AXRi90nFNTji+7RVPC-hb9NFX5+gJo6OpCKvyuVx8eX3Fw@mail.gmail.com>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 10:57 AM Alan Tull <atull@kernel.org> wrote:
>
> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
> >
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> > If overlay properties #address-cells or #size-cells are already in
> > the live devicetree for any given node, then the values in the
> > overlay must match the values in the live tree.
>
> Hi Frank,
>
> I'm starting some FPGA testing on this patchset applied to v4.19-rc7.
> That applied cleanly; if that's not the best base to test against,
> please let me know.
>
> On a very simple overlay, I'm seeing this patch's warning catching
> things other than #address-cells or #size-cells.

What it's warning about are new properties being added to an existing
node.  So !prop is true and !of_node_check_flag(target->np,
OF_OVERLAY) also is true.  Is that a potential memory leak as you are
warning?  If so, your code is working as planned and you'll just need
to document that also in the header.

> I'm just getting
> started looking at this, will spend time understanding this better and
> I'll test other overlays.  The warnings were:
>
> Applying dtbo: socfpga_overlay.dtb
> [   33.117881] fpga_manager fpga0: writing soc_system.rbf to Altera
> SOCFPGA FPGA Manager
> [   33.575223] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base-fpga-region/firmware-name
> [   33.588584] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base-fpga-region/fpga-bridges
> [   33.601856] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base-fpga-region/ranges
>
> Here's part of that overlay including the properties it's complaining about:
>
> /dts-v1/;
> /plugin/;
> / {
>         fragment@0 {
>                 target = <&base_fpga_region>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 __overlay__ {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>
>                         firmware-name = "soc_system.rbf";
>                         fpga-bridges = <&fpga_bridge1>;
>                         ranges = <0x20000 0xff200000 0x100000>,
>                         <0x0 0xc0000000 0x20000000>;
>
>                         gpio@10040 {
> so on...
>
> By the way, I didn't get any warnings when I subsequently removed this overlay.
>
> Alan
>
> >
> > If the properties are already in the live tree then there is no
> > need to create a changeset entry to add them since they must
> > have the same value.  This reduces the memory used by the
> > changeset and eliminates a possible memory leak.  This is
> > verified by 12 fewer warnings during the devicetree unittest,
> > as the possible memory leak warnings about #address-cells and
> >
> > Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> > ---
> >  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index 29c33a5c533f..e6fb3ffe9d93 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
> >   * @target may be either in the live devicetree or in a new subtree that
> >   * is contained in the changeset.
> >   *
> > - * Some special properties are not updated (no error returned).
> > + * Some special properties are not added or updated (no error returned):
> > + * "name", "phandle", "linux,phandle".
> > + *
> > + * Properties "#address-cells" and "#size-cells" are not updated if they
> > + * are already in the live tree, but if present in the live tree, the values
> > + * in the overlay must match the values in the live tree.
> >   *
> >   * Update of property in symbols node is not allowed.
> >   *
> > @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >  {
> >         struct property *new_prop = NULL, *prop;
> >         int ret = 0;
> > +       bool check_for_non_overlay_node = false;
> >
> >         if (!of_prop_cmp(overlay_prop->name, "name") ||
> >             !of_prop_cmp(overlay_prop->name, "phandle") ||
> > @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >         if (!new_prop)
> >                 return -ENOMEM;
> >
> > -       if (!prop)
> > +       if (!prop) {
> > +
> > +               check_for_non_overlay_node = true;
> >                 ret = of_changeset_add_property(&ovcs->cset, target->np,
> >                                                 new_prop);
> > -       else
> > +
> > +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
> > +
> > +               if (prop->length != 4 || new_prop->length != 4 ||
> > +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> > +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
> > +                              target->np);
> > +
> > +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
> > +
> > +               if (prop->length != 4 || new_prop->length != 4 ||
> > +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> > +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
> > +                              target->np);
> > +
> > +       } else {
> > +
> > +               check_for_non_overlay_node = true;
> >                 ret = of_changeset_update_property(&ovcs->cset, target->np,
> >                                                    new_prop);
> >
> > +       }
> > +
> > +       if (check_for_non_overlay_node &&
> > +           !of_node_check_flag(target->np, OF_OVERLAY))
> > +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
> > +                      __func__, target->np, new_prop->name);
> > +
> >         if (ret) {
> >                 kfree(new_prop->name);
> >                 kfree(new_prop->value);
> > --
> > Frank Rowand <frank.rowand@sony.com>
> >
