Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6458BC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:13:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63A521473
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63A521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yy3q4l6YzDqQG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 18:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yy2F1K3bzDq7N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 18:12:18 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id v10so12735405oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 00:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=af+iDysYGFwrA9DVKGh8trI5d2JTogfnCaNqTuD0aRk=;
 b=nHzOBbMjzl/JfXfEuVviu1LrZaLHG2tWw/Wnr08X+eT/QhJbkzynzp9mXw8EfH5Rx4
 g8v7005vayvhYgkYkifQ2RPzDrN7YZBI5ClKx+chJAkjGHN8ZtIcQ28vhB/95+mFas/g
 XM/RJQ88WKDIF9ihKo58l2JSmpAAbvjIhYDjgr7bzi+6e7KN7S1ULaFqo6V5FlWHtTY6
 UIgJMKPpfg8mmWBZOhlHtjUf3ZFe8NyQL0gGgDgYx7PL1T1wt2Mmdl9bqwvrn78LF88i
 BW6QkvKGTZjim29HgROhJriYsYnYR21UH7DnGkrxo+VZfzBUQcbFls532S/1iG54yCli
 4S1Q==
X-Gm-Message-State: APjAAAVjq0bOpIUCC908Jwc9ZY/zs/F0/AGeDJ2bq4if4XSBQ2AOnHDe
 QRqGehBYSp9x/OPSCC8ws67Is3y0iNvhBaWIpkb50nRk
X-Google-Smtp-Source: APXvYqyeoGClQERYVgaUm7UOmnKDldu0ZXylF0Ps1KwwfOoIpswLjjWI/elMx4ymkNffUMA8ahnTXqa3dymadtT9UaY=
X-Received: by 2002:aca:72c6:: with SMTP id p189mr721538oic.107.1554275536598; 
 Wed, 03 Apr 2019 00:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190403004926.6702-1-joel@jms.id.au>
In-Reply-To: <20190403004926.6702-1-joel@jms.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 3 Apr 2019 09:12:04 +0200
Message-ID: <CA+7wUsymTA6XO21KRdwD9Pouv1e8w6VUKSA2wbaPHN7Bz215rw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: config: skiroot: Add (back) MLX5 ethernet support
To: Joel Stanley <joel@jms.id.au>
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
Cc: Carol L Soto <clsoto@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 3, 2019 at 2:51 AM Joel Stanley <joel@jms.id.au> wrote:
>
> It turns out that some defconfig changes and kernel config option
> changes meant we accidentally dropped Ethernet support for Mellanox CLX5
> cards.
>
> Reported-by: Carol L Soto <clsoto@us.ibm.com>
> Suggested-by: Carol L Soto <clsoto@us.ibm.com>
> Signed-off-by: Stewart Smith <stewart@linux.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Fixes: cbc39809a398 ("powerpc/configs: Update skiroot defconfig")

?

> ---
>  arch/powerpc/configs/skiroot_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index 5ba131c30f6b..6038b9347d9e 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -163,6 +163,8 @@ CONFIG_S2IO=m
>  CONFIG_MLX4_EN=m
>  # CONFIG_MLX4_CORE_GEN2 is not set
>  CONFIG_MLX5_CORE=m
> +CONFIG_MLX5_CORE_EN=y
> +# CONFIG_MLX5_EN_RXNFC is not set
>  # CONFIG_NET_VENDOR_MICREL is not set
>  # CONFIG_NET_VENDOR_MICROSEMI is not set
>  CONFIG_MYRI10GE=m
> --
> 2.20.1
>
