Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB1C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:57:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295A7206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzF7zp9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295A7206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhfJ5bPyzDqTp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:57:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzF7zp9g"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh5J2SC4zDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:32:36 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id k19so46013pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nt9Hzadmk3IfOZGZ4NISzwcFzm/IxLMb6ukyabMZ2m8=;
 b=QzF7zp9gNAw9fLgi7f3JrD0pWORvfuYQxpOM61EUjMwdrxMiTpB9djpFrdUyFDFZt2
 MakGodFwSkLW6choF6iUFpTcU1IO8qF5yDq4SvCSL1318LiwoS0qc2kXYVk/oxqkwREG
 6cvzL2MZnebNF/FZQ4bCZVoivn5Zc84WdvJvjhg5GbeLK8A2U8ZamyeHD87COyocTRw4
 tjGhV0UEqjkT6iTJ6ZVlV4VWOXCuLRrFL4h0+EFSMDqkgs14SwJgFh4P0ju/IEjI3Ai4
 bgCXv4KOfkqSgV//ZkdvjWLzC3THb4fJlTnqOMUniBEKNDeN6/ogjQLW+P7A1M0eDdVw
 NyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nt9Hzadmk3IfOZGZ4NISzwcFzm/IxLMb6ukyabMZ2m8=;
 b=aIJHY/KZR9vG5R7VlK2kIwS1FdsyyWvUba4x5QaA9+SyUv1vcNTSQQXSSYrGLtJBmh
 3f5fff2SPxmyZ59cs4J2Ffje4b9PDAAUW+eJ/Rpq10M6cPNH1Nx95TWEfBxhaVqUljhI
 vZvexDwpaH8Yzec0viZmu2EfJJrnVW9c5ZcAwgzKgmpciEEQKqPuh2dwJ9o3VXD4UKt5
 /A7cSqzuCuBTkZRQLChf+GPIoBFUOjAMeWhtyku9HaA3v3pgWbku5ivxLqnhktdUSB2u
 /ANBWg/xb8g9XsbS63gwoow4UGQM7fx/j0jdZ4j/oyh1Ec8nTy7zZmJDiArc9admJV+n
 AD6A==
X-Gm-Message-State: APjAAAWkJ3zqWTzZtmZ0nNtSklSqVSUkxYfElWubcw4OOe3h660Xw+ro
 XBlwiRph0SC3KY3NIc/ugLA=
X-Google-Smtp-Source: APXvYqyQBbt4A/+U8lGU3a//zzJJ5nGsqFj+OYeomM3z1OA0HvJex4w0WeJ6hHwhFwF/BnEmwPdRng==
X-Received: by 2002:a62:474a:: with SMTP id u71mr39902192pfa.87.1556206353139; 
 Thu, 25 Apr 2019 08:32:33 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:32:32 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 10/24] Documentation: ACPI: move initrd_table_override.txt
 to admin-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:03 +0800
Message-Id: <20190425153117.16057-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/acpi/initrd_table_override.txt  | 111 -----------------
 Documentation/admin-guide/acpi/index.rst      |   1 +
 .../acpi/initrd_table_override.rst            | 115 ++++++++++++++++++
 3 files changed, 116 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst

diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
deleted file mode 100644
index 30437a6db373..000000000000
--- a/Documentation/acpi/initrd_table_override.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-Upgrading ACPI tables via initrd
-================================
-
-1) Introduction (What is this about)
-2) What is this for
-3) How does it work
-4) References (Where to retrieve userspace tools)
-
-1) What is this about
----------------------
-
-If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
-upgrade the ACPI execution environment that is defined by the ACPI tables
-via upgrading the ACPI tables provided by the BIOS with an instrumented,
-modified, more recent version one, or installing brand new ACPI tables.
-
-When building initrd with kernel in a single image, option
-ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
-feature to work.
-
-For a full list of ACPI tables that can be upgraded/installed, take a look
-at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
-drivers/acpi/tables.c.
-All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
-be overridable, except:
-   - ACPI_SIG_RSDP (has a signature of 6 bytes)
-   - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
-Both could get implemented as well.
-
-
-2) What is this for
--------------------
-
-Complain to your platform/BIOS vendor if you find a bug which is so severe
-that a workaround is not accepted in the Linux kernel. And this facility
-allows you to upgrade the buggy tables before your platform/BIOS vendor
-releases an upgraded BIOS binary.
-
-This facility can be used by platform/BIOS vendors to provide a Linux
-compatible environment without modifying the underlying platform firmware.
-
-This facility also provides a powerful feature to easily debug and test
-ACPI BIOS table compatibility with the Linux kernel by modifying old
-platform provided ACPI tables or inserting new ACPI tables.
-
-It can and should be enabled in any kernel because there is no functional
-change with not instrumented initrds.
-
-
-3) How does it work
--------------------
-
-# Extract the machine's ACPI tables:
-cd /tmp
-acpidump >acpidump
-acpixtract -a acpidump
-# Disassemble, modify and recompile them:
-iasl -d *.dat
-# For example add this statement into a _PRT (PCI Routing Table) function
-# of the DSDT:
-Store("HELLO WORLD", debug)
-# And increase the OEM Revision. For example, before modification:
-DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
-# After modification:
-DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
-iasl -sa dsdt.dsl
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the cpio
-# archive. Note that if the table put here matches a platform table
-# (similar Table Signature, and similar OEMID, and similar OEM Table ID)
-# with a more recent OEM Revision, the platform table will be upgraded by
-# this table. If the table put here doesn't match a platform table
-# (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
-# ID), this table will be appended.
-mkdir -p kernel/firmware/acpi
-cp dsdt.aml kernel/firmware/acpi
-# A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
-# (see osl.c):
-iasl -sa facp.dsl
-iasl -sa ssdt1.dsl
-cp facp.aml kernel/firmware/acpi
-cp ssdt1.aml kernel/firmware/acpi
-# The uncompressed cpio archive must be the first. Other, typically
-# compressed cpio archives, must be concatenated on top of the uncompressed
-# one. Following command creates the uncompressed cpio archive and
-# concatenates the original initrd on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
-# reboot with increased acpi debug level, e.g. boot params:
-acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
-# and check your syslog:
-[    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-[    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
-
-iasl is able to disassemble and recompile quite a lot different,
-also static ACPI tables.
-
-
-4) Where to retrieve userspace tools
-------------------------------------
-
-iasl and acpixtract are part of Intel's ACPICA project:
-http://acpica.org/
-and should be packaged by distributions (for example in the acpica package
-on SUSE).
-
-acpidump can be found in Len Browns pmtools:
-ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
-This tool is also part of the acpica package on SUSE.
-Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
-/sys/firmware/acpi/tables
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 3e041206089d..09e4e81e4fb7 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -8,3 +8,4 @@ the Linux ACPI support.
 .. toctree::
    :maxdepth: 1
 
+   initrd_table_override
diff --git a/Documentation/admin-guide/acpi/initrd_table_override.rst b/Documentation/admin-guide/acpi/initrd_table_override.rst
new file mode 100644
index 000000000000..cbd768207631
--- /dev/null
+++ b/Documentation/admin-guide/acpi/initrd_table_override.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Upgrading ACPI tables via initrd
+================================
+
+What is this about
+==================
+
+If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
+upgrade the ACPI execution environment that is defined by the ACPI tables
+via upgrading the ACPI tables provided by the BIOS with an instrumented,
+modified, more recent version one, or installing brand new ACPI tables.
+
+When building initrd with kernel in a single image, option
+ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
+feature to work.
+
+For a full list of ACPI tables that can be upgraded/installed, take a look
+at the char `*table_sigs[MAX_ACPI_SIGNATURE];` definition in
+drivers/acpi/tables.c.
+
+All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
+be overridable, except:
+
+  - ACPI_SIG_RSDP (has a signature of 6 bytes)
+  - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
+
+Both could get implemented as well.
+
+
+What is this for
+================
+
+Complain to your platform/BIOS vendor if you find a bug which is so severe
+that a workaround is not accepted in the Linux kernel. And this facility
+allows you to upgrade the buggy tables before your platform/BIOS vendor
+releases an upgraded BIOS binary.
+
+This facility can be used by platform/BIOS vendors to provide a Linux
+compatible environment without modifying the underlying platform firmware.
+
+This facility also provides a powerful feature to easily debug and test
+ACPI BIOS table compatibility with the Linux kernel by modifying old
+platform provided ACPI tables or inserting new ACPI tables.
+
+It can and should be enabled in any kernel because there is no functional
+change with not instrumented initrds.
+
+
+How does it work
+================
+::
+
+  # Extract the machine's ACPI tables:
+  cd /tmp
+  acpidump >acpidump
+  acpixtract -a acpidump
+  # Disassemble, modify and recompile them:
+  iasl -d *.dat
+  # For example add this statement into a _PRT (PCI Routing Table) function
+  # of the DSDT:
+  Store("HELLO WORLD", debug)
+  # And increase the OEM Revision. For example, before modification:
+  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
+  # After modification:
+  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
+  iasl -sa dsdt.dsl
+  # Add the raw ACPI tables to an uncompressed cpio archive.
+  # They must be put into a /kernel/firmware/acpi directory inside the cpio
+  # archive. Note that if the table put here matches a platform table
+  # (similar Table Signature, and similar OEMID, and similar OEM Table ID)
+  # with a more recent OEM Revision, the platform table will be upgraded by
+  # this table. If the table put here doesn't match a platform table
+  # (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
+  # ID), this table will be appended.
+  mkdir -p kernel/firmware/acpi
+  cp dsdt.aml kernel/firmware/acpi
+  # A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
+  # (see osl.c):
+  iasl -sa facp.dsl
+  iasl -sa ssdt1.dsl
+  cp facp.aml kernel/firmware/acpi
+  cp ssdt1.aml kernel/firmware/acpi
+  # The uncompressed cpio archive must be the first. Other, typically
+  # compressed cpio archives, must be concatenated on top of the uncompressed
+  # one. Following command creates the uncompressed cpio archive and
+  # concatenates the original initrd on top:
+  find kernel | cpio -H newc --create > /boot/instrumented_initrd
+  cat /boot/initrd >>/boot/instrumented_initrd
+  # reboot with increased acpi debug level, e.g. boot params:
+  acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
+  # and check your syslog:
+  [    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
+  [    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
+
+iasl is able to disassemble and recompile quite a lot different,
+also static ACPI tables.
+
+
+Where to retrieve userspace tools
+=================================
+
+iasl and acpixtract are part of Intel's ACPICA project:
+http://acpica.org/
+
+and should be packaged by distributions (for example in the acpica package
+on SUSE).
+
+acpidump can be found in Len Browns pmtools:
+ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
+
+This tool is also part of the acpica package on SUSE.
+Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
+/sys/firmware/acpi/tables
-- 
2.20.1

