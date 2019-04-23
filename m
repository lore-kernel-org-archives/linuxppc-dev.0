Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613AC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:47:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5F2218D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CTck0YaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5F2218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcVc52hszDqQm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:47:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="CTck0YaL"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbGS4hsbzDqSH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 06:51:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=botNWw+S6WKNaF5EjthcNKSjg632PnN3Uy2HYxc3wPA=; b=CTck0YaL1r+YPoCW5SnYRwPRZE
 EdhdJ4h/X6url55E0KWe1cVQLTAu3hjJymDbKezivT1iJx1mi2krfCklOaECgEJs9IzXktpo8Ppqv
 U5/EZsfQqI0bYvLjJEsG0tppCM+HDeCRtB2514IRwFYM5UYOZgpR9lsMUakxETPGK0VMfUyVBnEqC
 9zzY1NG73hRfHVIJLvudBqPj65PI+dAtaxo3ZWcKU1Nmmzrh9XCMA0Kg2V0rPbNGJlR59GliXkzby
 MGjeNyj9V0iujQJ2x1/2oCaKXFicCvf2zgWjk+wp4Ck5QbPwEVCnQyCPW/SexpZYIhX5UrEPczC1t
 gZet/2oQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2O8-0002uX-2K; Tue, 23 Apr 2019 20:51:36 +0000
Date: Tue, 23 Apr 2019 17:51:29 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 06/63] Documentation: ACPI: move scan_handlers.txt to
 driver-api/acpi and convert to reST
Message-ID: <20190423175129.03f74a4b@coco.lan>
In-Reply-To: <20190423162932.21428-7-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-7-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:35 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/driver-api/acpi/index.rst       |  1 +
>  .../acpi/scan_handlers.rst}                   | 24 ++++++++++++-------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>  rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)
> 
> diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
> index 12649947b19b..ace0008e54c2 100644
> --- a/Documentation/driver-api/acpi/index.rst
> +++ b/Documentation/driver-api/acpi/index.rst
> @@ -6,3 +6,4 @@ ACPI Support
>     :maxdepth: 2
>  
>     linuxized-acpica
> +   scan_handlers
> diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/driver-api/acpi/scan_handlers.rst
> similarity index 90%
> rename from Documentation/acpi/scan_handlers.txt
> rename to Documentation/driver-api/acpi/scan_handlers.rst
> index 3246ccf15992..7a197b3a33fc 100644
> --- a/Documentation/acpi/scan_handlers.txt
> +++ b/Documentation/driver-api/acpi/scan_handlers.rst
> @@ -1,7 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==================
>  ACPI Scan Handlers
> +==================
> +
> +:Copyright: |copy| 2012, Intel Corporation
>  
> -Copyright (C) 2012, Intel Corporation
> -Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> +:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  
>  During system initialization and ACPI-based device hot-add, the ACPI namespace
>  is scanned in search of device objects that generally represent various pieces
> @@ -30,14 +36,14 @@ to configure that link so that the kernel can use it.
>  Those additional configuration tasks usually depend on the type of the hardware
>  component represented by the given device node which can be determined on the
>  basis of the device node's hardware ID (HID).  They are performed by objects
> -called ACPI scan handlers represented by the following structure:
> +called ACPI scan handlers represented by the following structure::
>  
> -struct acpi_scan_handler {
> -	const struct acpi_device_id *ids;
> -	struct list_head list_node;
> -	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
> -	void (*detach)(struct acpi_device *dev);
> -};
> +	struct acpi_scan_handler {
> +		const struct acpi_device_id *ids;
> +		struct list_head list_node;
> +		int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
> +		void (*detach)(struct acpi_device *dev);
> +	};
>  
>  where ids is the list of IDs of device nodes the given handler is supposed to
>  take care of, list_node is the hook to the global list of ACPI scan handlers



Thanks,
Mauro
