Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF0C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:55:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B19E208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxlYlSpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8dP3Cn1zDqby
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:55:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="HxlYlSpm"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7cJ4N2gzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 04:09:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HhQ7jYzghgIqKgaAgfN76700l4OvgCKkOAd2ol9E0lU=; b=HxlYlSpmH7r5MFlhylXWNgWOFx
 pTx99hWG4+DIyjCa/WBRRbokCmSxtYMlWfXUuPkuUJ9gwnUINs5JGuwXSvw5I44vVxOhC3iRHXp7u
 Z1iCmkBWtIT2gKRLi5h4nEle7u3PTMjbfGyLvqJN5qbXyxfVWEytpkuIFJTA4gifT2If8ap94O+jL
 79F5TWQ5txbqkjlLKe2K9XoUn65IiQM/5h3WQEwNzFR4hmDj6K8oir9+tGEJgA3gSAqzncFpvuDi4
 vNiU5/QL+zLJCyFogbpW8Qrn+N9Y0NNTz2nVw86kV0KgVe7VdAcLqmYW3u9Hsf1lU4MsZs8zz3+r6
 BUPvEmxQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJMKH-0001uS-M8; Wed, 24 Apr 2019 18:08:58 +0000
Date: Wed, 24 Apr 2019 15:08:52 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v5 08/23] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424150852.0e415da1@coco.lan>
In-Reply-To: <20190424175306.25880-9-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
 <20190424175306.25880-9-changbin.du@gmail.com>
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

Em Thu, 25 Apr 2019 01:52:51 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/acpi/method-customizing.txt     | 73 ---------------
>  Documentation/firmware-guide/acpi/index.rst   |  3 +-
>  .../acpi/method-customizing.rst               | 89 +++++++++++++++++++
>  3 files changed, 91 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/acpi/method-customizing.txt
>  create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
> 
> diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
> deleted file mode 100644
> index 7235da975f23..000000000000
> --- a/Documentation/acpi/method-customizing.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -Linux ACPI Custom Control Method How To
> -=======================================
> -
> -Written by Zhang Rui <rui.zhang@intel.com>
> -
> -
> -Linux supports customizing ACPI control methods at runtime.
> -
> -Users can use this to
> -1. override an existing method which may not work correctly,
> -   or just for debugging purposes.
> -2. insert a completely new method in order to create a missing
> -   method such as _OFF, _ON, _STA, _INI, etc.
> -For these cases, it is far simpler to dynamically install a single
> -control method rather than override the entire DSDT, because kernel
> -rebuild/reboot is not needed and test result can be got in minutes.
> -
> -Note: Only ACPI METHOD can be overridden, any other object types like
> -      "Device", "OperationRegion", are not recognized. Methods
> -      declared inside scope operators are also not supported.
> -Note: The same ACPI control method can be overridden for many times,
> -      and it's always the latest one that used by Linux/kernel.
> -Note: To get the ACPI debug object output (Store (AAAA, Debug)),
> -      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
> -
> -1. override an existing method
> -   a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> -      just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> -   b) disassemble the table by running "iasl -d dsdt.dat".
> -   c) rewrite the ASL code of the method and save it in a new file,
> -   d) package the new file (psr.asl) to an ACPI table format.
> -      Here is an example of a customized \_SB._AC._PSR method,
> -
> -      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> -      {
> -	Method (\_SB_.AC._PSR, 0, NotSerialized)
> -	{
> -		Store ("In AC _PSR", Debug)
> -		Return (ACON)
> -	}
> -      }
> -      Note that the full pathname of the method in ACPI namespace
> -      should be used.
> -   e) assemble the file to generate the AML code of the method.
> -      e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> -      If parameter "-vw 6084" is not supported by your iASL compiler,
> -      please try a newer version.
> -   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> -   g) override the old method via the debugfs by running
> -      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> -
> -2. insert a new method
> -   This is easier than overriding an existing method.
> -   We just need to create the ASL code of the method we want to
> -   insert and then follow the step c) ~ g) in section 1.
> -
> -3. undo your changes
> -   The "undo" operation is not supported for a new inserted method
> -   right now, i.e. we can not remove a method currently.
> -   For an overridden method, in order to undo your changes, please
> -   save a copy of the method original ASL code in step c) section 1,
> -   and redo step c) ~ g) to override the method with the original one.
> -
> -
> -Note: We can use a kernel with multiple custom ACPI method running,
> -      But each individual write to debugfs can implement a SINGLE
> -      method override. i.e. if we want to insert/override multiple
> -      ACPI methods, we need to redo step c) ~ g) for multiple times.
> -
> -Note: Be aware that root can mis-use this driver to modify arbitrary
> -      memory and gain additional rights, if root's privileges got
> -      restricted (for example if root is not allowed to load additional
> -      modules after boot).
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 61d67763851b..d1d069b26bbc 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -10,5 +10,6 @@ ACPI Support
>     namespace
>     enumeration
>     osi
> +   method-customizing
>     DSD-properties-rules
> -   gpio-properties
> +   gpio-properties
> \ No newline at end of file
> diff --git a/Documentation/firmware-guide/acpi/method-customizing.rst b/Documentation/firmware-guide/acpi/method-customizing.rst
> new file mode 100644
> index 000000000000..de3ebcaed4cf
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/method-customizing.rst
> @@ -0,0 +1,89 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Linux ACPI Custom Control Method How To
> +=======================================
> +
> +:Author: Zhang Rui <rui.zhang@intel.com>
> +
> +
> +Linux supports customizing ACPI control methods at runtime.
> +
> +Users can use this to:
> +
> +1. override an existing method which may not work correctly,
> +   or just for debugging purposes.
> +2. insert a completely new method in order to create a missing
> +   method such as _OFF, _ON, _STA, _INI, etc.
> +
> +For these cases, it is far simpler to dynamically install a single
> +control method rather than override the entire DSDT, because kernel
> +rebuild/reboot is not needed and test result can be got in minutes.
> +
> +.. note::
> +
> +  - Only ACPI METHOD can be overridden, any other object types like
> +    "Device", "OperationRegion", are not recognized. Methods
> +    declared inside scope operators are also not supported.
> +
> +  - The same ACPI control method can be overridden for many times,
> +    and it's always the latest one that used by Linux/kernel.
> +
> +  - To get the ACPI debug object output (Store (AAAA, Debug)),
> +    please run::
> +
> +      echo 1 > /sys/module/acpi/parameters/aml_debug_output
> +
> +
> +1. override an existing method
> +==============================
> +a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> +   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> +b) disassemble the table by running "iasl -d dsdt.dat".
> +c) rewrite the ASL code of the method and save it in a new file,
> +d) package the new file (psr.asl) to an ACPI table format.
> +   Here is an example of a customized \_SB._AC._PSR method::
> +
> +      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> +      {
> +         Method (\_SB_.AC._PSR, 0, NotSerialized)
> +         {
> +            Store ("In AC _PSR", Debug)
> +            Return (ACON)
> +         }
> +      }
> +
> +   Note that the full pathname of the method in ACPI namespace
> +   should be used.
> +e) assemble the file to generate the AML code of the method.
> +   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> +   If parameter "-vw 6084" is not supported by your iASL compiler,
> +   please try a newer version.
> +f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> +g) override the old method via the debugfs by running
> +   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> +
> +2. insert a new method
> +======================
> +This is easier than overriding an existing method.
> +We just need to create the ASL code of the method we want to
> +insert and then follow the step c) ~ g) in section 1.
> +
> +3. undo your changes
> +====================
> +The "undo" operation is not supported for a new inserted method
> +right now, i.e. we can not remove a method currently.
> +For an overridden method, in order to undo your changes, please
> +save a copy of the method original ASL code in step c) section 1,
> +and redo step c) ~ g) to override the method with the original one.
> +
> +
> +.. note:: We can use a kernel with multiple custom ACPI method running,
> +   But each individual write to debugfs can implement a SINGLE
> +   method override. i.e. if we want to insert/override multiple
> +   ACPI methods, we need to redo step c) ~ g) for multiple times.
> +
> +.. note:: Be aware that root can mis-use this driver to modify arbitrary
> +   memory and gain additional rights, if root's privileges got
> +   restricted (for example if root is not allowed to load additional
> +   modules after boot).



Thanks,
Mauro
