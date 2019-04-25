Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04505C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:05:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F345D20878
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncGQV6hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F345D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhqL2CmLzDqlQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 02:05:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ncGQV6hk"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh5m6pNVzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:33:00 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id z5so99682pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q7X/TpVUy9MOoo+OOx4gvhRbEBFHOPzvaja1yF/wQgs=;
 b=ncGQV6hk9xaSJn3CsK9LHfCjmnsxz21KUjaj3mgC0n1Udr8ZYImkDZiohZHS+eoUzU
 7gnvRkKnbP6vm6F+IGE32xQ4FYNpPLFIpIQx0+pZWIfHHuPUfX36kh04Ccn91qxzNJ5I
 VO2dh7S/T/wKSk+hluH6LI6JJyM5pIhuP0jAHcC94nBU832o6XAoT6rhmgulEvAoI2UE
 zEn7Z3rgG/OlEDpODqr5137HHYl7yIhW0ibj7RTY0+/o2KzLoz3PD+UNOM5XfBNWuoyU
 qk37yd8oUHXZqpcvdsM2pdloqGTt+HA0b/kkaW3yQJHTan7+PyUJMjuu6kxJW4SQiPbJ
 ZfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q7X/TpVUy9MOoo+OOx4gvhRbEBFHOPzvaja1yF/wQgs=;
 b=cC0qXtW9+frU6DOFBwGY1qQL3RwYqSkwfbVRVrJByu4rOk6o1e4+jIHr0Bz+1WIO4B
 MWsrZC7ArSYE1rUTwu0rng6H2SQk/NfaQKMXBjQJ4Dz1AeMaHfm3YgAr7so9WFC9r7O+
 e3bETQ+wZpqzbwmvwKCQH8hFq55eY64JrBcH48zL9uW+k+yzWpT7SlshgccCuaSky6cS
 3DjayBqUAKrdGZXveOT321M8ptHPC3K1InkUMsPb+Bwezp75y+oTC+mJZpvbPQOxP3q1
 hF73NoXgvDWiheBu2b8Qyy74IvhWkkNJ0NWTYc+9ZKayvT4c1f1wZyuiHzDXrUzQ8s2y
 CH+g==
X-Gm-Message-State: APjAAAW/RjC8kE4edE4V4B2KMiKK/ybnLhiMl7GIEzfpL6uaeb7MKo1H
 rHnYsW0Dcz2CEkL5R4wLuEs=
X-Google-Smtp-Source: APXvYqzVFc5fV69QBNTYQav8BCWQBoB7F33ygM9sNN11LZebBzNlyknXhrQeo6Jg9tnZr0kJ3x3G0Q==
X-Received: by 2002:a62:480d:: with SMTP id v13mr41712419pfa.125.1556206376764; 
 Thu, 25 Apr 2019 08:32:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:32:56 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 14/24] Documentation: ACPI: move dsd/graph.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:07 +0800
Message-Id: <20190425153117.16057-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 .../acpi/dsd/graph.rst}                       | 157 +++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 2 files changed, 81 insertions(+), 77 deletions(-)
 rename Documentation/{acpi/dsd/graph.txt => firmware-guide/acpi/dsd/graph.rst} (56%)

diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/firmware-guide/acpi/dsd/graph.rst
similarity index 56%
rename from Documentation/acpi/dsd/graph.txt
rename to Documentation/firmware-guide/acpi/dsd/graph.rst
index b9ce910781dc..e0baed35b037 100644
--- a/Documentation/acpi/dsd/graph.txt
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -1,8 +1,11 @@
-Graphs
+.. SPDX-License-Identifier: GPL-2.0
 
+======
+Graphs
+======
 
 _DSD
-----
+====
 
 _DSD (Device Specific Data) [7] is a predefined ACPI device
 configuration object that can be used to convey information on
@@ -30,7 +33,7 @@ hierarchical data extension array on each depth.
 
 
 Ports and endpoints
--------------------
+===================
 
 The port and endpoint concepts are very similar to those in Devicetree
 [3]. A port represents an interface in a device, and an endpoint
@@ -38,9 +41,9 @@ represents a connection to that interface.
 
 All port nodes are located under the device's "_DSD" node in the hierarchical
 data extension tree. The data extension related to each port node must begin
-with "port" and must be followed by the "@" character and the number of the port
-as its key. The target object it refers to should be called "PRTX", where "X" is
-the number of the port. An example of such a package would be:
+with "port" and must be followed by the "@" character and the number of the
+port as its key. The target object it refers to should be called "PRTX", where
+"X" is the number of the port. An example of such a package would be::
 
     Package() { "port@4", PRT4 }
 
@@ -49,7 +52,7 @@ data extension key of the endpoint nodes must begin with
 "endpoint" and must be followed by the "@" character and the number of the
 endpoint. The object it refers to should be called "EPXY", where "X" is the
 number of the port and "Y" is the number of the endpoint. An example of such a
-package would be:
+package would be::
 
     Package() { "endpoint@0", EP40 }
 
@@ -62,85 +65,85 @@ of that port shall be zero. Similarly, if a port may only have a single
 endpoint, the number of that endpoint shall be zero.
 
 The endpoint reference uses property extension with "remote-endpoint" property
-name followed by a reference in the same package. Such references consist of the
+name followed by a reference in the same package. Such references consist of
 the remote device reference, the first package entry of the port data extension
 reference under the device and finally the first package entry of the endpoint
-data extension reference under the port. Individual references thus appear as:
+data extension reference under the port. Individual references thus appear as::
 
     Package() { device, "port@X", "endpoint@Y" }
 
-In the above example, "X" is the number of the port and "Y" is the number of the
-endpoint.
+In the above example, "X" is the number of the port and "Y" is the number of
+the endpoint.
 
 The references to endpoints must be always done both ways, to the
 remote endpoint and back from the referred remote endpoint node.
 
-A simple example of this is show below:
+A simple example of this is show below::
 
     Scope (\_SB.PCI0.I2C2)
     {
-	Device (CAM0)
-	{
-	    Name (_DSD, Package () {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "compatible", Package () { "nokia,smia" } },
-		},
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "port@0", PRT0 },
-		}
-	    })
-	    Name (PRT0, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 0 },
-		},
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "endpoint@0", EP00 },
-		}
-	    })
-	    Name (EP00, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
-		}
-	    })
-	}
+        Device (CAM0)
+        {
+            Name (_DSD, Package () {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "compatible", Package () { "nokia,smia" } },
+                },
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "port@0", PRT0 },
+                }
+            })
+            Name (PRT0, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 0 },
+                },
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "endpoint@0", EP00 },
+                }
+            })
+            Name (EP00, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 0 },
+                    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
+                }
+            })
+        }
     }
 
     Scope (\_SB.PCI0)
     {
-	Device (ISP)
-	{
-	    Name (_DSD, Package () {
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "port@4", PRT4 },
-		}
-	    })
-
-	    Name (PRT4, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 4 }, /* CSI-2 port number */
-		},
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "endpoint@0", EP40 },
-		}
-	    })
-
-	    Name (EP40, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
-		}
-	    })
-	}
+        Device (ISP)
+        {
+            Name (_DSD, Package () {
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "port@4", PRT4 },
+                }
+            })
+
+            Name (PRT4, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 4 }, /* CSI-2 port number */
+                },
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "endpoint@0", EP40 },
+                }
+            })
+
+            Name (EP40, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 0 },
+                    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
+                }
+            })
+        }
     }
 
 Here, the port 0 of the "CAM0" device is connected to the port 4 of
@@ -148,27 +151,27 @@ the "ISP" device and vice versa.
 
 
 References
-----------
+==========
 
 [1] _DSD (Device Specific Data) Implementation Guide.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
     referenced 2016-10-03.
 
-[2] Devicetree. <URL:http://www.devicetree.org>, referenced 2016-10-03.
+[2] Devicetree. http://www.devicetree.org, referenced 2016-10-03.
 
 [3] Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
     referenced 2016-10-04.
 
 [5] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
     referenced 2016-10-04.
 
 [6] Advanced Configuration and Power Interface Specification.
-    <URL:http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf>,
+    http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
     referenced 2016-10-04.
 
 [7] _DSD Device Properties Usage Rules.
-    Documentation/acpi/DSD-properties-rules.txt
+    :doc:`../DSD-properties-rules`
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index bedcb0b242a2..f81cfbcb6878 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -8,6 +8,7 @@ ACPI Support
    :maxdepth: 1
 
    namespace
+   dsd/graph
    enumeration
    osi
    method-customizing
-- 
2.20.1

