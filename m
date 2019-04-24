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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E81C282E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C9220685
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHinug9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C9220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q7Tv3nVvzDqDS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:03:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHinug9L"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7HB5YXMzDqM9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:54:14 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id x15so5292216pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rq1wv0XleqMLaQk/DvYLyBDyvcsGxkYL4gSDmu0O+L0=;
 b=JHinug9LTOQiC9sPOrjmIXrXarpIbiG3f9n9CoN3YGxABh1PGEQo5DFVrYcBO2odUL
 uhcxugakrgbUwOtc9WlkO5lr/9iI9RJC5qAM+L0ga+PLtztJmuk503sTCwawimeEudOJ
 4QzzdCEYghieVl60e9L0VMRuDNF7QPm5yBvV6SPQJgUc/jAX6B8L6LBdxqz3E1gkRofs
 yG6Vm5lI5CZcnKtSl+CQ0OEpEmFDDra688JtR6lw3rpOapUpwIM1JAskMhMMVFpXArGD
 TaZUBj9X2EVxboxvpzLQs7SWlsy6LUw0dUWx6H1oAXlSz9MGkXix1nUbuBl1kaCY+hdL
 cWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rq1wv0XleqMLaQk/DvYLyBDyvcsGxkYL4gSDmu0O+L0=;
 b=mYAPyDn8xZdua9ob7Ol2N4Ysk4Z8XYnNS8pK+reOww6dbnN7idF+wUcoQnejBjOXvb
 i8bar8oE57HzjRsqldA0m9AfPHKwvGD1KGHgt9oDO3t87DTGjrYAVKFo9KPjViwpqZmz
 CJASgj9k/Y/SoH9Yxntu9/hXuZADCQNMMlMFaf4CUARzLHcgwfRS4qDPCH/YzofzLIuk
 v9TIcPhyES9gwoIC9etRJC+/iUxgYAfz6k9MdHDAUz18QV48hEMdj45t4jHpmVFSNL2Y
 IZTLy0xuKowUNkjX5p8hGPlgAajC4z/02xda1/cdrO8wYmEs1BwCzqC28qRLE2XgtZWF
 bmWA==
X-Gm-Message-State: APjAAAUJnlMz5LdFThCuj4bA2eZl4v55ilqIJEHrZEbuhF3+uhw6kWyR
 0H2j9G0jy1RZlhezPPBKYME=
X-Google-Smtp-Source: APXvYqzVSkdlB/PLLSoefSrSiGJSkryEqE6leG+aCKzIfV4isPioKhPaPzS/okcKf0lWbcX+BJ5tdQ==
X-Received: by 2002:a17:902:8a8b:: with SMTP id
 p11mr8080679plo.207.1556128451946; 
 Wed, 24 Apr 2019 10:54:11 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.54.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:54:10 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 01/23] Documentation: ACPI: move namespace.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:52:44 +0800
Message-Id: <20190424175306.25880-2-changbin.du@gmail.com>
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
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 .../acpi/namespace.rst}                       | 294 +++++++++---------
 2 files changed, 154 insertions(+), 141 deletions(-)
 rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (56%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 0ec7d072ba22..210ad8acd6df 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -7,3 +7,4 @@ ACPI Support
 .. toctree::
    :maxdepth: 1
 
+   namespace
diff --git a/Documentation/acpi/namespace.txt b/Documentation/firmware-guide/acpi/namespace.rst
similarity index 56%
rename from Documentation/acpi/namespace.txt
rename to Documentation/firmware-guide/acpi/namespace.rst
index 1860cb3865c6..835521baeb89 100644
--- a/Documentation/acpi/namespace.txt
+++ b/Documentation/firmware-guide/acpi/namespace.rst
@@ -1,85 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===================================================
 ACPI Device Tree - Representation of ACPI Namespace
+===================================================
 
-Copyright (C) 2013, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+:Copyright: |copy| 2013, Intel Corporation
 
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Abstract:
+:Credit:   Thanks for the help from Zhang Rui <rui.zhang@intel.com> and
+           Rafael J.Wysocki <rafael.j.wysocki@intel.com>.
 
+Abstract
+========
 The Linux ACPI subsystem converts ACPI namespace objects into a Linux
 device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
-receiving ACPI hotplug notification events.  For each device object in this
-hierarchy there is a corresponding symbolic link in the
+receiving ACPI hotplug notification events.  For each device object
+in this hierarchy there is a corresponding symbolic link in the
 /sys/bus/acpi/devices.
+
 This document illustrates the structure of the ACPI device tree.
 
+ACPI Definition Blocks
+======================
+
+The ACPI firmware sets up RSDP (Root System Description Pointer) in the
+system memory address space pointing to the XSDT (Extended System
+Description Table).  The XSDT always points to the FADT (Fixed ACPI
+Description Table) using its first entry, the data within the FADT
+includes various fixed-length entries that describe fixed ACPI features
+of the hardware.  The FADT contains a pointer to the DSDT
+(Differentiated System Descripition Table).  The XSDT also contains
+entries pointing to possibly multiple SSDTs (Secondary System
+Description Table).
+
+The DSDT and SSDT data is organized in data structures called definition
+blocks that contain definitions of various objects, including ACPI
+control methods, encoded in AML (ACPI Machine Language).  The data block
+of the DSDT along with the contents of SSDTs represents a hierarchical
+data structure called the ACPI namespace whose topology reflects the
+structure of the underlying hardware platform.
+
+The relationships between ACPI System Definition Tables described above
+are illustrated in the following diagram::
+
+   +---------+    +-------+    +--------+    +------------------------+
+   |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
+   +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
+   | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
+   +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
+   | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
+   +---------+    +-------+    +--------+    |  +-------------------+ |
+                  | Entry |------------------|->|       SSDT        | |
+                  +- - - -+                  |  +-------------------| |
+                  | Entry | - - - - - - - -+ |  | Definition Blocks | |
+                  +- - - -+                | |  +-------------------+ |
+                                          | |  +- - - - - - - - - -+ |
+                                          +-|->|       SSDT        | |
+                                             |  +-------------------+ |
+                                             |  | Definition Blocks | |
+                                             |  +- - - - - - - - - -+ |
+                                             +------------------------+
+                                                         |
+                                             OSPM Loading |
+                                                         \|/
+                                                   +----------------+
+                                                   | ACPI Namespace |
+                                                   +----------------+
+
+                  Figure 1. ACPI Definition Blocks
+
+.. note:: RSDP can also contain a pointer to the RSDT (Root System
+   Description Table).  Platforms provide RSDT to enable
+   compatibility with ACPI 1.0 operating systems.  The OS is expected
+   to use XSDT, if present.
+
+
+Example ACPI Namespace
+======================
+
+All definition blocks are loaded into a single namespace.  The namespace
+is a hierarchy of objects identified by names and paths.
+The following naming conventions apply to object names in the ACPI
+namespace:
 
-Credit:
-
-Thanks for the help from Zhang Rui <rui.zhang@intel.com> and Rafael J.
-Wysocki <rafael.j.wysocki@intel.com>.
-
-
-1. ACPI Definition Blocks
-
-   The ACPI firmware sets up RSDP (Root System Description Pointer) in the
-   system memory address space pointing to the XSDT (Extended System
-   Description Table).  The XSDT always points to the FADT (Fixed ACPI
-   Description Table) using its first entry, the data within the FADT
-   includes various fixed-length entries that describe fixed ACPI features
-   of the hardware.  The FADT contains a pointer to the DSDT
-   (Differentiated System Descripition Table).  The XSDT also contains
-   entries pointing to possibly multiple SSDTs (Secondary System
-   Description Table).
-
-   The DSDT and SSDT data is organized in data structures called definition
-   blocks that contain definitions of various objects, including ACPI
-   control methods, encoded in AML (ACPI Machine Language).  The data block
-   of the DSDT along with the contents of SSDTs represents a hierarchical
-   data structure called the ACPI namespace whose topology reflects the
-   structure of the underlying hardware platform.
-
-   The relationships between ACPI System Definition Tables described above
-   are illustrated in the following diagram.
-
-     +---------+    +-------+    +--------+    +------------------------+
-     |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
-     +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
-     | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
-     +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
-     | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
-     +---------+    +-------+    +--------+    |  +-------------------+ |
-                    | Entry |------------------|->|       SSDT        | |
-                    +- - - -+                  |  +-------------------| |
-                    | Entry | - - - - - - - -+ |  | Definition Blocks | |
-                    +- - - -+                | |  +-------------------+ |
-                                             | |  +- - - - - - - - - -+ |
-                                             +-|->|       SSDT        | |
-                                               |  +-------------------+ |
-                                               |  | Definition Blocks | |
-                                               |  +- - - - - - - - - -+ |
-                                               +------------------------+
-                                                           |
-                                              OSPM Loading |
-                                                          \|/
-                                                    +----------------+
-                                                    | ACPI Namespace |
-                                                    +----------------+
-
-                     Figure 1. ACPI Definition Blocks
-
-   NOTE: RSDP can also contain a pointer to the RSDT (Root System
-         Description Table).  Platforms provide RSDT to enable
-         compatibility with ACPI 1.0 operating systems.  The OS is expected
-         to use XSDT, if present.
-
-
-2. Example ACPI Namespace
-
-   All definition blocks are loaded into a single namespace.  The namespace
-   is a hierarchy of objects identified by names and paths.
-   The following naming conventions apply to object names in the ACPI
-   namespace:
    1. All names are 32 bits long.
    2. The first byte of a name must be one of 'A' - 'Z', '_'.
    3. Each of the remaining bytes of a name must be one of 'A' - 'Z', '0'
@@ -91,7 +96,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
       (i.e. names prepended with '^' are relative to the parent of the
       current namespace node).
 
-   The figure below shows an example ACPI namespace.
+The figure below shows an example ACPI namespace::
 
    +------+
    | \    |                     Root
@@ -184,19 +189,20 @@ Wysocki <rafael.j.wysocki@intel.com>.
                      Figure 2. Example ACPI Namespace
 
 
-3. Linux ACPI Device Objects
+Linux ACPI Device Objects
+=========================
 
-   The Linux kernel's core ACPI subsystem creates struct acpi_device
-   objects for ACPI namespace objects representing devices, power resources
-   processors, thermal zones.  Those objects are exported to user space via
-   sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
-   format of their names is <bus_id:instance>, where 'bus_id' refers to the
-   ACPI namespace representation of the given object and 'instance' is used
-   for distinguishing different object of the same 'bus_id' (it is
-   two-digit decimal representation of an unsigned integer).
+The Linux kernel's core ACPI subsystem creates struct acpi_device
+objects for ACPI namespace objects representing devices, power resources
+processors, thermal zones.  Those objects are exported to user space via
+sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
+format of their names is <bus_id:instance>, where 'bus_id' refers to the
+ACPI namespace representation of the given object and 'instance' is used
+for distinguishing different object of the same 'bus_id' (it is
+two-digit decimal representation of an unsigned integer).
 
-   The value of 'bus_id' depends on the type of the object whose name it is
-   part of as listed in the table below.
+The value of 'bus_id' depends on the type of the object whose name it is
+part of as listed in the table below::
 
                 +---+-----------------+-------+----------+
                 |   | Object/Feature  | Table | bus_id   |
@@ -226,10 +232,11 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
                  Table 1. ACPI Namespace Objects Mapping
 
-   The following rules apply when creating struct acpi_device objects on
-   the basis of the contents of ACPI System Description Tables (as
-   indicated by the letter in the first column and the notation in the
-   second column of the table above):
+The following rules apply when creating struct acpi_device objects on
+the basis of the contents of ACPI System Description Tables (as
+indicated by the letter in the first column and the notation in the
+second column of the table above):
+
    N:
       The object's source is an ACPI namespace node (as indicated by the
       named object's type in the second column).  In that case the object's
@@ -249,13 +256,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
       struct acpi_device object with LNXVIDEO 'bus_id' will be created for
       it.
 
-   The third column of the above table indicates which ACPI System
-   Description Tables contain information used for the creation of the
-   struct acpi_device objects represented by the given row (xSDT means DSDT
-   or SSDT).
+The third column of the above table indicates which ACPI System
+Description Tables contain information used for the creation of the
+struct acpi_device objects represented by the given row (xSDT means DSDT
+or SSDT).
+
+The forth column of the above table indicates the 'bus_id' generation
+rule of the struct acpi_device object:
 
-   The forth column of the above table indicates the 'bus_id' generation
-   rule of the struct acpi_device object:
    _HID:
       _HID in the last column of the table means that the object's bus_id
       is derived from the _HID/_CID identification objects present under
@@ -275,45 +283,47 @@ Wysocki <rafael.j.wysocki@intel.com>.
       object's bus_id.
 
 
-4. Linux ACPI Physical Device Glue
-
-   ACPI device (i.e. struct acpi_device) objects may be linked to other
-   objects in the Linux' device hierarchy that represent "physical" devices
-   (for example, devices on the PCI bus).  If that happens, it means that
-   the ACPI device object is a "companion" of a device otherwise
-   represented in a different way and is used (1) to provide configuration
-   information on that device which cannot be obtained by other means and
-   (2) to do specific things to the device with the help of its ACPI
-   control methods.  One ACPI device object may be linked this way to
-   multiple "physical" devices.
-
-   If an ACPI device object is linked to a "physical" device, its sysfs
-   directory contains the "physical_node" symbolic link to the sysfs
-   directory of the target device object.  In turn, the target device's
-   sysfs directory will then contain the "firmware_node" symbolic link to
-   the sysfs directory of the companion ACPI device object.
-   The linking mechanism relies on device identification provided by the
-   ACPI namespace.  For example, if there's an ACPI namespace object
-   representing a PCI device (i.e. a device object under an ACPI namespace
-   object representing a PCI bridge) whose _ADR returns 0x00020000 and the
-   bus number of the parent PCI bridge is 0, the sysfs directory
-   representing the struct acpi_device object created for that ACPI
-   namespace object will contain the 'physical_node' symbolic link to the
-   /sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
-   corresponding PCI device.
-
-   The linking mechanism is generally bus-specific.  The core of its
-   implementation is located in the drivers/acpi/glue.c file, but there are
-   complementary parts depending on the bus types in question located
-   elsewhere.  For example, the PCI-specific part of it is located in
-   drivers/pci/pci-acpi.c.
-
-
-5. Example Linux ACPI Device Tree
-
-   The sysfs hierarchy of struct acpi_device objects corresponding to the
-   example ACPI namespace illustrated in Figure 2 with the addition of
-   fixed PWR_BUTTON/SLP_BUTTON devices is shown below.
+Linux ACPI Physical Device Glue
+===============================
+
+ACPI device (i.e. struct acpi_device) objects may be linked to other
+objects in the Linux' device hierarchy that represent "physical" devices
+(for example, devices on the PCI bus).  If that happens, it means that
+the ACPI device object is a "companion" of a device otherwise
+represented in a different way and is used (1) to provide configuration
+information on that device which cannot be obtained by other means and
+(2) to do specific things to the device with the help of its ACPI
+control methods.  One ACPI device object may be linked this way to
+multiple "physical" devices.
+
+If an ACPI device object is linked to a "physical" device, its sysfs
+directory contains the "physical_node" symbolic link to the sysfs
+directory of the target device object.  In turn, the target device's
+sysfs directory will then contain the "firmware_node" symbolic link to
+the sysfs directory of the companion ACPI device object.
+The linking mechanism relies on device identification provided by the
+ACPI namespace.  For example, if there's an ACPI namespace object
+representing a PCI device (i.e. a device object under an ACPI namespace
+object representing a PCI bridge) whose _ADR returns 0x00020000 and the
+bus number of the parent PCI bridge is 0, the sysfs directory
+representing the struct acpi_device object created for that ACPI
+namespace object will contain the 'physical_node' symbolic link to the
+/sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
+corresponding PCI device.
+
+The linking mechanism is generally bus-specific.  The core of its
+implementation is located in the drivers/acpi/glue.c file, but there are
+complementary parts depending on the bus types in question located
+elsewhere.  For example, the PCI-specific part of it is located in
+drivers/pci/pci-acpi.c.
+
+
+Example Linux ACPI Device Tree
+=================================
+
+The sysfs hierarchy of struct acpi_device objects corresponding to the
+example ACPI namespace illustrated in Figure 2 with the addition of
+fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
 
    +--------------+---+-----------------+
    | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
@@ -377,12 +387,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
                   Figure 3. Example Linux ACPI Device Tree
 
-   NOTE: Each node is represented as "object/path/modalias", where:
-         1. 'object' is the name of the object's directory in sysfs.
-         2. 'path' is the ACPI namespace path of the corresponding
-            ACPI namespace object, as returned by the object's 'path'
-            sysfs attribute.
-         3. 'modalias' is the value of the object's 'modalias' sysfs
-            attribute (as described earlier in this document).
-   NOTE: N/A indicates the device object does not have the 'path' or the
-         'modalias' attribute.
+.. note:: Each node is represented as "object/path/modalias", where:
+
+   1. 'object' is the name of the object's directory in sysfs.
+   2. 'path' is the ACPI namespace path of the corresponding
+      ACPI namespace object, as returned by the object's 'path'
+      sysfs attribute.
+   3. 'modalias' is the value of the object's 'modalias' sysfs
+      attribute (as described earlier in this document).
+
+.. note:: N/A indicates the device object does not have the 'path' or the
+   'modalias' attribute.
-- 
2.20.1

