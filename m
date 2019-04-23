Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E7CC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:45:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510B6218D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zk5cSFhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510B6218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcSy0RdgzDqVx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:45:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Zk5cSFhH"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbFM06XHzDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 06:50:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KlA0GkG+k6msTfm0ygSALxJsZXOk+nUWPU+MWkSrT5Y=; b=Zk5cSFhHSa2xTp359PZh5/T/sF
 Kpuc8fWp0I2WaRi8AcH95829MibcFKLEj2S9ChX6INt9gLEkzCKRyMC4XJ5qAYoFANPK7ao5EZQjr
 CAAf9Wy3qEfKsxO1WeO7vEyXMfZbGQmdyCTAKQwsnyrOQY2nrTatcv3da/5GulIbc+ak0pSFNZWSE
 Wyi5DulGpiKCJ32QnGEKKwIncGfCKD7ZrlZE8Gj2wcaYh6pc81/aoyYub70WRSOXqwzZqr9rBO9Tc
 qinRF/ydYSSYqMd7YVQshaBI+Hj592eA5tKqCYf1HtPtytpkN4DddYX0syR2eT2CUdXxJ5Uq1p5zF
 nmDUECmw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2NA-0002qQ-R0; Tue, 23 Apr 2019 20:50:37 +0000
Date: Tue, 23 Apr 2019 17:50:30 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 05/63] Documentation: ACPI: move linuxized-acpica.txt
 to driver-api/acpi and convert to  reST
Message-ID: <20190423175030.7d0cc624@coco.lan>
In-Reply-To: <20190423162932.21428-6-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-6-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:34 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/driver-api/acpi/index.rst       |   1 +
>  .../acpi/linuxized-acpica.rst}                | 115 ++++++++++--------
>  2 files changed, 66 insertions(+), 50 deletions(-)
>  rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (78%)
> 
> diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
> index 898b0c60671a..12649947b19b 100644
> --- a/Documentation/driver-api/acpi/index.rst
> +++ b/Documentation/driver-api/acpi/index.rst
> @@ -5,3 +5,4 @@ ACPI Support
>  .. toctree::
>     :maxdepth: 2
>  
> +   linuxized-acpica
> diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/driver-api/acpi/linuxized-acpica.rst
> similarity index 78%
> rename from Documentation/acpi/linuxized-acpica.txt
> rename to Documentation/driver-api/acpi/linuxized-acpica.rst
> index 3ad7b0dfb083..f8aaea668e41 100644
> --- a/Documentation/acpi/linuxized-acpica.txt
> +++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
> @@ -1,31 +1,35 @@
> -Linuxized ACPICA - Introduction to ACPICA Release Automation
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> -Copyright (C) 2013-2016, Intel Corporation
> -Author: Lv Zheng <lv.zheng@intel.com>
> +============================================================
> +Linuxized ACPICA - Introduction to ACPICA Release Automation
> +============================================================
>  
> +:Copyright: |copy| 2013-2016, Intel Corporation
>  
> -Abstract:
> +:Author: Lv Zheng <lv.zheng@intel.com>
>  
> -This document describes the ACPICA project and the relationship between
> -ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
> -include/acpi and tools/power/acpi is automatically updated to follow the
> -upstream.
> +:Abstract: This document describes the ACPICA project and the relationship
> +           between ACPICA and Linux.  It also describes how ACPICA code in
> +           drivers/acpi/acpica, include/acpi and tools/power/acpi is
> +           automatically updated to follow the upstream.
>  

Same comment as on patch 02: I would keep the abstracts as a chapter,
in order to make them visible at the index, as this may help readers
to quickly look at the document's contents.

I'm sure other APCI documents also have abstracts. So, please consider
this comment also for the other docs.

Anyway, this is just a suggestion. I'm also fine with the above.
Either way, for the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  
> -1. ACPICA Project
> +ACPICA Project
> +==============
>  
> -   The ACPI Component Architecture (ACPICA) project provides an operating
> -   system (OS)-independent reference implementation of the Advanced
> -   Configuration and Power Interface Specification (ACPI).  It has been
> -   adapted by various host OSes.  By directly integrating ACPICA, Linux can
> -   also benefit from the application experiences of ACPICA from other host
> -   OSes.
> +The ACPI Component Architecture (ACPICA) project provides an operating
> +system (OS)-independent reference implementation of the Advanced
> +Configuration and Power Interface Specification (ACPI).  It has been
> +adapted by various host OSes.  By directly integrating ACPICA, Linux can
> +also benefit from the application experiences of ACPICA from other host
> +OSes.
>  
> -   The homepage of ACPICA project is: www.acpica.org, it is maintained and
> -   supported by Intel Corporation.
> +The homepage of ACPICA project is: www.acpica.org, it is maintained and
> +supported by Intel Corporation.
>  
> -   The following figure depicts the Linux ACPI subsystem where the ACPICA
> -   adaptation is included:
> +The following figure depicts the Linux ACPI subsystem where the ACPICA
> +adaptation is included::
>  
>        +---------------------------------------------------------+
>        |                                                         |
> @@ -71,21 +75,27 @@ upstream.
>  
>                   Figure 1. Linux ACPI Software Components
>  
> -   NOTE:
> +.. note::
>      A. OS Service Layer - Provided by Linux to offer OS dependent
>         implementation of the predefined ACPICA interfaces (acpi_os_*).
> +       ::
> +
>           include/acpi/acpiosxf.h
>           drivers/acpi/osl.c
>           include/acpi/platform
>           include/asm/acenv.h
>      B. ACPICA Functionality - Released from ACPICA code base to offer
>         OS independent implementation of the ACPICA interfaces (acpi_*).
> +       ::
> +
>           drivers/acpi/acpica
>           include/acpi/ac*.h
>           tools/power/acpi
>      C. Linux/ACPI Functionality - Providing Linux specific ACPI
>         functionality to the other Linux kernel subsystems and user space
>         programs.
> +       ::
> +
>           drivers/acpi
>           include/linux/acpi.h
>           include/linux/acpi*.h
> @@ -95,24 +105,27 @@ upstream.
>         ACPI subsystem to offer architecture specific implementation of the
>         ACPI interfaces.  They are Linux specific components and are out of
>         the scope of this document.
> +       ::
> +
>           include/asm/acpi.h
>           include/asm/acpi*.h
>           arch/*/acpi
>  
> -2. ACPICA Release
> +ACPICA Release
> +==============
>  
> -   The ACPICA project maintains its code base at the following repository URL:
> -   https://github.com/acpica/acpica.git. As a rule, a release is made every
> -   month.
> +The ACPICA project maintains its code base at the following repository URL:
> +https://github.com/acpica/acpica.git. As a rule, a release is made every
> +month.
>  
> -   As the coding style adopted by the ACPICA project is not acceptable by
> -   Linux, there is a release process to convert the ACPICA git commits into
> -   Linux patches.  The patches generated by this process are referred to as
> -   "linuxized ACPICA patches".  The release process is carried out on a local
> -   copy the ACPICA git repository.  Each commit in the monthly release is
> -   converted into a linuxized ACPICA patch.  Together, they form the monthly
> -   ACPICA release patchset for the Linux ACPI community.  This process is
> -   illustrated in the following figure:
> +As the coding style adopted by the ACPICA project is not acceptable by
> +Linux, there is a release process to convert the ACPICA git commits into
> +Linux patches.  The patches generated by this process are referred to as
> +"linuxized ACPICA patches".  The release process is carried out on a local
> +copy the ACPICA git repository.  Each commit in the monthly release is
> +converted into a linuxized ACPICA patch.  Together, they form the monthly
> +ACPICA release patchset for the Linux ACPI community.  This process is
> +illustrated in the following figure::
>  
>      +-----------------------------+
>      | acpica / master (-) commits |
> @@ -153,7 +166,7 @@ upstream.
>  
>                  Figure 2. ACPICA -> Linux Upstream Process
>  
> -   NOTE:
> +.. note::
>      A. Linuxize Utilities - Provided by the ACPICA repository, including a
>         utility located in source/tools/acpisrc folder and a number of
>         scripts located in generate/linux folder.
> @@ -170,19 +183,20 @@ upstream.
>     following kernel configuration options:
>     CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
>  
> -3. ACPICA Divergences
> +ACPICA Divergences
> +==================
>  
> -   Ideally, all of the ACPICA commits should be converted into Linux patches
> -   automatically without manual modifications, the "linux / master" tree should
> -   contain the ACPICA code that exactly corresponds to the ACPICA code
> -   contained in "new linuxized acpica" tree and it should be possible to run
> -   the release process fully automatically.
> +Ideally, all of the ACPICA commits should be converted into Linux patches
> +automatically without manual modifications, the "linux / master" tree should
> +contain the ACPICA code that exactly corresponds to the ACPICA code
> +contained in "new linuxized acpica" tree and it should be possible to run
> +the release process fully automatically.
>  
> -   As a matter of fact, however, there are source code differences between
> -   the ACPICA code in Linux and the upstream ACPICA code, referred to as
> -   "ACPICA Divergences".
> +As a matter of fact, however, there are source code differences between
> +the ACPICA code in Linux and the upstream ACPICA code, referred to as
> +"ACPICA Divergences".
>  
> -   The various sources of ACPICA divergences include:
> +The various sources of ACPICA divergences include:
>     1. Legacy divergences - Before the current ACPICA release process was
>        established, there already had been divergences between Linux and
>        ACPICA. Over the past several years those divergences have been greatly
> @@ -213,11 +227,12 @@ upstream.
>        rebased on the ACPICA side in order to offer better solutions, new ACPICA
>        divergences are generated.
>  
> -4. ACPICA Development
> +ACPICA Development
> +==================
>  
> -   This paragraph guides Linux developers to use the ACPICA upstream release
> -   utilities to obtain Linux patches corresponding to upstream ACPICA commits
> -   before they become available from the ACPICA release process.
> +This paragraph guides Linux developers to use the ACPICA upstream release
> +utilities to obtain Linux patches corresponding to upstream ACPICA commits
> +before they become available from the ACPICA release process.
>  
>     1. Cherry-pick an ACPICA commit
>  
> @@ -225,7 +240,7 @@ upstream.
>     you want to cherry pick must be committed into the local repository.
>  
>     Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
> -   from the ACPICA local repository:
> +   from the ACPICA local repository::
>  
>     $ git clone https://github.com/acpica/acpica
>     $ cd acpica
> @@ -240,7 +255,7 @@ upstream.
>     changes that haven't been applied to Linux yet.
>  
>     You can generate the ACPICA release series yourself and rebase your code on
> -   top of the generated ACPICA release patches:
> +   top of the generated ACPICA release patches::
>  
>     $ git clone https://github.com/acpica/acpica
>     $ cd acpica
> @@ -254,7 +269,7 @@ upstream.
>     3. Inspect the current divergences
>  
>     If you have local copies of both Linux and upstream ACPICA, you can generate
> -   a diff file indicating the state of the current divergences:
> +   a diff file indicating the state of the current divergences::
>  
>     # git clone https://github.com/acpica/acpica
>     # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git



Thanks,
Mauro
