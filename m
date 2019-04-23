Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E682BC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:55:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623FA218FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6a4jleN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623FA218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcgq61SrzDqW4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:55:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="G6a4jleN"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbfM51klzDqTW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 07:08:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vdJiYFNKoKyfpKh/sHwLi3OzHq3/SpHY3SiZoXQLSOo=; b=G6a4jleNomlkvu7eTiW0NpqxiO
 /ZBQDd1qzueVFNl1v/y5qc3zaNQ5vXizByhEQ6+sCOgk72t47SG/fLY9Ib9Lr1Wb98rzVR5YTr4Cy
 R+skOlk62aIQx2b8XLYg2CeyupDYpZEWXed/v0XfHS3Id5+jQ1u2bKqWeQUaw1In6VRIkQucDThx1
 X7SDQYApTQ+eLciLf3PyQdPPD/RaOsP4KMcvBCjLigmGI0p2zNJMciAlKvIfhvh5IJMVtEuEZjpgj
 TkUTto5qgswEezqaIPG+Sox6o6td747KLECfJ64HPWFEVB0rlzdqwZaSYbzK4E/zEj8aiTDZUWXGU
 m3+KaGNg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2ep-0003j0-BE; Tue, 23 Apr 2019 21:08:51 +0000
Date: Tue, 23 Apr 2019 18:08:45 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 11/63] Documentation: ACPI: move dsdt-override.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190423180845.603542d5@coco.lan>
In-Reply-To: <20190423162932.21428-12-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-12-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:28:40 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsdt-override.rst}                               | 8 +++++++-
>  Documentation/admin-guide/acpi/index.rst                  | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>  rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
> 
> diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/admin-guide/acpi/dsdt-override.rst
> similarity index 56%
> rename from Documentation/acpi/dsdt-override.txt
> rename to Documentation/admin-guide/acpi/dsdt-override.rst
> index 784841caa6e6..50bd7f194bf4 100644
> --- a/Documentation/acpi/dsdt-override.txt
> +++ b/Documentation/admin-guide/acpi/dsdt-override.rst
> @@ -1,6 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Overriding DSDT
> +===============
> +
>  Linux supports a method of overriding the BIOS DSDT:
>  
> -CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
> +CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
>  
>  When to use this method is described in detail on the
>  Linux/ACPI home page:
> diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> index 09e4e81e4fb7..d68e9914c5ff 100644
> --- a/Documentation/admin-guide/acpi/index.rst
> +++ b/Documentation/admin-guide/acpi/index.rst
> @@ -9,3 +9,4 @@ the Linux ACPI support.
>     :maxdepth: 1
>  
>     initrd_table_override
> +   dsdt-override



Thanks,
Mauro
