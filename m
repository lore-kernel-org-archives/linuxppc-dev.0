Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A97FC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:53:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87535218D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sVLzz6rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87535218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcfD4WQYzDqVw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:53:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="sVLzz6rJ"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbd25tbbzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 07:07:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dnuFO7t4W9EgdcKlvxRoeINMaVZeOfc+KvsbJT2Al1U=; b=sVLzz6rJLeTh4rBdRPe84Ndu1s
 WgayGPmFZKd6jIR4sBXKJ6OIjT5zctHO/lvAnjiF0HJnW4MXiXWoCkaQc2t+HHExY35mSUCbPdM9g
 EfviJGM/jG1sRutX04PfayHUc57O5zcpaJCvl1Fjo9g+ztQb4SYv6qkqX+Oksrhwrwv7ZZWm6SRf/
 eGDUQ/ly/I0OvozxSbWH5K5/SOQLmRTN/NjrY3KjBw6jkeW5mFPQUP5dwB9UgK68AaFfDKWaMi/K0
 nZHfG3lZqUWylNz1V6mtq6X5SmFf83V7NUsuO95YGZpHkbl10ivKo9ijHS7+6Qm2pT6b+aByG21D/
 wiEv11fQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2dg-0003hX-6P; Tue, 23 Apr 2019 21:07:40 +0000
Date: Tue, 23 Apr 2019 18:07:34 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 10/63] Documentation: ACPI: move
 initrd_table_override.txt to admin-guide/acpi and convert to reST
Message-ID: <20190423180734.67c6f470@coco.lan>
In-Reply-To: <20190423162932.21428-11-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-11-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:39 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/acpi/initrd_table_override.txt  | 111 ----------------
>  Documentation/admin-guide/acpi/index.rst      |   1 +
>  .../acpi/initrd_table_override.rst            | 120 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/acpi/initrd_table_override.txt
>  create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
> 
> diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
> deleted file mode 100644
> index 30437a6db373..000000000000
> --- a/Documentation/acpi/initrd_table_override.txt
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -Upgrading ACPI tables via initrd
> -================================
> -
> -1) Introduction (What is this about)
> -2) What is this for
> -3) How does it work
> -4) References (Where to retrieve userspace tools)
> -
> -1) What is this about
> ----------------------
> -
> -If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
> -upgrade the ACPI execution environment that is defined by the ACPI tables
> -via upgrading the ACPI tables provided by the BIOS with an instrumented,
> -modified, more recent version one, or installing brand new ACPI tables.
> -
> -When building initrd with kernel in a single image, option
> -ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
> -feature to work.
> -
> -For a full list of ACPI tables that can be upgraded/installed, take a look
> -at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
> -drivers/acpi/tables.c.
> -All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
> -be overridable, except:
> -   - ACPI_SIG_RSDP (has a signature of 6 bytes)
> -   - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
> -Both could get implemented as well.
> -
> -
> -2) What is this for
> --------------------
> -
> -Complain to your platform/BIOS vendor if you find a bug which is so severe
> -that a workaround is not accepted in the Linux kernel. And this facility
> -allows you to upgrade the buggy tables before your platform/BIOS vendor
> -releases an upgraded BIOS binary.
> -
> -This facility can be used by platform/BIOS vendors to provide a Linux
> -compatible environment without modifying the underlying platform firmware.
> -
> -This facility also provides a powerful feature to easily debug and test
> -ACPI BIOS table compatibility with the Linux kernel by modifying old
> -platform provided ACPI tables or inserting new ACPI tables.
> -
> -It can and should be enabled in any kernel because there is no functional
> -change with not instrumented initrds.
> -
> -
> -3) How does it work
> --------------------
> -
> -# Extract the machine's ACPI tables:
> -cd /tmp
> -acpidump >acpidump
> -acpixtract -a acpidump
> -# Disassemble, modify and recompile them:
> -iasl -d *.dat
> -# For example add this statement into a _PRT (PCI Routing Table) function
> -# of the DSDT:
> -Store("HELLO WORLD", debug)
> -# And increase the OEM Revision. For example, before modification:
> -DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
> -# After modification:
> -DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
> -iasl -sa dsdt.dsl
> -# Add the raw ACPI tables to an uncompressed cpio archive.
> -# They must be put into a /kernel/firmware/acpi directory inside the cpio
> -# archive. Note that if the table put here matches a platform table
> -# (similar Table Signature, and similar OEMID, and similar OEM Table ID)
> -# with a more recent OEM Revision, the platform table will be upgraded by
> -# this table. If the table put here doesn't match a platform table
> -# (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
> -# ID), this table will be appended.
> -mkdir -p kernel/firmware/acpi
> -cp dsdt.aml kernel/firmware/acpi
> -# A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
> -# (see osl.c):
> -iasl -sa facp.dsl
> -iasl -sa ssdt1.dsl
> -cp facp.aml kernel/firmware/acpi
> -cp ssdt1.aml kernel/firmware/acpi
> -# The uncompressed cpio archive must be the first. Other, typically
> -# compressed cpio archives, must be concatenated on top of the uncompressed
> -# one. Following command creates the uncompressed cpio archive and
> -# concatenates the original initrd on top:
> -find kernel | cpio -H newc --create > /boot/instrumented_initrd
> -cat /boot/initrd >>/boot/instrumented_initrd
> -# reboot with increased acpi debug level, e.g. boot params:
> -acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
> -# and check your syslog:
> -[    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> -[    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
> -
> -iasl is able to disassemble and recompile quite a lot different,
> -also static ACPI tables.
> -
> -
> -4) Where to retrieve userspace tools
> -------------------------------------
> -
> -iasl and acpixtract are part of Intel's ACPICA project:
> -http://acpica.org/
> -and should be packaged by distributions (for example in the acpica package
> -on SUSE).
> -
> -acpidump can be found in Len Browns pmtools:
> -ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
> -This tool is also part of the acpica package on SUSE.
> -Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
> -/sys/firmware/acpi/tables
> diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> index 3e041206089d..09e4e81e4fb7 100644
> --- a/Documentation/admin-guide/acpi/index.rst
> +++ b/Documentation/admin-guide/acpi/index.rst
> @@ -8,3 +8,4 @@ the Linux ACPI support.
>  .. toctree::
>     :maxdepth: 1
>  
> +   initrd_table_override
> diff --git a/Documentation/admin-guide/acpi/initrd_table_override.rst b/Documentation/admin-guide/acpi/initrd_table_override.rst
> new file mode 100644
> index 000000000000..0787b2b91ded
> --- /dev/null
> +++ b/Documentation/admin-guide/acpi/initrd_table_override.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================
> +Upgrading ACPI tables via initrd
> +================================
> +
> +1) Introduction (What is this about)
> +2) What is this for
> +3) How does it work
> +4) References (Where to retrieve userspace tools)

Hmm... I did the same on my conversion, but IMO, the best would be to
hide (or remove, if ACPI maintainers agree) the contents, as this may
conflict with the body as people may add new stuff and forget to
update it.

So, if ACPI maintainers insist on keeping it, I would code this as:

.. Contents

   1) Introduction (What is this about)
   2) What is this for
   3) How does it work
   4) References (Where to retrieve userspace tools)

as this will make this invisible on html/pdf/epub output.

Anyway, with or without the above change:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> +
> +1) What is this about
> +=====================
> +
> +If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
> +upgrade the ACPI execution environment that is defined by the ACPI tables
> +via upgrading the ACPI tables provided by the BIOS with an instrumented,
> +modified, more recent version one, or installing brand new ACPI tables.
> +
> +When building initrd with kernel in a single image, option
> +ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
> +feature to work.
> +
> +For a full list of ACPI tables that can be upgraded/installed, take a look
> +at the char `*table_sigs[MAX_ACPI_SIGNATURE];` definition in
> +drivers/acpi/tables.c.
> +
> +All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
> +be overridable, except:
> +
> +  - ACPI_SIG_RSDP (has a signature of 6 bytes)
> +  - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
> +
> +Both could get implemented as well.
> +
> +
> +2) What is this for
> +===================
> +
> +Complain to your platform/BIOS vendor if you find a bug which is so severe
> +that a workaround is not accepted in the Linux kernel. And this facility
> +allows you to upgrade the buggy tables before your platform/BIOS vendor
> +releases an upgraded BIOS binary.
> +
> +This facility can be used by platform/BIOS vendors to provide a Linux
> +compatible environment without modifying the underlying platform firmware.
> +
> +This facility also provides a powerful feature to easily debug and test
> +ACPI BIOS table compatibility with the Linux kernel by modifying old
> +platform provided ACPI tables or inserting new ACPI tables.
> +
> +It can and should be enabled in any kernel because there is no functional
> +change with not instrumented initrds.
> +
> +
> +3) How does it work
> +===================
> +::
> +
> +  # Extract the machine's ACPI tables:
> +  cd /tmp
> +  acpidump >acpidump
> +  acpixtract -a acpidump
> +  # Disassemble, modify and recompile them:
> +  iasl -d *.dat
> +  # For example add this statement into a _PRT (PCI Routing Table) function
> +  # of the DSDT:
> +  Store("HELLO WORLD", debug)
> +  # And increase the OEM Revision. For example, before modification:
> +  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
> +  # After modification:
> +  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
> +  iasl -sa dsdt.dsl
> +  # Add the raw ACPI tables to an uncompressed cpio archive.
> +  # They must be put into a /kernel/firmware/acpi directory inside the cpio
> +  # archive. Note that if the table put here matches a platform table
> +  # (similar Table Signature, and similar OEMID, and similar OEM Table ID)
> +  # with a more recent OEM Revision, the platform table will be upgraded by
> +  # this table. If the table put here doesn't match a platform table
> +  # (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
> +  # ID), this table will be appended.
> +  mkdir -p kernel/firmware/acpi
> +  cp dsdt.aml kernel/firmware/acpi
> +  # A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
> +  # (see osl.c):
> +  iasl -sa facp.dsl
> +  iasl -sa ssdt1.dsl
> +  cp facp.aml kernel/firmware/acpi
> +  cp ssdt1.aml kernel/firmware/acpi
> +  # The uncompressed cpio archive must be the first. Other, typically
> +  # compressed cpio archives, must be concatenated on top of the uncompressed
> +  # one. Following command creates the uncompressed cpio archive and
> +  # concatenates the original initrd on top:
> +  find kernel | cpio -H newc --create > /boot/instrumented_initrd
> +  cat /boot/initrd >>/boot/instrumented_initrd
> +  # reboot with increased acpi debug level, e.g. boot params:
> +  acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
> +  # and check your syslog:
> +  [    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> +  [    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
> +
> +iasl is able to disassemble and recompile quite a lot different,
> +also static ACPI tables.
> +
> +
> +4) Where to retrieve userspace tools
> +====================================
> +
> +iasl and acpixtract are part of Intel's ACPICA project:
> +http://acpica.org/
> +
> +and should be packaged by distributions (for example in the acpica package
> +on SUSE).
> +
> +acpidump can be found in Len Browns pmtools:
> +ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
> +
> +This tool is also part of the acpica package on SUSE.
> +Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
> +/sys/firmware/acpi/tables



Thanks,
Mauro
