Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB358C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE0F21852
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yuKKblqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE0F21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K2S75XzZzDqTT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 02:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="yuKKblqC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="yuKKblqC"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K2Nn6ZpxzDqSD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 02:43:21 +1100 (AEDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E900B21852
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545147800;
 bh=m2DB6QqWu8SEUESKErQD/rr7f13p+Lqxt8lAYe2ja6Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=yuKKblqCgjQX95iSWznF6Mt5m86MeOqoVMzY+QICMc7Y9+4z22J83gW/ormQ7gdlY
 ocGCeHz6YipSoHAnQEHCv7jzBta7tlsEhXbz52KpyOvEmwxUQFzMhmBrh7yLMzwpiR
 BaMcen7mIv+Fn/3q0J4XU+1RgGvnturQl9n8/So4=
Received: by mail-qt1-f169.google.com with SMTP id n21so18633750qtl.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 07:43:19 -0800 (PST)
X-Gm-Message-State: AA+aEWb4/tFyqTdk4TBEFG8ae19kA/1c5T2Z/ao5fqcAlK71Tyj8MUWd
 dFl3czmwHJRWr5kVqACxTS2j0t5Btm8vAO+cPQ==
X-Google-Smtp-Source: AFSGD/V2hEjckYCxFUw27PJsHhsjEZMqOsEiophnQQNx600vkpI9LvKFo1eb75w7FOXBIPfsAt2nnwvz+nqiFMumJDA=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr18229770qts.144.1545147799172; 
 Tue, 18 Dec 2018 07:43:19 -0800 (PST)
MIME-Version: 1.0
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 18 Dec 2018 09:43:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZ=g16jZ_SZX2qi-ecE-hvQ+-UfUw40=+ztiM-Zpsq9A@mail.gmail.com>
Message-ID: <CAL_JsqKZ=g16jZ_SZX2qi-ecE-hvQ+-UfUw40=+ztiM-Zpsq9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: phandle_cache, fix refcounts,
 remove stale entry
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

On Mon, Dec 17, 2018 at 1:56 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  This bug exposed the foloowing
> phandle cache refcount bug.
>
> The refcount of phandle_cache entries is not incremented while in
> the cache, allowing use after free error after kfree() of the
> cached entry.
>
> Changes since v1:
>   - make __of_free_phandle_cache() static
>   - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
>
> Frank Rowand (2):
>   of: of_node_get()/of_node_put() nodes held in phandle cache
>   of: __of_detach_node() - remove node from phandle cache

I'll send this to Linus this week if I get a tested by. Otherwise, it
will go in for 4.21.

Rob
