Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC0AC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 04:46:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCD421850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 04:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="GAZEHifM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCD421850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4490Q73m7pzDqMF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 15:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="GAZEHifM"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4490N247cxzDqKb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 15:45:03 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so9114689pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 20:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=t+aWm2f1Ovz5udXHw1QwvAiXhGl3Vs08iEXC3B/95X0=;
 b=GAZEHifMvPW56QkfM4k8OkBD9bEVYQklVMaZ9DwSBVd/jXLEZtYjGCUvXIJC+IkF10
 Fuvddc0NpuZJiaRt55M3eCtpMV6cntCeZeyVFZ8w9z8ppx2d04h8j6J0BxXSb93xwX0K
 d511kockwfcnfNy+lM+a/eIv/MuFM+ttgaepU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=t+aWm2f1Ovz5udXHw1QwvAiXhGl3Vs08iEXC3B/95X0=;
 b=taA9Oi79Q+PpA94XT9CDGpKt8FyeQYu5lqMoKdUlW8t0dmpQ0GEJyEtlT9FxNvfQr7
 bO7mLwB5/Dhn+lBlusebSxizgXnGnR3pNR2Xsj9BBTtArQpsdq6P8yl14RL/gH+1kPdI
 LM+CdiVC9FomPOlbzA09YxRjRKYlhIF7r3dZlz2ZD3JMBzjZQy+cRBo5pwTpiWy7kAyv
 W6bqVEM1PGJUMHjlevWsz54neHeIavQztV2Ze42Fk9pPgR3NJbrsJ5CxMsDCZN9lfglt
 VuWvktKEJO7lpFaiwIj2DZBJsq7cCKliOMtH1IG/kyfh+gsBV37tCgQpc8Rlr3o9tNuR
 2mqw==
X-Gm-Message-State: AHQUAubvZtz/+nmWwauPc1yj/0GF5oRmW2kp3q211ub7qfQEE1npYybN
 jeJ0xD6mFsNXJZKCE+GIhUJEug==
X-Google-Smtp-Source: AHgI3IbRlnKWycyhYRlqUK80rUcR6DI10bGA6BVDsHLEJlJNuYl127BSeczlmcG7I0qefrBrRkMaww==
X-Received: by 2002:a17:902:46a4:: with SMTP id
 p33mr6003800pld.48.1551329100554; 
 Wed, 27 Feb 2019 20:45:00 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
 by smtp.gmail.com with ESMTPSA id z67sm33216997pfi.152.2019.02.27.20.44.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 20:44:59 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH] powernv: powercap: Add hard minimum powercap
In-Reply-To: <1551260002-26792-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1551260002-26792-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 28 Feb 2019 15:44:56 +1100
Message-ID: <871s3s34jb.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:

> In POWER9, OCC(On-Chip-Controller) provides for hard and soft system
> powercapping range. The hard powercap range is guaranteed while soft
> powercap may or may not be asserted due to various power-thermal
> reasons based on system configuration and workloads. This patch adds
> a sysfs file to export the hard minimum powercap limit to allow the
> user to set the appropriate powercap value that can be managed by the
> system.

Maybe it's common terminology and I'm just not aware of it, but what do
you mean by "asserted"? It doesn't appear elsewhere in the documentation
you're patching, and it's not a use of assert that I'm familiar with...

Regards,
Daniel

>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  .../ABI/testing/sysfs-firmware-opal-powercap       | 10 ++++
>  arch/powerpc/platforms/powernv/opal-powercap.c     | 66 +++++++++-------------
>  2 files changed, 37 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-powercap b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> index c9b66ec..65db4c1 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> +++ b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> @@ -29,3 +29,13 @@ Description:	System powercap directory and attributes applicable for
>  		  creates a request for setting a new-powercap. The
>  		  powercap requested must be between powercap-min
>  		  and powercap-max.
> +
> +What:		/sys/firmware/opal/powercap/system-powercap/powercap-hard-min
> +Date:		Feb 2019
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	Hard minimum powercap
> +
> +		This file provides the hard minimum powercap limit in
> +		Watts. The powercap value above hard minimum is always
> +		guaranteed to be asserted and the powercap value below
> +		the hard minimum limit may or may not be guaranteed.
> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
> index d90ee4f..38408e7 100644
> --- a/arch/powerpc/platforms/powernv/opal-powercap.c
> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
> @@ -139,10 +139,24 @@ static void powercap_add_attr(int handle, const char *name,
>  	attr->handle = handle;
>  	sysfs_attr_init(&attr->attr.attr);
>  	attr->attr.attr.name = name;
> -	attr->attr.attr.mode = 0444;
> +
> +	if (!strncmp(name, "powercap-current", strlen(name))) {
> +		attr->attr.attr.mode = 0664;
> +		attr->attr.store = powercap_store;
> +	} else {
> +		attr->attr.attr.mode = 0444;
> +	}
> +
>  	attr->attr.show = powercap_show;
>  }
>  
> +static const char * const powercap_strs[] = {
> +	"powercap-max",
> +	"powercap-min",
> +	"powercap-current",
> +	"powercap-hard-min",
> +};
> +
>  void __init opal_powercap_init(void)
>  {
>  	struct device_node *powercap, *node;
> @@ -167,60 +181,34 @@ void __init opal_powercap_init(void)
>  
>  	i = 0;
>  	for_each_child_of_node(powercap, node) {
> -		u32 cur, min, max;
> -		int j = 0;
> -		bool has_cur = false, has_min = false, has_max = false;
> +		u32 id;
> +		int j, count = 0;
>  
> -		if (!of_property_read_u32(node, "powercap-min", &min)) {
> -			j++;
> -			has_min = true;
> -		}
> -
> -		if (!of_property_read_u32(node, "powercap-max", &max)) {
> -			j++;
> -			has_max = true;
> -		}
> +		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++)
> +			if (!of_property_read_u32(node, powercap_strs[j], &id))
> +				count++;
>  
> -		if (!of_property_read_u32(node, "powercap-current", &cur)) {
> -			j++;
> -			has_cur = true;
> -		}
> -
> -		pcaps[i].pattrs = kcalloc(j, sizeof(struct powercap_attr),
> +		pcaps[i].pattrs = kcalloc(count, sizeof(struct powercap_attr),
>  					  GFP_KERNEL);
>  		if (!pcaps[i].pattrs)
>  			goto out_pcaps_pattrs;
>  
> -		pcaps[i].pg.attrs = kcalloc(j + 1, sizeof(struct attribute *),
> +		pcaps[i].pg.attrs = kcalloc(count + 1,
> +					    sizeof(struct attribute *),
>  					    GFP_KERNEL);
>  		if (!pcaps[i].pg.attrs) {
>  			kfree(pcaps[i].pattrs);
>  			goto out_pcaps_pattrs;
>  		}
>  
> -		j = 0;
>  		pcaps[i].pg.name = kasprintf(GFP_KERNEL, "%pOFn", node);
> -		if (has_min) {
> -			powercap_add_attr(min, "powercap-min",
> -					  &pcaps[i].pattrs[j]);
> -			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> -			j++;
> -		}
> -
> -		if (has_max) {
> -			powercap_add_attr(max, "powercap-max",
> -					  &pcaps[i].pattrs[j]);
> -			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> -			j++;
> -		}
> +		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++) {
> +			if (of_property_read_u32(node, powercap_strs[j], &id))
> +				continue;
>  
> -		if (has_cur) {
> -			powercap_add_attr(cur, "powercap-current",
> +			powercap_add_attr(id, powercap_strs[j],
>  					  &pcaps[i].pattrs[j]);
> -			pcaps[i].pattrs[j].attr.attr.mode |= 0220;
> -			pcaps[i].pattrs[j].attr.store = powercap_store;
>  			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> -			j++;
>  		}
>  
>  		if (sysfs_create_group(powercap_kobj, &pcaps[i].pg)) {
> -- 
> 1.8.3.1
