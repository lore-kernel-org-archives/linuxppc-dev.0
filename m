Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE0ECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:36:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9139E20645
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLTBrDE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9139E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b58m4s9tzF39J
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 08:36:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gLTBrDE7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gLTBrDE7"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b52P2MpTzF3Xp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 08:30:53 +1100 (AEDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E32C21480
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 21:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539811851;
 bh=gVFsSpOViZxfOZBiWzNi5iij/AfZ5RFRWMniX2R+AjI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gLTBrDE7wAxdXiqPCskT4ofCjkrUbbARlHrwm+0fgsw5l6GZ0sQr4MMRjepuxRqkn
 zWPvuqxngc79VxBiInJxoC8KrblWfRWjDOAl1ZnVFobTfaqyWXgy2FQVPAbH5vLdJ/
 /yKQwfEWvqcCx2eHionC5XPZUc7aCPdcczpKZltI=
Received: by mail-ed1-f42.google.com with SMTP id y19-v6so26287954edd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 14:30:50 -0700 (PDT)
X-Gm-Message-State: ABuFfoh+adJEyZ1ELvgXYXZPfcx1H00QbrCR+QiRdJxPrUXtAxatzQuY
 znq1zO4XYOe42ximNWamRLV3DGzWbzoj95BBlAk=
X-Google-Smtp-Source: ACcGV63doedhn36BPhBbwJmidEEgzPzPgXAOhtd1VlLYSgu6joT9yAyaZxDKYXlIC+W0FFeRkLIqROJoGQLkEX5eSow=
X-Received: by 2002:a50:8bd5:: with SMTP id
 n21-v6mr1674263edn.41.1539811849319; 
 Wed, 17 Oct 2018 14:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 17 Oct 2018 16:30:13 -0500
X-Gmail-Original-Message-ID: <CANk1AXS-DMhA3=8v9N28K_V6K18HcgN_Esuo=-ddmeBLO46-Rw@mail.gmail.com>
Message-ID: <CANk1AXS-DMhA3=8v9N28K_V6K18HcgN_Esuo=-ddmeBLO46-Rw@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
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

On Mon, Oct 15, 2018 at 9:39 PM <frowand.list@gmail.com> wrote:

Hi Frank,

>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Add checks:
>   - attempted kfree due to refcount reaching zero before overlay
>     is removed
>   - properties linked to an overlay node when the node is removed
>   - node refcount > one during node removal in a changeset destroy,
>     if the node was created by the changeset
>
> After applying this patch, several validation warnings will be
> reported from the devicetree unittest during boot due to
> pre-existing devicetree bugs. The warnings will be similar to:
>
>   OF: ERROR: of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest11/test-unittest111 contains unexpected properties
>   OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 expected refcount 1 instead of 2.  of_node_get() / of_node_put() are unbalanced for this node.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since v3:
>   - Add expected value of refcount for destroy cset entry error.  Also
>     explain the cause of the error.
>
>  drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
>  drivers/of/overlay.c |  1 +
>  include/linux/of.h   | 15 ++++++++++-----
>  3 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index f4f8ed9b5454..24c97b7a050f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
>         if (!of_node_check_flag(node, OF_DYNAMIC))
>                 return;
>
> +       if (of_node_check_flag(node, OF_OVERLAY)) {
> +
> +               if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
> +                       /* premature refcount of zero, do not free memory */
> +                       pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
> +                              __func__, node);
> +                       return;
> +               }
> +
> +               /*
> +                * If node->properties non-empty then properties were added
> +                * to this node either by different overlay that has not
> +                * yet been removed, or by a non-overlay mechanism.
> +                */
> +               if (node->properties)
> +                       pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
> +                              __func__, node);
> +       }
> +
>         property_list_free(node->properties);
>         property_list_free(node->deadprops);
>
> @@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
>
>  static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
>  {
> +       if (ce->action == OF_RECONFIG_ATTACH_NODE &&
> +           of_node_check_flag(ce->np, OF_OVERLAY)) {
> +               if (kref_read(&ce->np->kobj.kref) > 1) {
> +                       pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
> +                              ce->np, kref_read(&ce->np->kobj.kref));

Still testing as much as I have time to do.

I'm hitting this error message once when removing an overlay that adds
several child nodes.  The only node I get the message for was a node
that added a fixed-clock (the other nodes didn't trigger the error).
Then even if I edited all the rest of the overlay DTS and removed all
other child nodes and all references to the clock from other nodes, I
still got the error.

Removing dtbo: 1-socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb
[   72.032270] OF: ERROR: memory leak - destroy cset entry: attach
overlay node /soc/base_fpga_region/clk_0 expected refcount 1 instead
of 2.  of_node_get() / of_node_put() are unbalanced for this node.

Here's the very stripped down overlay:

/dts-v1/;
/plugin/;
/ {
        fragment@0 {
                target-path = "/soc/base_fpga_region";
                #address-cells = <1>;
                #size-cells = <1>;

                __overlay__ {
                        external-fpga-config;

                        #address-cells = <1>;
                        #size-cells = <1>;

                        clk_0: clk_0 {
                                compatible = "fixed-clock";
                                #clock-cells = <0>;
                                clock-frequency = <100000000>;  /* 100.00 MHz */
                                clock-output-names = "clk_0-clk";
                        };
                };
        };
};

I'll look at it some more tomorrow and try to figure out what's
special about this node.

Alan

> +               } else {
> +                       of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
> +               }
> +       }
> +
>         of_node_put(ce->np);
>         list_del(&ce->node);
>         kfree(ce);
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index eda57ef12fd0..1176cb4b6e4e 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>                         return -ENOMEM;
>
>                 tchild->parent = target_node;
> +               of_node_set_flag(tchild, OF_OVERLAY);
>
>                 ret = of_changeset_attach_node(&ovcs->cset, tchild);
>                 if (ret)
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..aa1dafaec6ae 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
>  extern struct device_node *of_stdout;
>  extern raw_spinlock_t devtree_lock;
>
> -/* flag descriptions (need to be visible even when !CONFIG_OF) */
> -#define OF_DYNAMIC     1 /* node and properties were allocated via kmalloc */
> -#define OF_DETACHED    2 /* node has been detached from the device tree */
> -#define OF_POPULATED   3 /* device already created for the node */
> -#define OF_POPULATED_BUS       4 /* of_platform_populate recursed to children of this node */
> +/*
> + * struct device_node flag descriptions
> + * (need to be visible even when !CONFIG_OF)
> + */
> +#define OF_DYNAMIC             1 /* (and properties) allocated via kmalloc */
> +#define OF_DETACHED            2 /* detached from the device tree */
> +#define OF_POPULATED           3 /* device already created */
> +#define OF_POPULATED_BUS       4 /* platform bus created for children */
> +#define OF_OVERLAY             5 /* allocated for an overlay */
> +#define OF_OVERLAY_FREE_CSET   6 /* in overlay cset being freed */
>
>  #define OF_BAD_ADDR    ((u64)-1)
>
> --
> Frank Rowand <frank.rowand@sony.com>
>
