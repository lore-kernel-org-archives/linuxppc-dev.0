Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683AEC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:39:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D1A218D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YU5XMEa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D1A218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcKY6bXRzDqML
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:39:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="YU5XMEa5"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pZzt4HRTzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 06:39:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BByR9yyJAwnXTPmn4MXOjd0+RDZbkt0moyBPsmefhgc=; b=YU5XMEa5tl8V73FzVLU1H5T8Fh
 MQsC94ZVXyrMJMS29+Rv8EpArpyAIhJCEohg1KpUFIVZNA4SCiNhoGmcIobBi44D6dFnw7lV2wtLA
 pix8HGIjxh1qp9t0wtTgrklew6FdYUl3NXE4LPfVi8W+FVTrjln3trqUPXNeLB/p9Ws3OjAceJgFR
 Gw+Io4YA+cYWlO9qz5jI+N1zTOW4kLmXk/8l9WeQ0V29xY/RYb5tyPmUoU16lQF71T4PLv6Zr+Zjn
 e6pJq2A752seBvfP9ptVkd+diKGOv4iy1ZlJ20f9dd34tN6rXPSe60ZtqraBSOfwf6799urtdQ6nx
 z7bxOJyA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2Bi-0002Jt-7Z; Tue, 23 Apr 2019 20:38:46 +0000
Date: Tue, 23 Apr 2019 17:38:40 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 02/63] Documentation: ACPI: move namespace.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423173840.2e450b34@coco.lan>
In-Reply-To: <20190423162932.21428-3-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-3-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:31 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  .../acpi/namespace.rst}                       | 310 +++++++++---------
>  2 files changed, 161 insertions(+), 150 deletions(-)
>  rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (54%)
> 
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 0ec7d072ba22..210ad8acd6df 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -7,3 +7,4 @@ ACPI Support
>  .. toctree::
>     :maxdepth: 1
>  
> +   namespace
> diff --git a/Documentation/acpi/namespace.txt b/Documentation/firmware-guide/acpi/namespace.rst
> similarity index 54%
> rename from Documentation/acpi/namespace.txt
> rename to Documentation/firmware-guide/acpi/namespace.rst
> index 1860cb3865c6..443f0e5d0617 100644
> --- a/Documentation/acpi/namespace.txt
> +++ b/Documentation/firmware-guide/acpi/namespace.rst
> @@ -1,85 +1,88 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===================================================
>  ACPI Device Tree - Representation of ACPI Namespace
> +===================================================
> +
> +:Copyright: |copy| 2013, Intel Corporation
> +
> +:Author: Lv Zheng <lv.zheng@intel.com>
> +
> +:Abstract: The Linux ACPI subsystem converts ACPI namespace objects into a Linux
> +           device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
> +           receiving ACPI hotplug notification events.  For each device object
> +           in this hierarchy there is a corresponding symbolic link in the
> +           /sys/bus/acpi/devices.
> +           This document illustrates the structure of the ACPI device tree.

Well, this is a matter of preference. I would add Abstract as a chapter,
as this would make it part of the top index, with can be useful. 

In any case:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> +
> +:Credit:   Thanks for the help from Zhang Rui <rui.zhang@intel.com> and
> +           Rafael J.Wysocki <rafael.j.wysocki@intel.com>.
> +
> +
> +ACPI Definition Blocks
> +======================
> +
> +The ACPI firmware sets up RSDP (Root System Description Pointer) in the
> +system memory address space pointing to the XSDT (Extended System
> +Description Table).  The XSDT always points to the FADT (Fixed ACPI
> +Description Table) using its first entry, the data within the FADT
> +includes various fixed-length entries that describe fixed ACPI features
> +of the hardware.  The FADT contains a pointer to the DSDT
> +(Differentiated System Descripition Table).  The XSDT also contains
> +entries pointing to possibly multiple SSDTs (Secondary System
> +Description Table).
> +
> +The DSDT and SSDT data is organized in data structures called definition
> +blocks that contain definitions of various objects, including ACPI
> +control methods, encoded in AML (ACPI Machine Language).  The data block
> +of the DSDT along with the contents of SSDTs represents a hierarchical
> +data structure called the ACPI namespace whose topology reflects the
> +structure of the underlying hardware platform.
> +
> +The relationships between ACPI System Definition Tables described above
> +are illustrated in the following diagram::
> +
> +   +---------+    +-------+    +--------+    +------------------------+
> +   |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
> +   +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
> +   | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
> +   +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
> +   | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
> +   +---------+    +-------+    +--------+    |  +-------------------+ |
> +                  | Entry |------------------|->|       SSDT        | |
> +                  +- - - -+                  |  +-------------------| |
> +                  | Entry | - - - - - - - -+ |  | Definition Blocks | |
> +                  +- - - -+                | |  +-------------------+ |
> +                                          | |  +- - - - - - - - - -+ |
> +                                          +-|->|       SSDT        | |
> +                                             |  +-------------------+ |
> +                                             |  | Definition Blocks | |
> +                                             |  +- - - - - - - - - -+ |
> +                                             +------------------------+
> +                                                         |
> +                                             OSPM Loading |
> +                                                         \|/
> +                                                   +----------------+
> +                                                   | ACPI Namespace |
> +                                                   +----------------+
> +
> +                  Figure 1. ACPI Definition Blocks
> +
> +.. note:: RSDP can also contain a pointer to the RSDT (Root System
> +   Description Table).  Platforms provide RSDT to enable
> +   compatibility with ACPI 1.0 operating systems.  The OS is expected
> +   to use XSDT, if present.
> +
> +
> +Example ACPI Namespace
> +======================
> +
> +All definition blocks are loaded into a single namespace.  The namespace
> +is a hierarchy of objects identified by names and paths.
> +The following naming conventions apply to object names in the ACPI
> +namespace:
>  
> -Copyright (C) 2013, Intel Corporation
> -Author: Lv Zheng <lv.zheng@intel.com>
> -
> -
> -Abstract:
> -
> -The Linux ACPI subsystem converts ACPI namespace objects into a Linux
> -device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
> -receiving ACPI hotplug notification events.  For each device object in this
> -hierarchy there is a corresponding symbolic link in the
> -/sys/bus/acpi/devices.
> -This document illustrates the structure of the ACPI device tree.
> -
> -
> -Credit:
> -
> -Thanks for the help from Zhang Rui <rui.zhang@intel.com> and Rafael J.
> -Wysocki <rafael.j.wysocki@intel.com>.
> -
> -
> -1. ACPI Definition Blocks
> -
> -   The ACPI firmware sets up RSDP (Root System Description Pointer) in the
> -   system memory address space pointing to the XSDT (Extended System
> -   Description Table).  The XSDT always points to the FADT (Fixed ACPI
> -   Description Table) using its first entry, the data within the FADT
> -   includes various fixed-length entries that describe fixed ACPI features
> -   of the hardware.  The FADT contains a pointer to the DSDT
> -   (Differentiated System Descripition Table).  The XSDT also contains
> -   entries pointing to possibly multiple SSDTs (Secondary System
> -   Description Table).
> -
> -   The DSDT and SSDT data is organized in data structures called definition
> -   blocks that contain definitions of various objects, including ACPI
> -   control methods, encoded in AML (ACPI Machine Language).  The data block
> -   of the DSDT along with the contents of SSDTs represents a hierarchical
> -   data structure called the ACPI namespace whose topology reflects the
> -   structure of the underlying hardware platform.
> -
> -   The relationships between ACPI System Definition Tables described above
> -   are illustrated in the following diagram.
> -
> -     +---------+    +-------+    +--------+    +------------------------+
> -     |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
> -     +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
> -     | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
> -     +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
> -     | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
> -     +---------+    +-------+    +--------+    |  +-------------------+ |
> -                    | Entry |------------------|->|       SSDT        | |
> -                    +- - - -+                  |  +-------------------| |
> -                    | Entry | - - - - - - - -+ |  | Definition Blocks | |
> -                    +- - - -+                | |  +-------------------+ |
> -                                             | |  +- - - - - - - - - -+ |
> -                                             +-|->|       SSDT        | |
> -                                               |  +-------------------+ |
> -                                               |  | Definition Blocks | |
> -                                               |  +- - - - - - - - - -+ |
> -                                               +------------------------+
> -                                                           |
> -                                              OSPM Loading |
> -                                                          \|/
> -                                                    +----------------+
> -                                                    | ACPI Namespace |
> -                                                    +----------------+
> -
> -                     Figure 1. ACPI Definition Blocks
> -
> -   NOTE: RSDP can also contain a pointer to the RSDT (Root System
> -         Description Table).  Platforms provide RSDT to enable
> -         compatibility with ACPI 1.0 operating systems.  The OS is expected
> -         to use XSDT, if present.
> -
> -
> -2. Example ACPI Namespace
> -
> -   All definition blocks are loaded into a single namespace.  The namespace
> -   is a hierarchy of objects identified by names and paths.
> -   The following naming conventions apply to object names in the ACPI
> -   namespace:
>     1. All names are 32 bits long.
>     2. The first byte of a name must be one of 'A' - 'Z', '_'.
>     3. Each of the remaining bytes of a name must be one of 'A' - 'Z', '0'
> @@ -91,7 +94,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
>        (i.e. names prepended with '^' are relative to the parent of the
>        current namespace node).
>  
> -   The figure below shows an example ACPI namespace.
> +The figure below shows an example ACPI namespace::
>  
>     +------+
>     | \    |                     Root
> @@ -184,19 +187,20 @@ Wysocki <rafael.j.wysocki@intel.com>.
>                       Figure 2. Example ACPI Namespace
>  
>  
> -3. Linux ACPI Device Objects
> +Linux ACPI Device Objects
> +=========================
>  
> -   The Linux kernel's core ACPI subsystem creates struct acpi_device
> -   objects for ACPI namespace objects representing devices, power resources
> -   processors, thermal zones.  Those objects are exported to user space via
> -   sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
> -   format of their names is <bus_id:instance>, where 'bus_id' refers to the
> -   ACPI namespace representation of the given object and 'instance' is used
> -   for distinguishing different object of the same 'bus_id' (it is
> -   two-digit decimal representation of an unsigned integer).
> +The Linux kernel's core ACPI subsystem creates struct acpi_device
> +objects for ACPI namespace objects representing devices, power resources
> +processors, thermal zones.  Those objects are exported to user space via
> +sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
> +format of their names is <bus_id:instance>, where 'bus_id' refers to the
> +ACPI namespace representation of the given object and 'instance' is used
> +for distinguishing different object of the same 'bus_id' (it is
> +two-digit decimal representation of an unsigned integer).
>  
> -   The value of 'bus_id' depends on the type of the object whose name it is
> -   part of as listed in the table below.
> +The value of 'bus_id' depends on the type of the object whose name it is
> +part of as listed in the table below::
>  
>                  +---+-----------------+-------+----------+
>                  |   | Object/Feature  | Table | bus_id   |
> @@ -226,10 +230,11 @@ Wysocki <rafael.j.wysocki@intel.com>.
>  
>                   Table 1. ACPI Namespace Objects Mapping
>  
> -   The following rules apply when creating struct acpi_device objects on
> -   the basis of the contents of ACPI System Description Tables (as
> -   indicated by the letter in the first column and the notation in the
> -   second column of the table above):
> +The following rules apply when creating struct acpi_device objects on
> +the basis of the contents of ACPI System Description Tables (as
> +indicated by the letter in the first column and the notation in the
> +second column of the table above):
> +
>     N:
>        The object's source is an ACPI namespace node (as indicated by the
>        named object's type in the second column).  In that case the object's
> @@ -249,13 +254,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
>        struct acpi_device object with LNXVIDEO 'bus_id' will be created for
>        it.
>  
> -   The third column of the above table indicates which ACPI System
> -   Description Tables contain information used for the creation of the
> -   struct acpi_device objects represented by the given row (xSDT means DSDT
> -   or SSDT).
> +The third column of the above table indicates which ACPI System
> +Description Tables contain information used for the creation of the
> +struct acpi_device objects represented by the given row (xSDT means DSDT
> +or SSDT).
> +
> +The forth column of the above table indicates the 'bus_id' generation
> +rule of the struct acpi_device object:
>  
> -   The forth column of the above table indicates the 'bus_id' generation
> -   rule of the struct acpi_device object:
>     _HID:
>        _HID in the last column of the table means that the object's bus_id
>        is derived from the _HID/_CID identification objects present under
> @@ -275,45 +281,47 @@ Wysocki <rafael.j.wysocki@intel.com>.
>        object's bus_id.
>  
>  
> -4. Linux ACPI Physical Device Glue
> -
> -   ACPI device (i.e. struct acpi_device) objects may be linked to other
> -   objects in the Linux' device hierarchy that represent "physical" devices
> -   (for example, devices on the PCI bus).  If that happens, it means that
> -   the ACPI device object is a "companion" of a device otherwise
> -   represented in a different way and is used (1) to provide configuration
> -   information on that device which cannot be obtained by other means and
> -   (2) to do specific things to the device with the help of its ACPI
> -   control methods.  One ACPI device object may be linked this way to
> -   multiple "physical" devices.
> -
> -   If an ACPI device object is linked to a "physical" device, its sysfs
> -   directory contains the "physical_node" symbolic link to the sysfs
> -   directory of the target device object.  In turn, the target device's
> -   sysfs directory will then contain the "firmware_node" symbolic link to
> -   the sysfs directory of the companion ACPI device object.
> -   The linking mechanism relies on device identification provided by the
> -   ACPI namespace.  For example, if there's an ACPI namespace object
> -   representing a PCI device (i.e. a device object under an ACPI namespace
> -   object representing a PCI bridge) whose _ADR returns 0x00020000 and the
> -   bus number of the parent PCI bridge is 0, the sysfs directory
> -   representing the struct acpi_device object created for that ACPI
> -   namespace object will contain the 'physical_node' symbolic link to the
> -   /sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
> -   corresponding PCI device.
> -
> -   The linking mechanism is generally bus-specific.  The core of its
> -   implementation is located in the drivers/acpi/glue.c file, but there are
> -   complementary parts depending on the bus types in question located
> -   elsewhere.  For example, the PCI-specific part of it is located in
> -   drivers/pci/pci-acpi.c.
> -
> -
> -5. Example Linux ACPI Device Tree
> -
> -   The sysfs hierarchy of struct acpi_device objects corresponding to the
> -   example ACPI namespace illustrated in Figure 2 with the addition of
> -   fixed PWR_BUTTON/SLP_BUTTON devices is shown below.
> +Linux ACPI Physical Device Glue
> +===============================
> +
> +ACPI device (i.e. struct acpi_device) objects may be linked to other
> +objects in the Linux' device hierarchy that represent "physical" devices
> +(for example, devices on the PCI bus).  If that happens, it means that
> +the ACPI device object is a "companion" of a device otherwise
> +represented in a different way and is used (1) to provide configuration
> +information on that device which cannot be obtained by other means and
> +(2) to do specific things to the device with the help of its ACPI
> +control methods.  One ACPI device object may be linked this way to
> +multiple "physical" devices.
> +
> +If an ACPI device object is linked to a "physical" device, its sysfs
> +directory contains the "physical_node" symbolic link to the sysfs
> +directory of the target device object.  In turn, the target device's
> +sysfs directory will then contain the "firmware_node" symbolic link to
> +the sysfs directory of the companion ACPI device object.
> +The linking mechanism relies on device identification provided by the
> +ACPI namespace.  For example, if there's an ACPI namespace object
> +representing a PCI device (i.e. a device object under an ACPI namespace
> +object representing a PCI bridge) whose _ADR returns 0x00020000 and the
> +bus number of the parent PCI bridge is 0, the sysfs directory
> +representing the struct acpi_device object created for that ACPI
> +namespace object will contain the 'physical_node' symbolic link to the
> +/sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
> +corresponding PCI device.
> +
> +The linking mechanism is generally bus-specific.  The core of its
> +implementation is located in the drivers/acpi/glue.c file, but there are
> +complementary parts depending on the bus types in question located
> +elsewhere.  For example, the PCI-specific part of it is located in
> +drivers/pci/pci-acpi.c.
> +
> +
> +Example Linux ACPI Device Tree
> +=================================
> +
> +The sysfs hierarchy of struct acpi_device objects corresponding to the
> +example ACPI namespace illustrated in Figure 2 with the addition of
> +fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
>  
>     +--------------+---+-----------------+
>     | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
> @@ -377,12 +385,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
>  
>                    Figure 3. Example Linux ACPI Device Tree
>  
> -   NOTE: Each node is represented as "object/path/modalias", where:
> -         1. 'object' is the name of the object's directory in sysfs.
> -         2. 'path' is the ACPI namespace path of the corresponding
> -            ACPI namespace object, as returned by the object's 'path'
> -            sysfs attribute.
> -         3. 'modalias' is the value of the object's 'modalias' sysfs
> -            attribute (as described earlier in this document).
> -   NOTE: N/A indicates the device object does not have the 'path' or the
> -         'modalias' attribute.
> +.. note:: Each node is represented as "object/path/modalias", where:
> +
> +   1. 'object' is the name of the object's directory in sysfs.
> +   2. 'path' is the ACPI namespace path of the corresponding
> +      ACPI namespace object, as returned by the object's 'path'
> +      sysfs attribute.
> +   3. 'modalias' is the value of the object's 'modalias' sysfs
> +      attribute (as described earlier in this document).
> +
> +.. note:: N/A indicates the device object does not have the 'path' or the
> +   'modalias' attribute.



Thanks,
Mauro
