Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8222AC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:05:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE25421738
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZzBbka7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE25421738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcv36zwJzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 08:05:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="LZzBbka7"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbwh1pZLzDqQm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 07:21:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7bm/7cx8935u5WpEqvYAR3JJzpYWOGucTqy7o1fPnE8=; b=LZzBbka75a6LUuL7IXg4Qvs2zU
 WoOc3jHTTu4Eh+W39e++gI7j8fInLn2O62kwolUQfhjCNYo67NSSIOSmvUISBxTAXk265Djyf3r/Q
 tqNT93E8kFpx/S/4ZpU7MRTzmPNjsBp7B4IDCnYaTIdxIJ8uNfMG570kSya3Wk4QbSQTXXrXOEVFg
 22d3e1ZT0a4I/m3X9zKMHb5DhGS6pe4yvVKDX6ktAziodE3FtZ+66vmsI6rhJN0WZpp2Dfjj7n9gR
 Pz0CXJNPEZKnCUu6spF1ahFccAwHgubWnYLJHMmRmp0w3nXY++crW65iKO8vygb9sIkBCtAkwZ8n4
 iO7jByqg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2qo-0004Dc-Sx; Tue, 23 Apr 2019 21:21:15 +0000
Date: Tue, 23 Apr 2019 18:21:08 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 16/63] Documentation: ACPI: move debug.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423182108.2bf06960@coco.lan>
In-Reply-To: <20190423162932.21428-17-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-17-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:45 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../acpi/debug.rst}                           | 31 ++++++++++---------
>  Documentation/firmware-guide/acpi/index.rst   |  3 +-
>  2 files changed, 19 insertions(+), 15 deletions(-)
>  rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)
> 
> diff --git a/Documentation/acpi/debug.txt b/Documentation/firmware-guide/acpi/debug.rst
> similarity index 91%
> rename from Documentation/acpi/debug.txt
> rename to Documentation/firmware-guide/acpi/debug.rst
> index 65bf47c46b6d..1a152dd1d765 100644
> --- a/Documentation/acpi/debug.txt
> +++ b/Documentation/firmware-guide/acpi/debug.rst
> @@ -1,18 +1,21 @@
> -			ACPI Debug Output
> +.. SPDX-License-Identifier: GPL-2.0
>  
> +=================
> +ACPI Debug Output
> +=================
>  
>  The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
>  output.  This document describes how to use this facility.
>  
>  Compile-time configuration
> ---------------------------
> +==========================
>  
>  ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
>  option is turned off, the debug messages are not even built into the
>  kernel.
>  
>  Boot- and run-time configuration
> ---------------------------------
> +================================
>  
>  When CONFIG_ACPI_DEBUG=y, you can select the component and level of messages
>  you're interested in.  At boot-time, use the acpi.debug_layer and
> @@ -21,7 +24,7 @@ debug_layer and debug_level files in /sys/module/acpi/parameters/ to control
>  the debug messages.
>  
>  debug_layer (component)
> ------------------------
> +=======================
>  
>  The "debug_layer" is a mask that selects components of interest, e.g., a
>  specific driver or part of the ACPI interpreter.  To build the debug_layer
> @@ -33,7 +36,7 @@ to /sys/module/acpi/parameters/debug_layer.
>  
>  The possible components are defined in include/acpi/acoutput.h and
>  include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
> -shows the supported mask values, currently these:
> +shows the supported mask values, currently these::
>  
>      ACPI_UTILITIES                  0x00000001
>      ACPI_HARDWARE                   0x00000002
> @@ -65,7 +68,7 @@ shows the supported mask values, currently these:
>      ACPI_PROCESSOR_COMPONENT        0x20000000

This is one way of doing. The other one, with would likely produce a
better visual, would be to use tables, e. g.:

     ==============                  ==========
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
     ==============                  ==========

Of course, if you use tables here, you need to be consistent along
similar cases inside the document.

while both works, I prefer using tables on such cases.

Either way:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  
>  debug_level
> ------------
> +===========
>  
>  The "debug_level" is a mask that selects different types of messages, e.g.,
>  those related to initialization, method execution, informational messages, etc.
> @@ -81,7 +84,7 @@ to /sys/module/acpi/parameters/debug_level.
>  
>  The possible levels are defined in include/acpi/acoutput.h.  Reading
>  /sys/module/acpi/parameters/debug_level shows the supported mask values,
> -currently these:
> +currently these::
>  
>      ACPI_LV_INIT                    0x00000001
>      ACPI_LV_DEBUG_OBJECT            0x00000002
> @@ -113,9 +116,9 @@ currently these:
>      ACPI_LV_EVENTS                  0x80000000
>  
>  Examples
> ---------
> +========
>  
> -For example, drivers/acpi/bus.c contains this:
> +For example, drivers/acpi/bus.c contains this::
>  
>      #define _COMPONENT              ACPI_BUS_COMPONENT
>      ...
> @@ -127,22 +130,22 @@ statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
>  definition.)
>  
>  Enable all AML "Debug" output (stores to the Debug object while interpreting
> -AML) during boot:
> +AML) during boot::
>  
>      acpi.debug_layer=0xffffffff acpi.debug_level=0x2
>  
> -Enable PCI and PCI interrupt routing debug messages:
> +Enable PCI and PCI interrupt routing debug messages::
>  
>      acpi.debug_layer=0x400000 acpi.debug_level=0x4
>  
> -Enable all ACPI hardware-related messages:
> +Enable all ACPI hardware-related messages::
>  
>      acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
>  
> -Enable all ACPI_DB_INFO messages after boot:
> +Enable all ACPI_DB_INFO messages after boot::
>  
>      # echo 0x4 > /sys/module/acpi/parameters/debug_level
>  
> -Show all valid component values:
> +Show all valid component values::
>   
>      # cat /sys/module/acpi/parameters/debug_layer
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 6d4e0df4f063..a45fea11f998 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -14,6 +14,7 @@ ACPI Support
>     osi
>     method-customizing
>     DSD-properties-rules
> +   debug
>     gpio-properties
>     i2c-muxes
> -   acpi-lid
> \ No newline at end of file
> +   acpi-lid



Thanks,
Mauro
