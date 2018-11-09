Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B2C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:00:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F792086C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haO6jyPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F792086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rrdp2slNzDqSk
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:00:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="haO6jyPF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="haO6jyPF"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rrZf70VTzF3by
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:58:02 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id w3-v6so448673pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3TbiQjbBqhyV3CrR2oqAqSqqpJbmnaZTjUVEGGQj9j8=;
 b=haO6jyPFK/PPZueueZiXnXsZO+zSY7JFkAAqeKH/MJAC8WrpWsiFJJAYewwg199fU3
 BOH6DNlgb11rUHJwgLhrONbSVDlC0G2qAGF4jeDHoL8Vd6q5bGK73GMDr72JYur4Wnde
 oTgsZ29qpkBkc2OgFVQ8MVQDwOjtMvVPjf6Odp371XrnnWbAs8FZgRrANnfryN5GuxSa
 5A7QMtUdjj3Vrnps1Qn74+QT4Oam/2Ejh/JOzTqqlEE1dIZs2HmKX593oYAEx9TzFqnx
 2YFP0pp2FZeUxVKFNqGb8N2YtmWpQ/1v8sOwImLG6WSFHF5tXzxkavsLGW6F+6aTCYl4
 n8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3TbiQjbBqhyV3CrR2oqAqSqqpJbmnaZTjUVEGGQj9j8=;
 b=J94LPBvzFL0Zbwblw4Yb/VkMGAz66f8Lp1A29eEwS30gLB9JrE7OdTnxSHYVADtBb9
 ogC4X8IBhXslNYHUgGFzmKIZG7X2AZRt654mxT6ikTsGjXWWaAarMXhTCoEaQ5NnfGQm
 O/R2BpSLTmnH5niMaEc7r50L3HnHr+1OcpwAiEobCy82W6DpNVkvc6DvXBgfaB1NT5gU
 upg7JYKalJVFXEU9GNMWIX1w6SsmTkZ423evK9vTKAWWI5POl6+ZqfUcSNXLu0IzLwzY
 WTmZk2WGGRxw5cnTXQYPRxTMaheZrlEN4hKE8UNWyL9oFDXD1k0IwfQbyG8YA+k1PKYb
 +mdg==
X-Gm-Message-State: AGRZ1gKi6amCY3L3+ME1FPe0SHCaOyGSGjrVSpv8tsBL1Kp2VRydO3zJ
 vKrFF9xLKBhI9fFu546VklhwrYYv
X-Google-Smtp-Source: AJdET5dOUy2P5GJHQhoJ2dQWnwYjJc4NWPZBWtrGVhMpoNAMtgui/fTEXdvUhkPlR/X/yjGbNP5K0g==
X-Received: by 2002:a62:1d50:: with SMTP id
 d77-v6mr7583245pfd.87.1541746681317; 
 Thu, 08 Nov 2018 22:58:01 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id g7-v6sm6064507pfo.139.2018.11.08.22.57.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Nov 2018 22:58:00 -0800 (PST)
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
Message-ID: <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
Date: Thu, 8 Nov 2018 22:57:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-fpga@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/8/18 10:56 PM, Frank Rowand wrote:
> Hi Rob,
> 
> Please pull the changes to add the overlay validation checks.
> 
> This is the v7 version of the patch series.
> 
> -Frank
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git tags/kfree_validate_v7-for-4.20
> 
> for you to fetch changes up to eeb07c573ec307c53fe2f6ac6d8d11c261f64006:
> 
>   of: unittest: initialize args before calling of_*parse_*() (2018-11-08 22:12:37 -0800)
> 
> ----------------------------------------------------------------
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
> 
> The checks revealed bugs in existing code.  Fixed the bugs.
> 
> While fixing bugs, noted other issues, which are fixed in
> separate patches.
> 
> ----------------------------------------------------------------
> Frank Rowand (17):
>       of: overlay: add tests to validate kfrees from overlay removal
>       of: overlay: add missing of_node_put() after add new node to changeset
>       of: overlay: add missing of_node_get() in __of_attach_node_sysfs
>       powerpc/pseries: add of_node_put() in dlpar_detach_node()
>       of: overlay: use prop add changeset entry for property in new nodes
>       of: overlay: do not duplicate properties from overlay for new nodes
>       of: overlay: reorder fields in struct fragment
>       of: overlay: validate overlay properties #address-cells and #size-cells
>       of: overlay: make all pr_debug() and pr_err() messages unique
>       of: overlay: test case of two fragments adding same node
>       of: overlay: check prevents multiple fragments add or delete same node
>       of: overlay: check prevents multiple fragments touching same property
>       of: unittest: remove unused of_unittest_apply_overlay() argument
>       of: overlay: set node fields from properties when add new overlay node
>       of: unittest: allow base devicetree to have symbol metadata
>       of: unittest: find overlays[] entry by name instead of index
>       of: unittest: initialize args before calling of_*parse_*()
> 
>  arch/powerpc/platforms/pseries/dlpar.c             |   2 +
>  drivers/of/dynamic.c                               |  59 ++++-
>  drivers/of/kobj.c                                  |   4 +-
>  drivers/of/overlay.c                               | 292 ++++++++++++++++-----
>  drivers/of/unittest-data/Makefile                  |   2 +
>  .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
>  .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
>  drivers/of/unittest-data/overlay_base.dts          |   1 +
>  drivers/of/unittest.c                              |  96 +++++--
>  include/linux/of.h                                 |  21 +-
>  10 files changed, 432 insertions(+), 97 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> 

