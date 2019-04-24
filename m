Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC4C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7BA20652
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYa/hgpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7BA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q7YV1105zDqKy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:06:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YYa/hgpE"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7HM6RW9zDqM9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:54:23 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id j26so9743692pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oy6KoWLCzqwBPFFZLDtYtaD4m0hOkn4WdDvKhqmJ+bM=;
 b=YYa/hgpEQmYmCSkmdATAnSV72FURoSdu2SKR5iVdi0UpLJ7K15GwdMIQF0KMYE6N9b
 tuFx9Ld3i5VBLL97WjldYTz7Tfn6Dx05mricJxcWF/WwcSjEp45h4A8GS31Y0DAUpX7h
 g3tikgqU/sL8RcPAwIduiNOgASQtIduplBozbgsTmEsuClTT6GaoTJYGcOeL0sfvpYMY
 8SwnKjOLFZTyFI7F4ctKc1PK9g0TvsOvZH5bP9wQjZFwOEeC49TfG9ihbg+B0HMi/J7k
 ZxpK7p7GQEMUkDT5Yx5GqRc4AIT+JiYGRG+MGMmox34kfTWXYNdUmXHVr7aY4HcRl3l6
 xhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oy6KoWLCzqwBPFFZLDtYtaD4m0hOkn4WdDvKhqmJ+bM=;
 b=gV1YzVQ+4bsQKZHp4bJKFR8A1YBjWs5KrFVkLBNM7UEe6ctQWy53sgnfU64jXyo7wf
 wSFcBYLBqOsB2kNkdhQHroEZDFDrg2zaE4TDI7Y+tB6UjSFNAndWj9o3OYJui99nzex1
 dmgh6z0OfLfvbAwNnaYho/Lkif2hMP9t92ReVbbji31/zI9LltrhmkGP6mR1LPazeEdl
 /ezofg4XMnjmsRMcDDhz1DZ55zOaadUsM9OXJOs1/SjFE/45oIS5Iz2lBPuBCHvfGPl3
 KJNZoYrtVAhLALzpOTFcg7nBWq7Bax3rgRNAe72m1b5OSq4IX+dHhwKYWnoPh9v1fAAg
 C4yQ==
X-Gm-Message-State: APjAAAV+0Mppyll4P6xoHiFmHbEYaLkZQBp87n9wCZ7khFku/OYQVUd0
 BbqaMsdlQYaBg2AGZ8o75/0=
X-Google-Smtp-Source: APXvYqwAiOSx7XL4DFjYu9tNtAutAzPoxXKuYF7wHzl43d0jOjxt7g/gaARONiGE6OWZZ+e4J3Dx9w==
X-Received: by 2002:a63:1364:: with SMTP id 36mr27220331pgt.436.1556128460640; 
 Wed, 24 Apr 2019 10:54:20 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.54.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:54:19 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 02/23] Documentation: ACPI: move enumeration.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:52:45 +0800
Message-Id: <20190424175306.25880-3-changbin.du@gmail.com>
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
 .../acpi/enumeration.rst}                     | 135 ++++++++++--------
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 2 files changed, 74 insertions(+), 62 deletions(-)
 rename Documentation/{acpi/enumeration.txt => firmware-guide/acpi/enumeration.rst} (87%)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/firmware-guide/acpi/enumeration.rst
similarity index 87%
rename from Documentation/acpi/enumeration.txt
rename to Documentation/firmware-guide/acpi/enumeration.rst
index 7bcf9c3d9fbe..ce755e963714 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -1,5 +1,9 @@
-ACPI based device enumeration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+ACPI Based Device Enumeration
+=============================
+
 ACPI 5 introduced a set of new resources (UartTSerialBus, I2cSerialBus,
 SpiSerialBus, GpioIo and GpioInt) which can be used in enumerating slave
 devices behind serial bus controllers.
@@ -11,12 +15,12 @@ that are accessed through memory-mapped registers.
 In order to support this and re-use the existing drivers as much as
 possible we decided to do following:
 
-	o Devices that have no bus connector resource are represented as
-	  platform devices.
+  - Devices that have no bus connector resource are represented as
+    platform devices.
 
-	o Devices behind real busses where there is a connector resource
-	  are represented as struct spi_device or struct i2c_device
-	  (standard UARTs are not busses so there is no struct uart_device).
+  - Devices behind real busses where there is a connector resource
+    are represented as struct spi_device or struct i2c_device
+    (standard UARTs are not busses so there is no struct uart_device).
 
 As both ACPI and Device Tree represent a tree of devices (and their
 resources) this implementation follows the Device Tree way as much as
@@ -31,7 +35,8 @@ enumerated from ACPI namespace. This handle can be used to extract other
 device-specific configuration. There is an example of this below.
 
 Platform bus support
-~~~~~~~~~~~~~~~~~~~~
+====================
+
 Since we are using platform devices to represent devices that are not
 connected to any physical bus we only need to implement a platform driver
 for the device and add supported ACPI IDs. If this same IP-block is used on
@@ -39,7 +44,7 @@ some other non-ACPI platform, the driver might work out of the box or needs
 some minor changes.
 
 Adding ACPI support for an existing driver should be pretty
-straightforward. Here is the simplest example:
+straightforward. Here is the simplest example::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mydrv_acpi_match[] = {
@@ -61,12 +66,13 @@ configuring GPIOs it can get its ACPI handle and extract this information
 from ACPI tables.
 
 DMA support
-~~~~~~~~~~~
+===========
+
 DMA controllers enumerated via ACPI should be registered in the system to
 provide generic access to their resources. For example, a driver that would
 like to be accessible to slave devices via generic API call
 dma_request_slave_channel() must register itself at the end of the probe
-function like this:
+function like this::
 
 	err = devm_acpi_dma_controller_register(dev, xlate_func, dw);
 	/* Handle the error if it's not a case of !CONFIG_ACPI */
@@ -74,7 +80,7 @@ function like this:
 and implement custom xlate function if needed (usually acpi_dma_simple_xlate()
 is enough) which converts the FixedDMA resource provided by struct
 acpi_dma_spec into the corresponding DMA channel. A piece of code for that case
-could look like:
+could look like::
 
 	#ifdef CONFIG_ACPI
 	struct filter_args {
@@ -114,7 +120,7 @@ provided by struct acpi_dma.
 Clients must call dma_request_slave_channel() with the string parameter that
 corresponds to a specific FixedDMA resource. By default "tx" means the first
 entry of the FixedDMA resource array, "rx" means the second entry. The table
-below shows a layout:
+below shows a layout::
 
 	Device (I2C0)
 	{
@@ -138,12 +144,13 @@ acpi_dma_request_slave_chan_by_index() directly and therefore choose the
 specific FixedDMA resource by its index.
 
 SPI serial bus support
-~~~~~~~~~~~~~~~~~~~~~~
+======================
+
 Slave devices behind SPI bus have SpiSerialBus resource attached to them.
 This is extracted automatically by the SPI core and the slave devices are
 enumerated once spi_register_master() is called by the bus driver.
 
-Here is what the ACPI namespace for a SPI slave might look like:
+Here is what the ACPI namespace for a SPI slave might look like::
 
 	Device (EEP0)
 	{
@@ -163,7 +170,7 @@ Here is what the ACPI namespace for a SPI slave might look like:
 
 The SPI device drivers only need to add ACPI IDs in a similar way than with
 the platform device drivers. Below is an example where we add ACPI support
-to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
+to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id at25_acpi_match[] = {
@@ -182,7 +189,7 @@ to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
 
 Note that this driver actually needs more information like page size of the
 eeprom etc. but at the time writing this there is no standard way of
-passing those. One idea is to return this in _DSM method like:
+passing those. One idea is to return this in _DSM method like::
 
 	Device (EEP0)
 	{
@@ -202,7 +209,7 @@ passing those. One idea is to return this in _DSM method like:
 		}
 
 Then the at25 SPI driver can get this configuration by calling _DSM on its
-ACPI handle like:
+ACPI handle like::
 
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
@@ -220,14 +227,15 @@ ACPI handle like:
 	kfree(output.pointer);
 
 I2C serial bus support
-~~~~~~~~~~~~~~~~~~~~~~
+======================
+
 The slaves behind I2C bus controller only need to add the ACPI IDs like
 with the platform and SPI drivers. The I2C core automatically enumerates
 any slave devices behind the controller device once the adapter is
 registered.
 
 Below is an example of how to add ACPI support to the existing mpu3050
-input driver:
+input driver::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mpu3050_acpi_match[] = {
@@ -251,56 +259,57 @@ input driver:
 	};
 
 GPIO support
-~~~~~~~~~~~~
+============
+
 ACPI 5 introduced two new resources to describe GPIO connections: GpioIo
 and GpioInt. These resources can be used to pass GPIO numbers used by
 the device to the driver. ACPI 5.1 extended this with _DSD (Device
 Specific Data) which made it possible to name the GPIOs among other things.
 
-For example:
+For example::
 
-Device (DEV)
-{
-	Method (_CRS, 0, NotSerialized)
+	Device (DEV)
 	{
-		Name (SBUF, ResourceTemplate()
+		Method (_CRS, 0, NotSerialized)
 		{
-			...
-			// Used to power on/off the device
-			GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
-				IoRestrictionOutputOnly, "\\_SB.PCI0.GPI0",
-				0x00, ResourceConsumer,,)
+			Name (SBUF, ResourceTemplate()
 			{
-				// Pin List
-				0x0055
-			}
+				...
+				// Used to power on/off the device
+				GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
+					IoRestrictionOutputOnly, "\\_SB.PCI0.GPI0",
+					0x00, ResourceConsumer,,)
+				{
+					// Pin List
+					0x0055
+				}
+
+				// Interrupt for the device
+				GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone,
+					0x0000, "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer,,)
+				{
+					// Pin list
+					0x0058
+				}
+
+				...
 
-			// Interrupt for the device
-			GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone,
-				 0x0000, "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer,,)
-			{
-				// Pin list
-				0x0058
 			}
 
-			...
-
+			Return (SBUF)
 		}
 
-		Return (SBUF)
-	}
-
-	// ACPI 5.1 _DSD used for naming the GPIOs
-	Name (_DSD, Package ()
-	{
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package ()
+		// ACPI 5.1 _DSD used for naming the GPIOs
+		Name (_DSD, Package ()
 		{
-			Package () {"power-gpios", Package() {^DEV, 0, 0, 0 }},
-			Package () {"irq-gpios", Package() {^DEV, 1, 0, 0 }},
-		}
-	})
-	...
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package ()
+			{
+				Package () {"power-gpios", Package() {^DEV, 0, 0, 0 }},
+				Package () {"irq-gpios", Package() {^DEV, 1, 0, 0 }},
+			}
+		})
+		...
 
 These GPIO numbers are controller relative and path "\\_SB.PCI0.GPI0"
 specifies the path to the controller. In order to use these GPIOs in Linux
@@ -310,7 +319,7 @@ There is a standard GPIO API for that and is documented in
 Documentation/gpio/.
 
 In the above example we can get the corresponding two GPIO descriptors with
-a code like this:
+a code like this::
 
 	#include <linux/gpio/consumer.h>
 	...
@@ -334,21 +343,22 @@ See Documentation/acpi/gpio-properties.txt for more information about the
 _DSD binding related to GPIOs.
 
 MFD devices
-~~~~~~~~~~~
+===========
+
 The MFD devices register their children as platform devices. For the child
 devices there needs to be an ACPI handle that they can use to reference
 parts of the ACPI namespace that relate to them. In the Linux MFD subsystem
 we provide two ways:
 
-	o The children share the parent ACPI handle.
-	o The MFD cell can specify the ACPI id of the device.
+  - The children share the parent ACPI handle.
+  - The MFD cell can specify the ACPI id of the device.
 
 For the first case, the MFD drivers do not need to do anything. The
 resulting child platform device will have its ACPI_COMPANION() set to point
 to the parent device.
 
 If the ACPI namespace has a device that we can match using an ACPI id or ACPI
-adr, the cell should be set like:
+adr, the cell should be set like::
 
 	static struct mfd_cell_acpi_match my_subdevice_cell_acpi_match = {
 		.pnpid = "XYZ0001",
@@ -366,7 +376,8 @@ the MFD device and if found, that ACPI companion device is bound to the
 resulting child platform device.
 
 Device Tree namespace link device ID
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+====================================
+
 The Device Tree protocol uses device identification based on the "compatible"
 property whose value is a string or an array of strings recognized as device
 identifiers by drivers and the driver core.  The set of all those strings may be
@@ -423,4 +434,4 @@ the _DSD of the device object itself or the _DSD of its ancestor in the
 Otherwise, the _DSD itself is regarded as invalid and therefore the "compatible"
 property returned by it is meaningless.
 
-Refer to DSD-properties-rules.txt for more information.
+Refer to :doc:`DSD-properties-rules` for more information.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 210ad8acd6df..99677c73f1fb 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -8,3 +8,4 @@ ACPI Support
    :maxdepth: 1
 
    namespace
+   enumeration
-- 
2.20.1

