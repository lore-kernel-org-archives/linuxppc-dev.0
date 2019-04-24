Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2969FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:47:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A942208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbxs5j9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A942208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8S15tnqzDqbB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:46:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sbxs5j9Z"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7L84wtbzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:56:48 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 188so9689792pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eQK94c4zZAtumhgmTwNsNEW3BA1lT2WXfVq6QQQWN4U=;
 b=Sbxs5j9ZJo7feMnOIcXbCdmQhcefg6Qmt0SMlqvRB/451i8yO8Xyg8UNTdPsfWT5Bg
 m3VERGYXAsfrBlCXNtusOubVe9ng2WeYzZSboCySDR4YDO2arGGGZTtLvrDJKDrsUYUD
 8eq1nGk9oXnaU2FNGyviNTJsVj65Wxz0CyH2D5MmCpq+1SxurZGb6v+wMeh/tqpl1LFc
 D1w8E5nGt0DoUY7xem6RooL3vmmpzSLEO91aSY8i8QP+2FFeMkT7bx3BFkIoLZR3z+5v
 dbkCu4VdVkgn6wfY0WCVbaNWCkYbcNZ6um97z35CHILNYEOI39DjV708i0Y2GptbTN5l
 T5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eQK94c4zZAtumhgmTwNsNEW3BA1lT2WXfVq6QQQWN4U=;
 b=e1IA1oFNnauoaoxSQM1SxARlYxXB9MWcy7jTBzCIEbV48oRg96Png94d5yM+5N+zOs
 gxAFArmXFxc1sN8qH0Uj6kP8Q/YLc9gWbARoEp4/hDTNhR/X0cvXOuDrh9UuftLdXdkT
 cVO8nPcxopJdwc0BpF1vvJ8W5M9GZ9zMR84XUQdvFUyoDJSrVSztd1BRV1Dl8neYNmel
 uvUKD05DawDyUdT1scGYd09ZYmNDnPKuREXchaqx5cAHzDN+qQloi9UfNZjjMoOKpHCF
 /hEc9RbBT2MxOOZ12+BIkizODLE2HlhZokJX9GdxhB+JCDx8ZbZVe58+QyyE0j/KW++D
 XokQ==
X-Gm-Message-State: APjAAAU2OZggzqdSbU9gurs/rSebCTQfHmZGmsi4KABvaMqqcKaVh56v
 vhY6ky4O+378Is8vRYUFGxE=
X-Google-Smtp-Source: APXvYqw5JvzmLHXUBQgHkikki7Z/pVCZwcQADdORxgcI8QG4ZtpjVONHeDnqeFvPXYmaspIDytfyNA==
X-Received: by 2002:a65:4183:: with SMTP id a3mr31950284pgq.121.1556128606477; 
 Wed, 24 Apr 2019 10:56:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:56:45 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 22/23] Documentation: ACPI: move ssdt-overlays.txt to
 admin-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:53:05 +0800
Message-Id: <20190424175306.25880-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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
 Documentation/acpi/ssdt-overlays.txt          | 172 -----------------
 Documentation/admin-guide/acpi/index.rst      |   1 +
 .../admin-guide/acpi/ssdt-overlays.rst        | 180 ++++++++++++++++++
 3 files changed, 181 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 create mode 100644 Documentation/admin-guide/acpi/ssdt-overlays.rst

diff --git a/Documentation/acpi/ssdt-overlays.txt b/Documentation/acpi/ssdt-overlays.txt
deleted file mode 100644
index 5ae13f161ea2..000000000000
--- a/Documentation/acpi/ssdt-overlays.txt
+++ /dev/null
@@ -1,172 +0,0 @@
-
-In order to support ACPI open-ended hardware configurations (e.g. development
-boards) we need a way to augment the ACPI configuration provided by the firmware
-image. A common example is connecting sensors on I2C / SPI buses on development
-boards.
-
-Although this can be accomplished by creating a kernel platform driver or
-recompiling the firmware image with updated ACPI tables, neither is practical:
-the former proliferates board specific kernel code while the latter requires
-access to firmware tools which are often not publicly available.
-
-Because ACPI supports external references in AML code a more practical
-way to augment firmware ACPI configuration is by dynamically loading
-user defined SSDT tables that contain the board specific information.
-
-For example, to enumerate a Bosch BMA222E accelerometer on the I2C bus of the
-Minnowboard MAX development board exposed via the LSE connector [1], the
-following ASL code can be used:
-
-DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
-{
-    External (\_SB.I2C6, DeviceObj)
-
-    Scope (\_SB.I2C6)
-    {
-        Device (STAC)
-        {
-            Name (_ADR, Zero)
-            Name (_HID, "BMA222E")
-
-            Method (_CRS, 0, Serialized)
-            {
-                Name (RBUF, ResourceTemplate ()
-                {
-                    I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
-                                  AddressingMode7Bit, "\\_SB.I2C6", 0x00,
-                                  ResourceConsumer, ,)
-                    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
-                             "\\_SB.GPO2", 0x00, ResourceConsumer, , )
-                    { // Pin list
-                        0
-                    }
-                })
-                Return (RBUF)
-            }
-        }
-    }
-}
-
-which can then be compiled to AML binary format:
-
-$ iasl minnowmax.asl
-
-Intel ACPI Component Architecture
-ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
-Copyright (c) 2000 - 2014 Intel Corporation
-
-ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
-AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
-
-[1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
-
-The resulting AML code can then be loaded by the kernel using one of the methods
-below.
-
-== Loading ACPI SSDTs from initrd ==
-
-This option allows loading of user defined SSDTs from initrd and it is useful
-when the system does not support EFI or when there is not enough EFI storage.
-
-It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
-aml code must be placed in the first, uncompressed, initrd under the
-"kernel/firmware/acpi" path. Multiple files can be used and this will translate
-in loading multiple tables. Only SSDT and OEM tables are allowed. See
-initrd_table_override.txt for more details.
-
-Here is an example:
-
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the
-# cpio archive.
-# The uncompressed cpio archive must be the first.
-# Other, typically compressed cpio archives, must be
-# concatenated on top of the uncompressed one.
-mkdir -p kernel/firmware/acpi
-cp ssdt.aml kernel/firmware/acpi
-
-# Create the uncompressed cpio archive and concatenate the original initrd
-# on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
-
-== Loading ACPI SSDTs from EFI variables ==
-
-This is the preferred method, when EFI is supported on the platform, because it
-allows a persistent, OS independent way of storing the user defined SSDTs. There
-is also work underway to implement EFI support for loading user defined SSDTs
-and using this method will make it easier to convert to the EFI loading
-mechanism when that will arrive.
-
-In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
-parameter can be used. The argument for the option is the variable name to
-use. If there are multiple variables with the same name but with different
-vendor GUIDs, all of them will be loaded.
-
-In order to store the AML code in an EFI variable the efivarfs filesystem can be
-used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
-recent distribution.
-
-Creating a new file in /sys/firmware/efi/efivars will automatically create a new
-EFI variable. Updating a file in /sys/firmware/efi/efivars will update the EFI
-variable. Please note that the file name needs to be specially formatted as
-"Name-GUID" and that the first 4 bytes in the file (little-endian format)
-represent the attributes of the EFI variable (see EFI_VARIABLE_MASK in
-include/linux/efi.h). Writing to the file must also be done with one write
-operation.
-
-For example, you can use the following bash script to create/update an EFI
-variable with the content from a given file:
-
-#!/bin/sh -e
-
-while ! [ -z "$1" ]; do
-        case "$1" in
-        "-f") filename="$2"; shift;;
-        "-g") guid="$2"; shift;;
-        *) name="$1";;
-        esac
-        shift
-done
-
-usage()
-{
-        echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
-        exit 1
-}
-
-[ -n "$name" -a -f "$filename" ] || usage
-
-EFIVARFS="/sys/firmware/efi/efivars"
-
-[ -d "$EFIVARFS" ] || exit 2
-
-if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
-        mount -t efivarfs none $EFIVARFS
-fi
-
-# try to pick up an existing GUID
-[ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
-
-# use a randomly generated GUID
-[ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
-
-# efivarfs expects all of the data in one write
-tmp=$(mktemp)
-/bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
-dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
-rm $tmp
-
-== Loading ACPI SSDTs from configfs ==
-
-This option allows loading of user defined SSDTs from userspace via the configfs
-interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
-mounted. In the following examples, we assume that configfs has been mounted in
-/config.
-
-New tables can be loading by creating new directories in /config/acpi/table/ and
-writing the SSDT aml code in the aml attribute:
-
-cd /config/acpi/table
-mkdir my_ssdt
-cat ~/ssdt.aml > my_ssdt/aml
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 9049a7b9f065..4d13eeea1eca 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -10,4 +10,5 @@ the Linux ACPI support.
 
    initrd_table_override
    dsdt-override
+   ssdt-overlays
    cppc_sysfs
diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
new file mode 100644
index 000000000000..da37455f96c9
--- /dev/null
+++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+SSDT Overlays
+=============
+
+In order to support ACPI open-ended hardware configurations (e.g. development
+boards) we need a way to augment the ACPI configuration provided by the firmware
+image. A common example is connecting sensors on I2C / SPI buses on development
+boards.
+
+Although this can be accomplished by creating a kernel platform driver or
+recompiling the firmware image with updated ACPI tables, neither is practical:
+the former proliferates board specific kernel code while the latter requires
+access to firmware tools which are often not publicly available.
+
+Because ACPI supports external references in AML code a more practical
+way to augment firmware ACPI configuration is by dynamically loading
+user defined SSDT tables that contain the board specific information.
+
+For example, to enumerate a Bosch BMA222E accelerometer on the I2C bus of the
+Minnowboard MAX development board exposed via the LSE connector [1], the
+following ASL code can be used::
+
+    DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
+    {
+        External (\_SB.I2C6, DeviceObj)
+
+        Scope (\_SB.I2C6)
+        {
+            Device (STAC)
+            {
+                Name (_ADR, Zero)
+                Name (_HID, "BMA222E")
+
+                Method (_CRS, 0, Serialized)
+                {
+                    Name (RBUF, ResourceTemplate ()
+                    {
+                        I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
+                                    AddressingMode7Bit, "\\_SB.I2C6", 0x00,
+                                    ResourceConsumer, ,)
+                        GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
+                                "\\_SB.GPO2", 0x00, ResourceConsumer, , )
+                        { // Pin list
+                            0
+                        }
+                    })
+                    Return (RBUF)
+                }
+            }
+        }
+    }
+
+which can then be compiled to AML binary format::
+
+    $ iasl minnowmax.asl
+
+    Intel ACPI Component Architecture
+    ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
+    Copyright (c) 2000 - 2014 Intel Corporation
+
+    ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
+    AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
+
+[1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
+
+The resulting AML code can then be loaded by the kernel using one of the methods
+below.
+
+Loading ACPI SSDTs from initrd
+==============================
+
+This option allows loading of user defined SSDTs from initrd and it is useful
+when the system does not support EFI or when there is not enough EFI storage.
+
+It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
+aml code must be placed in the first, uncompressed, initrd under the
+"kernel/firmware/acpi" path. Multiple files can be used and this will translate
+in loading multiple tables. Only SSDT and OEM tables are allowed. See
+initrd_table_override.txt for more details.
+
+Here is an example::
+
+    # Add the raw ACPI tables to an uncompressed cpio archive.
+    # They must be put into a /kernel/firmware/acpi directory inside the
+    # cpio archive.
+    # The uncompressed cpio archive must be the first.
+    # Other, typically compressed cpio archives, must be
+    # concatenated on top of the uncompressed one.
+    mkdir -p kernel/firmware/acpi
+    cp ssdt.aml kernel/firmware/acpi
+
+    # Create the uncompressed cpio archive and concatenate the original initrd
+    # on top:
+    find kernel | cpio -H newc --create > /boot/instrumented_initrd
+    cat /boot/initrd >>/boot/instrumented_initrd
+
+Loading ACPI SSDTs from EFI variables
+=====================================
+
+This is the preferred method, when EFI is supported on the platform, because it
+allows a persistent, OS independent way of storing the user defined SSDTs. There
+is also work underway to implement EFI support for loading user defined SSDTs
+and using this method will make it easier to convert to the EFI loading
+mechanism when that will arrive.
+
+In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
+parameter can be used. The argument for the option is the variable name to
+use. If there are multiple variables with the same name but with different
+vendor GUIDs, all of them will be loaded.
+
+In order to store the AML code in an EFI variable the efivarfs filesystem can be
+used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
+recent distribution.
+
+Creating a new file in /sys/firmware/efi/efivars will automatically create a new
+EFI variable. Updating a file in /sys/firmware/efi/efivars will update the EFI
+variable. Please note that the file name needs to be specially formatted as
+"Name-GUID" and that the first 4 bytes in the file (little-endian format)
+represent the attributes of the EFI variable (see EFI_VARIABLE_MASK in
+include/linux/efi.h). Writing to the file must also be done with one write
+operation.
+
+For example, you can use the following bash script to create/update an EFI
+variable with the content from a given file::
+
+    #!/bin/sh -e
+
+    while ! [ -z "$1" ]; do
+            case "$1" in
+            "-f") filename="$2"; shift;;
+            "-g") guid="$2"; shift;;
+            *) name="$1";;
+            esac
+            shift
+    done
+
+    usage()
+    {
+            echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
+            exit 1
+    }
+
+    [ -n "$name" -a -f "$filename" ] || usage
+
+    EFIVARFS="/sys/firmware/efi/efivars"
+
+    [ -d "$EFIVARFS" ] || exit 2
+
+    if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
+            mount -t efivarfs none $EFIVARFS
+    fi
+
+    # try to pick up an existing GUID
+    [ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
+
+    # use a randomly generated GUID
+    [ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
+
+    # efivarfs expects all of the data in one write
+    tmp=$(mktemp)
+    /bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
+    dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
+    rm $tmp
+
+Loading ACPI SSDTs from configfs
+================================
+
+This option allows loading of user defined SSDTs from userspace via the configfs
+interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
+mounted. In the following examples, we assume that configfs has been mounted in
+/config.
+
+New tables can be loading by creating new directories in /config/acpi/table/ and
+writing the SSDT aml code in the aml attribute::
+
+    cd /config/acpi/table
+    mkdir my_ssdt
+    cat ~/ssdt.aml > my_ssdt/aml
-- 
2.20.1

