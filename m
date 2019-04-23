Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D1C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:01:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D67F217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROeiph+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D67F217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZ8Y704xzDqQh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROeiph+5"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTW317RbzDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:32:14 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id x15so3434020pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S70C++BhYe3LidhJGoAnqu6I0VuKIAPGUTVEYVjwoHM=;
 b=ROeiph+56zr6OCltGO24rxEzduP6Ynoe/Tizw3pWksnoaFPJPIqya9kOMnOrC8W175
 F7WVjkj67da+uo9gCYAODARDlSnsj/qs5U8Rl7SrttwvQtoNIH0IB/66yx8iAuo/0moR
 FLzV/2FNeNWE4XEyWeF8gy1yX3GQPMDKJAbjH3nqI0fBVoPD2eDpQzHfV0quCjPYCaPz
 SSbQDSS+7WPvtoE6F7RGWBTWBL4W44Be6KUiT1p19UCzmol6UkUaUI6u8A6QC3DIgrdB
 Um6UbyfiW4J/xb7WBEIWSszTE2HbVEQ2kWB/zQjVC6MLK3YKCHdCRuitMlqcHSwAoyzp
 k2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S70C++BhYe3LidhJGoAnqu6I0VuKIAPGUTVEYVjwoHM=;
 b=ZeaaEXT83LLOGFmZQ/toJF7PJx3lZvQiW/Gwj6d2PMs38FbdxY9nk2x92fbhxYy4ht
 WvPbWX5Y/cgCq6h7mpzR+5ngJioKjDAoZNzZ7qzDBhGfmXJ/7tOn6PayUa4AVsXYjLVU
 4vVd3eK3kdA+k/Gh6he0Hb+Lc5AmZqPzzyZNLUue4+DZmAN18bw3S0/EgM6j4CY9z7yq
 c9WHOyG4LOBMBXKh28X+PseMy7XjiuMCI8+cqOYsHx5+hLnOZ/wVXVK0tnfjTH7X+CPM
 O5blLCDU39dYLTCdGDjOzUcZ9M8bRslIBw0MBbBZw9UHXqsB2akJGWsoXz80oijaeE1n
 eCNw==
X-Gm-Message-State: APjAAAU6olERMWfogicMKMoWjEl5AVRikrpuaLqy7W3Uzw503pxAa8lB
 t2QjGGeC7YocycshrjwiS80=
X-Google-Smtp-Source: APXvYqwn1rodjYqifxX2JhfX2TAP5ehvlN7pDi56oVyQ7ZX5Wq0zOQ8WaH3TMxKnESYlo3TwGZFh2g==
X-Received: by 2002:a17:902:b20f:: with SMTP id
 t15mr9214223plr.341.1556037133050; 
 Tue, 23 Apr 2019 09:32:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.32.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:32:12 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 12/63] Documentation: ACPI: move i2c-muxes.txt to
 firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 00:28:41 +0800
Message-Id: <20190423162932.21428-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:30 +1000
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
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/i2c-muxes.txt              | 58 ------------------
 .../firmware-guide/acpi/i2c-muxes.rst         | 61 +++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 3 files changed, 63 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst

diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
deleted file mode 100644
index 9fcc4f0b885e..000000000000
--- a/Documentation/acpi/i2c-muxes.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-ACPI I2C Muxes
---------------
-
-Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
-Device () scope per mux channel.
-
-Consider this topology:
-
-+------+   +------+
-| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
-|      |   | 0x70 |--CH01--> i2c client B (0x50)
-+------+   +------+
-
-which corresponds to the following ASL:
-
-Device (SMB1)
-{
-    Name (_HID, ...)
-    Device (MUX0)
-    {
-        Name (_HID, ...)
-        Name (_CRS, ResourceTemplate () {
-            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                          AddressingMode7Bit, "^SMB1", 0x00,
-                          ResourceConsumer,,)
-        }
-
-        Device (CH00)
-        {
-            Name (_ADR, 0)
-
-            Device (CLIA)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH00", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-
-        Device (CH01)
-        {
-            Name (_ADR, 1)
-
-            Device (CLIB)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH01", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-    }
-}
diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..3a8997ccd7c4
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+ACPI I2C Muxes
+==============
+
+Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
+Device () scope per mux channel.
+
+Consider this topology::
+
+    +------+   +------+
+    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+    |      |   | 0x70 |--CH01--> i2c client B (0x50)
+    +------+   +------+
+
+which corresponds to the following ASL::
+
+    Device (SMB1)
+    {
+        Name (_HID, ...)
+        Device (MUX0)
+        {
+            Name (_HID, ...)
+            Name (_CRS, ResourceTemplate () {
+                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
+                            AddressingMode7Bit, "^SMB1", 0x00,
+                            ResourceConsumer,,)
+            }
+
+            Device (CH00)
+            {
+                Name (_ADR, 0)
+
+                Device (CLIA)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+
+            Device (CH01)
+            {
+                Name (_ADR, 1)
+
+                Device (CLIB)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+        }
+    }
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index d1d069b26bbc..1c89888f6ee8 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -12,4 +12,5 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
-   gpio-properties
\ No newline at end of file
+   gpio-properties
+   i2c-muxes
-- 
2.20.1

