Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF28C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:22:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C7B206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk6cGvAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GcnK0vNhzDrLX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 04:22:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jk6cGvAJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jk6cGvAJ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GckS1Kn0zDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 04:20:16 +1100 (AEDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 666F02070D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544808015;
 bh=17sy1cCSStd8lhmEga2NxAz/c3m4ocZS/i17ebqa7EI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Jk6cGvAJQfQI+e/4LlEK4od6zBgkjqbm5UFGv0N5bvovzk+KTl4Dj4GBs52uekfWe
 soGUWcGiXcYUDyDQ/LNnBkBzLhWjVs5HiiULZYln89R1KkmMBRJYTc3wMhqlLsx04Y
 psPtTrPdXUTwrFuKL8ouAPkCE1gvMRWUlb0gWk7I=
Received: by mail-qt1-f171.google.com with SMTP id n32so6959781qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 09:20:14 -0800 (PST)
X-Gm-Message-State: AA+aEWYc+SwKGpqvf8ystUgcrInJ+hD0HtYSGAqwO9unA0qzmpveM/T5
 hsDQp7jPuE64mgrKviz/PIKtjYHKeNYEnBzyzQ==
X-Google-Smtp-Source: AFSGD/XcBa+uXBQytzMAAiU37puwUAWqVcy0X6GwO7dnsYCY+S7wER+oum3HKdq97bkWJJPzKOLXlrWGxM0gOJFFvVE=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr3646677qve.246.1544808013572; 
 Fri, 14 Dec 2018 09:20:13 -0800 (PST)
MIME-Version: 1.0
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 14 Dec 2018 11:20:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
Message-ID: <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: __of_detach_node() - remove node from phandle
 cache
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  Remove the node from the
> cache.
>
> Add paranoia checks in of_find_node_by_phandle() as a second level
> of defense (do not return cached node if detached, do not add node
> to cache if detached).
>
> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/base.c       | 29 ++++++++++++++++++++++++++++-
>  drivers/of/dynamic.c    |  3 +++
>  drivers/of/of_private.h |  4 ++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d599367cb92a..34a5125713c8 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
>  late_initcall_sync(of_free_phandle_cache);
>  #endif
>
> +/*
> + * Caller must hold devtree_lock.
> + */
> +void __of_free_phandle_cache_entry(phandle handle)
> +{
> +       phandle masked_handle;
> +
> +       if (!handle)
> +               return;
> +
> +       masked_handle = handle & phandle_cache_mask;
> +
> +       if (phandle_cache) {
> +               if (phandle_cache[masked_handle] &&
> +                   handle == phandle_cache[masked_handle]->phandle) {
> +                       of_node_put(phandle_cache[masked_handle]);
> +                       phandle_cache[masked_handle] = NULL;
> +               }
> +       }
> +}
> +
>  void of_populate_phandle_cache(void)
>  {
>         unsigned long flags;
> @@ -1209,11 +1230,17 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>                 if (phandle_cache[masked_handle] &&
>                     handle == phandle_cache[masked_handle]->phandle)
>                         np = phandle_cache[masked_handle];
> +               if (np && of_node_check_flag(np, OF_DETACHED)) {
> +                       of_node_put(np);
> +                       phandle_cache[masked_handle] = NULL;

This should never happen, right? Any time we set OF_DETACHED, the
entry should get removed from the cache. I think we want a WARN here
in case we're in an unexpected state.

Rob
