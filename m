Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E65C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 19:04:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCA1208B3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 19:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c63NcWYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCA1208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ynt25bGxzF3MD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 06:04:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c63NcWYq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="c63NcWYq"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YnqR63BgzF38h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:01:55 +1100 (AEDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABFBB21479
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539630114;
 bh=HZTikMm58VpHYYjCoXzcMq7g8Vxcno1d4W4fqZ5OWo0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=c63NcWYqrFADrJk84i2f5NGXW5CFjvuqPg3BfCINay/kU+P7FUBPrxuLuZ4ZW4P22
 D7O2QLDinOgkRJiv78fDMC6bvPelOoGCkgcNotVQyVaLoQhEdOFW7TTF1lzyRpZpSD
 b0p3DVDtQOcsUc8O1DyUCtaz0xoibU+YPG8N/xD4=
Received: by mail-ed1-f51.google.com with SMTP id w19-v6so18892504eds.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 12:01:53 -0700 (PDT)
X-Gm-Message-State: ABuFfojGA/zdMtlkLz6HtVYjM7LQwPiwNRMaQXcGtL6Cyw8q7RlxD9PK
 EF9mrEEd9/zYMOe7nB42fmVvrCACFhxW8TsjlcM=
X-Google-Smtp-Source: ACcGV6146qI+cOqdKHB+Qj+knr8+y8I0gxkOYol7MAfdqtRpsbM+R8Vnd3PAXY2mg54pDeTtTxji2N+fBPOWsFBHtN8=
X-Received: by 2002:a17:906:7384:: with SMTP id
 f4-v6mr20302835ejl.8.1539630111956; 
 Mon, 15 Oct 2018 12:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-10-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1539563070-12969-10-git-send-email-frowand.list@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 15 Oct 2018 14:01:15 -0500
X-Gmail-Original-Message-ID: <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
Message-ID: <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] of: overlay: validate overlay properties
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

On Sun, Oct 14, 2018 at 7:26 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> If overlay properties #address-cells or #size-cells are already in
> the live devicetree for any given node, then the values in the
> overlay must match the values in the live tree.
>
> If the properties are already in the live tree then there is no
> need to create a changeset entry to add them since they must
> have the same value.  This reduces the memory used by the
> changeset and eliminates a possible memory leak.  This is
> verified by 12 fewer warnings during the devicetree unittest,
> as the possible memory leak warnings about #address-cells and
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 272a0d1a5e18..ee66651db553 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>   * @target may be either in the live devicetree or in a new subtree that
>   * is contained in the changeset.
>   *
> - * Some special properties are not updated (no error returned).
> + * Some special properties are not added or updated (no error returned):
> + * "name", "phandle", "linux,phandle".
> + *
> + * Properties "#address-cells" and "#size-cells" are not updated if they
> + * are already in the live tree, but if present in the live tree, the values
> + * in the overlay must match the values in the live tree.
>   *
>   * Update of property in symbols node is not allowed.
>   *
> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  {
>         struct property *new_prop = NULL, *prop;
>         int ret = 0;
> +       bool check_for_non_overlay_node = false;
>
>         if (!of_prop_cmp(overlay_prop->name, "name") ||
>             !of_prop_cmp(overlay_prop->name, "phandle") ||
> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>         if (!new_prop)
>                 return -ENOMEM;
>
> -       if (!prop)
> +       if (!prop) {
> +
> +               check_for_non_overlay_node = true;
>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>                                                 new_prop);
> -       else
> +
> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
> +

Hi Frank,

If we get these ERROR messages, I suggest that this function should
return an error so the overlay will be rejected.

> +               if (prop->length != 4 || new_prop->length != 4 ||
> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)

                        *(u32 *)prop->value != *(u32 *)new_prop->value) {

> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
> +                              target->np);

                       ret = -EINVAL;
                }

Otherwise there is an ERROR message, but it continues trying to apply
the invalid overlay anyway and I get an oops.  By adding the ret =
-EINVAL, the overlay gets rejected and the oops is avoided.

> +
> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
> +
> +               if (prop->length != 4 || new_prop->length != 4 ||
> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
> +                              target->np);

Add the ret = -EINVAL here also.  This give me the following (if my
overlay changes #address-cells):

[   21.167551] OF: overlay: ERROR: overlay and/or live tree
#address-cells invalid in node /soc/base_fpga_region
[   21.177442] OF: overlay: add_changeset_property ret=-22
[   21.182656] create_overlay: Failed to create overlay (err=-22)

Also, I wonder if the ERROR message could be more direct.  Currently
it says the #address-cells property is invalid but that doesn't say
anything about why it's invalid.  How about something like:

 OF: overlay: ERROR: changing #address-cells not allowed (/soc/base_fpga_region)

The 'OF: overlay' part still makes it clear it's overlay related.  The
rest of it makes it clear *why* it's invalid.  This ERROR will be a
surprise for people who have been using overlays, so that could be
helpful to light the way a bit.

Alan

> +
> +       } else {
> +
> +               check_for_non_overlay_node = true;
>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
>                                                    new_prop);
>
> +       }
> +
> +       if (check_for_non_overlay_node &&
> +           !of_node_check_flag(target->np, OF_OVERLAY))
> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
> +                      __func__, target->np, new_prop->name);
> +
>         if (ret) {
>                 kfree(new_prop->name);
>                 kfree(new_prop->value);
> --
> Frank Rowand <frank.rowand@sony.com>
>
