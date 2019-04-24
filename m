Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB6C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9712820835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1/F2Qpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9712820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8jX4cWZzDqHn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:58:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="O1/F2Qpu"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7hb3vr0zDqWx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 04:12:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ojgIGtqBjKZ94rG62AN3WAggUWCZ+hJ6m5woSpGnwUc=; b=O1/F2Qpu51GO8rXz1zY6kYk99L
 XrZlPd3IlyXTDjPoqKWGkQ5L9ocnA+I/P9bunB/fSk9vhEPYRAZEeNbp8uderR2zg3eMU4Um449UQ
 JDiIDpo4Y/nvTg9W5eMOQW4SVXC4xvq+GLXJzJzNtdosM6b0r2bRoOiynVZDK9eu2ZpBQyEI2tzzn
 2+Hq0uDmIVrzTNK1UXukkg/kMtNzFd2MEIvgNbLYOdakf1WdML/JmeoL6fYbGbSyagrhuUE2/qLwk
 2nZ2nuZANyvKzCUoyn/QXq9V9RbcfqO/Yq09GKoeR4BYNCqOMXCJke1on90Pix4qUKL0knXOa1JYy
 iBqFTp0w==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJMNt-000219-Pf; Wed, 24 Apr 2019 18:12:42 +0000
Date: Wed, 24 Apr 2019 15:12:36 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190424151236.776d9678@coco.lan>
In-Reply-To: <20190424175306.25880-21-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
 <20190424175306.25880-21-changbin.du@gmail.com>
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
Cc: fenghua.yu@intel.com, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Thu, 25 Apr 2019 01:53:03 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
>  Documentation/admin-guide/acpi/index.rst      |  1 +
>  2 files changed, 40 insertions(+), 32 deletions(-)
>  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> 
> diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> similarity index 51%
> rename from Documentation/acpi/cppc_sysfs.txt
> rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> index f20fb445135d..a4b99afbe331 100644
> --- a/Documentation/acpi/cppc_sysfs.txt
> +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> @@ -1,5 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> -	Collaborative Processor Performance Control (CPPC)
> +==================================================
> +Collaborative Processor Performance Control (CPPC)
> +==================================================
> +
> +CPPC
> +====
>  
>  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
>  performance of a logical processor on a contigious and abstract performance
> @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
>  
>  http://uefi.org/specifications
>  
> -Some of the CPPC registers are exposed via sysfs under:
> -
> -/sys/devices/system/cpu/cpuX/acpi_cppc/


> -
> -for each cpu X

Yeah, there it is: you're removing those two lines.

> +Some of the CPPC registers are exposed via sysfs under::
>  
> ---------------------------------------------------------------------------------
> +  /sys/devices/system/cpu/cpuX/acpi_cppc/

As per my reply to v4.

Thanks,
Mauro
