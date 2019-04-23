Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD876C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:44:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E70218D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPZYtZPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E70218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcR00z97zDqWP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="OPZYtZPc"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pb6m4YnzzDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 06:45:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0sN93tP7HgHVmto5WRTmJqavSp1wRhqDaDVwYomO2HU=; b=OPZYtZPc/0bHOPuKhS/JP6SsK4
 Z3TIF0OzuN93M4tro1dMfONRYjU6uh07Yq8Z17Asrp2pTKrpXj9oM7N6n2ktPZT+5D3AyaO9zluUV
 QVtgNI+ikpOBxOlZEkI2mokyTdZWuKdAY9Cc/FC4bE/Wa3S59zJ3fiZE+Pi6D1rwN+nabjimrw8Ek
 APWMt0ycI2DiZDr+SvA8+JUUcCZ07GvEl8M89sU83pqAPT4pFuRT3OsNbcVXKd2HvyTVbMrjm3cif
 Gd7xYMGcEvOIefA6iQ36qkkbgOp4gCAnqeaDl0kRycUld+hp0uFzV6RLwRFv81McvMsSMUVs7PQUf
 +yeiGa1g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2Hf-0002b1-5e; Tue, 23 Apr 2019 20:44:55 +0000
Date: Tue, 23 Apr 2019 17:44:49 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 04/63] Documentation: ACPI: move osi.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423174449.5e2e0329@coco.lan>
In-Reply-To: <20190423162932.21428-5-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-5-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:33 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/firmware-guide/acpi/index.rst       |  1 +
>  .../{acpi/osi.txt => firmware-guide/acpi/osi.rst} | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>  rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)
> 
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 99677c73f1fb..868bd25a3398 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -9,3 +9,4 @@ ACPI Support
>  
>     namespace
>     enumeration
> +   osi
> diff --git a/Documentation/acpi/osi.txt b/Documentation/firmware-guide/acpi/osi.rst
> similarity index 97%
> rename from Documentation/acpi/osi.txt
> rename to Documentation/firmware-guide/acpi/osi.rst
> index 50cde0ceb9b0..29e9ef79ebc0 100644
> --- a/Documentation/acpi/osi.txt
> +++ b/Documentation/firmware-guide/acpi/osi.rst
> @@ -1,5 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================
>  ACPI _OSI and _REV methods
> ---------------------------
> +==========================

You could probably do just the above, but changing the title
markups on the other files has the advantage of using the
same standard on all acpi files.

Either way, just looking at the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


>  
>  An ACPI BIOS can use the "Operating System Interfaces" method (_OSI)
>  to find out what the operating system supports. Eg. If BIOS
> @@ -14,7 +17,7 @@ This document explains how and why the BIOS and Linux should use these methods.
>  It also explains how and why they are widely misused.
>  
>  How to use _OSI
> ----------------
> +===============
>  
>  Linux runs on two groups of machines -- those that are tested by the OEM
>  to be compatible with Linux, and those that were never tested with Linux,
> @@ -62,7 +65,7 @@ the string when that support is added to the kernel.
>  That was easy.  Read on, to find out how to do it wrong.
>  
>  Before _OSI, there was _OS
> ---------------------------
> +==========================
>  
>  ACPI 1.0 specified "_OS" as an
>  "object that evaluates to a string that identifies the operating system."
> @@ -96,7 +99,7 @@ That is the *only* viable strategy, as that is what modern Windows does,
>  and so doing otherwise could steer the BIOS down an untested path.
>  
>  _OSI is born, and immediately misused
> ---------------------------------------
> +=====================================
>  
>  With _OSI, the *BIOS* provides the string describing an interface,
>  and asks the OS: "YES/NO, are you compatible with this interface?"
> @@ -144,7 +147,7 @@ catastrophic failure resulting from the BIOS taking paths that
>  were never validated under *any* OS.
>  
>  Do not use _REV
> ----------------
> +===============
>  
>  Since _OSI("Linux") went away, some BIOS writers used _REV
>  to support Linux and Windows differences in the same BIOS.
> @@ -164,7 +167,7 @@ from mid-2015 onward.  The ACPI specification will also be updated
>  to reflect that _REV is deprecated, and always returns 2.
>  
>  Apple Mac and _OSI("Darwin")
> -----------------------------
> +============================
>  
>  On Apple's Mac platforms, the ACPI BIOS invokes _OSI("Darwin")
>  to determine if the machine is running Apple OSX.



Thanks,
Mauro
