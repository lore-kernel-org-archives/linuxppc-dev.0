Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C2C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 17:04:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3900521476
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 17:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3900521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bb504MrZzF3HK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:04:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bb2z6vT9zF3Hc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 04:03:07 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id x4so29065559otg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 10:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cETW7hbTpVAjv5VCuBz0OkmilWTcZUemT5Kzp8m8Bq8=;
 b=BqnDzXWvwi/NykqtGoA0e8vW23biJNzvJ1fFuqNl26V5Df5xQG416yOLpYziIYus6Z
 mdFo9DOJcZhhk52vnTI47CpQHNNp+jf8T45N/Fej3t+1pvcGRjRz2/FvmKaLRVTF/CyB
 L16KgD+vMU5OuC0cEIZkS2x9fsDB4SSht2oknF2vzAWHpt7SvJQzUf0Y8vIpzxQB0oMe
 VLtOCeKM4tqJQvE7KpiKMOkc2uDMyS5kFBds5HZYh6CgA0kuqCi0IYUE3w2Gv46HbeAJ
 EZaLdoHlFWlLNx321VuOaAN8LqNWU4y1qG2LSgPh5xhQt7ryli2hXKMNeXpYFuyBbbOt
 yA/Q==
X-Gm-Message-State: ABuFfogFB0bv9XOXuiy6IkJmdWG3SRn4cA27lHKupgFMYTJmMlPWL1Vq
 kSqfkvwDAKxhA00bYN4kCA==
X-Google-Smtp-Source: ACcGV63HVBX6F1IcWwcrKaQRnKvwZWcBLPpimTQ8OzIUZxxJVHPjutSTC5afwQMV7f5Q9peed6p0rw==
X-Received: by 2002:a9d:3cbd:: with SMTP id z58mr20537878otc.159.1539882185222; 
 Thu, 18 Oct 2018 10:03:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u107sm3866233otb.71.2018.10.18.10.03.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Oct 2018 10:03:04 -0700 (PDT)
Date: Thu, 18 Oct 2018 12:03:03 -0500
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Subject: Re: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
Message-ID: <20181018170303.GA15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 07:37:21PM -0700, frowand.list@gmail.com wrote:
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

These messages could be formatted more consistently. Put the path either 
at the beginning (after any prefix) or end. Beginning is more like a 
compiler error. End puts what the problem is before it's off the edge of 
the screen. 

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
>  	if (!of_node_check_flag(node, OF_DYNAMIC))
>  		return;
>  
> +	if (of_node_check_flag(node, OF_OVERLAY)) {
> +
> +		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {

I worry the flags are getting unwieldy.

> +			/* premature refcount of zero, do not free memory */
> +			pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
> +			       __func__, node);
> +			return;
> +		}
> +
> +		/*
> +		 * If node->properties non-empty then properties were added
> +		 * to this node either by different overlay that has not
> +		 * yet been removed, or by a non-overlay mechanism.
> +		 */
> +		if (node->properties)
> +			pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
> +			       __func__, node);
> +	}
> +
>  	property_list_free(node->properties);
>  	property_list_free(node->deadprops);
>  
> @@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
>  
>  static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
>  {
> +	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
> +	    of_node_check_flag(ce->np, OF_OVERLAY)) {
> +		if (kref_read(&ce->np->kobj.kref) > 1) {
> +			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
> +			       ce->np, kref_read(&ce->np->kobj.kref));
> +		} else {
> +			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
> +		}
> +	}
> +
>  	of_node_put(ce->np);
>  	list_del(&ce->node);
>  	kfree(ce);
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index eda57ef12fd0..1176cb4b6e4e 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>  			return -ENOMEM;
>  
>  		tchild->parent = target_node;
> +		of_node_set_flag(tchild, OF_OVERLAY);
>  
>  		ret = of_changeset_attach_node(&ovcs->cset, tchild);
>  		if (ret)
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..aa1dafaec6ae 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
>  extern struct device_node *of_stdout;
>  extern raw_spinlock_t devtree_lock;
>  
> -/* flag descriptions (need to be visible even when !CONFIG_OF) */
> -#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
> -#define OF_DETACHED	2 /* node has been detached from the device tree */
> -#define OF_POPULATED	3 /* device already created for the node */
> -#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
> +/*
> + * struct device_node flag descriptions
> + * (need to be visible even when !CONFIG_OF)
> + */
> +#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
> +#define OF_DETACHED		2 /* detached from the device tree */
> +#define OF_POPULATED		3 /* device already created */
> +#define OF_POPULATED_BUS	4 /* platform bus created for children */
> +#define OF_OVERLAY		5 /* allocated for an overlay */
> +#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
>  
>  #define OF_BAD_ADDR	((u64)-1)
>  
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
