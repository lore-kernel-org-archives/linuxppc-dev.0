Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E9C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:20:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F452084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F452084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rc3Q1DNNzF3bc
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:20:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZH5ZgbzF3T4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:03 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so10956070oib.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=x2mzVRPujteGexchx9lGyCag4aIXbmkmqEcveyWYS/I=;
 b=H14IZ3Fusxslq6CXE6PwOlKsqO/n2V+C5tknu68r+aODLzq9ohTZh4nGa+hrDOyBg+
 dkM2Bbb5BopSuvyuL2tY1FKUTh5j+yYiMR+Mn1A81V7ZXjoIF498wyHwDeJIZ82tXd7N
 Oz6IcTKq4FwkeYsYutBQhq0bDlMGQztZGjV9hQFdNrXT1Fmp4cUnSmVjC/bhoCyJ9yP0
 v9EnmBYYDCGWw3Js47aPzzjStaTpqNUd3W/2Z7VGZPIzfKGNN2Vry7OonGXR/63uxUD6
 aynnimkF3LaqIVi/i0PfdBBTSqRXWd5LX3x+z+OwjTvEuOKy08RX6DeQJSfuqlhX5fy8
 KMJw==
X-Gm-Message-State: ABuFfog1sUFKofumpSy5SlWeUUdf+blYgE9vE8MBPcEWfFD+pDuc0Th3
 B3HbSpBAdbMrw8Olbh6yOQ==
X-Google-Smtp-Source: ACcGV63fWywOIwm/fYx/AXkl74S8Y03QRQwUU8aF6UuENOedUxTa3DdfsbNbIO3afkyJCXj4A2pM1Q==
X-Received: by 2002:aca:ce07:: with SMTP id e7-v6mr6050227oig.54.1538758741325; 
 Fri, 05 Oct 2018 09:59:01 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:00 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/36] dt-bindings: Add a writing DT schemas how-to and
 annotated example
Date: Fri,  5 Oct 2018 11:58:20 -0500
Message-Id: <20181005165848.3474-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a how-to doc on writing DT schema documentation. This gives a
description of each section and details on how to validate the DT schema
file. The DT schema are written using json-schema vocabulary in a YAML
encoded document. Using jsonschema gives us access to existing tooling.
A YAML encoding gives us something easy to edit. The example is
annotated to help explain what each section does.

This example is just the tip of the iceberg, but is it the part most
developers writing bindings will interact with. Backing all this up
are meta-schema (to validate the binding schemas), some DT core schema,
YAML encoded DT output with dtc, and a small number of python scripts to
run validation.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/example-schema.yaml   | 155 ++++++++++++++++++
 Documentation/devicetree/writing-schema.md    | 111 +++++++++++++
 2 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
 create mode 100644 Documentation/devicetree/writing-schema.md

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
new file mode 100644
index 000000000000..4cbdbf59695f
--- /dev/null
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: BSD-2-Clause
+# Copyright 2018 Linaro Ltd.
+%YAML 1.2
+---
+# All the top-level keys are standard json-schema keywords except for
+# 'maintainers' and 'select'
+
+# $id is a unique idenifier based on the filename
+$id: "http://devicetree.org/schemas/example-schema.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: An example schema annotated with jsonschema details
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  A more detailed multi-line description of the binding.
+
+  Details about the hardware device and any links to datasheets can go here.
+
+  Literal blocks are marked with the '|' at the beginning. The end is marked by
+  indentation less than the first line of the literal block.
+
+select: false
+  # 'select' is a schema applied to a DT node to determine if this binding
+  # schema should be applied to the node. It is optional and by default the
+  # possible compatible strings are extracted and used to match.
+
+properties:
+  # A dictionary of DT properties for this binding schema
+  compatible:
+    # More complicated schema can use oneOf (XOR), anyOf (OR), or allOf (AND)
+    # to handle different conditions.
+    # In this case, it's needed to handle a variable number of values as there
+    # isn't another way to express a constraint of the last string value.
+    # The boolean schema must be a list of schemas.
+    oneOf:
+      - items:
+          # items is a list of possible values for the property. The number of
+          # values is determined by the number of elements in the list.
+          # Order in lists is significant, order in dicts is not
+          # Must be one of the 1st enums followed by the 2nd enum
+          #
+          # Each element in items should be 'enum' or 'const'
+          - enum:
+              - vendor,soc4-ip
+              - vendor,soc3-ip
+              - vendor,soc2-ip
+          - enum:
+              - vendor,soc1-ip
+        # additionalItems being false is implied
+        # minItems/maxItems equal to 2 is implied
+      - items:
+          # 'const' is just a special case of an enum with a single possible value
+          - const: vendor,soc1-ip
+
+  reg:
+    # The description of each element defines the order and implicitly defines
+    # the number of reg entries
+    items:
+      - description: core registers
+      - description: aux registers
+    # minItems/maxItems equal to 2 is implied
+
+  reg-names:
+    # The core schema enforces this is a string array
+    items:
+      - const: core
+      - const: aux
+
+  clocks:
+    maxItems: 1
+    # Only a single entry, so just need to set the max number of items.
+    description: hello
+
+  clock-names:
+    items:
+      - const: bus
+
+  interrupts:
+    # Either 1 or 2 interrupts can be present
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: tx or combined interrupt
+      - description: rx interrupt
+
+    description:
+      A variable number of interrupts warrants a description of what conditions
+      affect the number of interrupts. Otherwise, descriptions on standard
+      properties are not necessary.
+
+  interrupt-names:
+    # minItems must be specified here because the default would be 2
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: "tx irq"
+      - const: "rx irq"
+
+  # Property names starting with '#' must be quoted
+  '#interrupt-cells':
+    # A simple case where the value must always be '2'.
+    # The core schema handles that this must be a single integer.
+    const: 2
+
+  interrupt-controller: true
+    # The core checks this is a boolean, so just have to list it here to be
+    # valid for this binding.
+
+  clock-frequency:
+    # The type is set in the core schema. Per device schema only need to set
+    # constraints on the possible values.
+    minimum: 100
+    maximum: 400000
+    # The value that should be used if the property is not present
+    default: 200
+
+  foo-gpios:
+    maxItems: 1
+    description: A connection of the 'foo' gpio line.
+
+  vendor,int-property:
+    description: Vendor specific properties must have a description
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - enum: [2, 4, 6, 8, 10]
+
+  vendor,bool-property:
+    description: Vendor specific properties must have a description
+    type: boolean
+
+  vendor,string-array-property:
+    description: Vendor specific properties may refer to core schema
+    allOf:
+      - $ref: '/schemas/types.yaml#/definitions/stringarray'
+      - maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+
+examples:
+  - |
+    node@1000 {
+          compatible = "vendor,soc4-ip", "vendor,soc1-ip";
+          reg = <0x1000 0x80>,
+                <0x3000 0x80>;
+          reg-names = "core", "aux";
+          interrupts = <10>;
+          interrupt-controller;
+    };
diff --git a/Documentation/devicetree/writing-schema.md b/Documentation/devicetree/writing-schema.md
new file mode 100644
index 000000000000..b1d9798ca3e4
--- /dev/null
+++ b/Documentation/devicetree/writing-schema.md
@@ -0,0 +1,111 @@
+# Writing DeviceTree Bindings in json-schema
+
+Devicetree bindings are written using json-schema vocabulary. Schema files are
+written in a JSON compatible subset of YAML. YAML is used instead of JSON as it
+considered more human readable and has some advantages such as allowing
+comments (Prefixed with '#').
+
+## Schema Contents
+
+Each schema doc is a structured json-schema which is defined by a set of
+top-level properties:
+
+- __$id__ - A json-schema unique identifier string. The string must be a valid
+URI typically containing the binding's filename and path. DT schema it must
+begin with "http://devicetree.org/schema/". The URL is used for non file local
+"$ref" lookups. A URL is used even for local files, and there may not actually
+be files present at those locations.
+
+- __$schema__ - Indicates the meta-schema the schema file adheres to.
+
+- __title__ - A one line description on the contents of the binding schema.
+
+- __maintainers__ - A DT specific property. Contains a list of email address(es)
+for maintainers of this binding.
+
+- __description__ - Optional. A multi-line text block containing any detailed
+information about this binding. It should contain things such as what the block
+or device does, standards the device conforms to, and links to datasheets for
+more information.
+
+- __select__ - Optional. A json-schema to match nodes for applying the schema.
+By default, nodes are matched against their possible compatible string values
+or node name and select is not necessary.
+
+- __properties__ - A set of sub-schema defining all the DT properties for the
+binding. The exact schema depends on the type of property. A property can also
+define a child DT node with child properties defined under it.
+
+- __patternProperties__ - Optional. Similar to 'properties', but names are regex.
+
+- __required__ - A list of DT properties from the 'properties' section that
+must always be present.
+
+- __examples__ - Optional. A list of one or more DTS hunks implementing the
+binding.
+
+Unless noted otherwise, all properties are required.
+
+## Property Schema
+
+The 'properties' section of the schema contains all the DT properties for a
+binding. Each property contains a set of constraints using json-schema
+vocabulary for that property. The properties schemas are what is used for
+validation of DT files.
+
+For common properties, only additional constraints not covered by the common
+binding schema need to be defined such as how many values are valid or what
+possible values are valid.
+
+Vendor specific properties will typically need more detailed schema. With the
+exception of boolean properties, they should have a reference to a type in
+schemas/types.yaml. A "description" property is always required.
+
+The Devicetree schemas don't exactly match the YAML encoded DT data produced by
+dtc. They are simplified to make them more compact and avoid a bunch of
+boilerplate. The tools process the schema files to produce the final schema for
+validation. There are currently 2 transformations the tools perform.
+
+The default for arrays in json-schema is they are variable sized and allow more
+entries than explicitly defined. This can be restricted by defining 'minItems',
+'maxItems', and 'additionalItems'. However, for DeviceTree Schemas, a fixed
+size is desired in most cases, so these properties are added based on the
+number of entries in an 'items' list.
+
+The YAML Devicetree format also makes all string values an array and scalar
+values a matrix (in order to define groupings) even when only a single value
+is present. Single entries in schemas are fixed up to match this encoding.
+
+## Testing
+
+### Dependencies
+
+The DT schema project must be installed in order to validate the DT schema
+binding documents and validate DTS files using the DT schema. The DT schema
+project can be installed with pip:
+
+`pip3 install git+https://github.com/robherring/yaml-bindings.git@master --process-dependency-links`
+
+dtc must also be built with YAML output support enabled. This requires that
+libyaml and its headers be installed on the host system.
+
+### Running checks
+
+The DT schema binding documents must be validated using the meta-schema (the
+schema for the schema) to ensure they are both valid json-schema and valid
+binding schema. All of the DT binding documents can be validated using the
+`dt_binding_check` target:
+
+`make dt_binding_check`
+
+In order to perform validation of DT source files, use the `dtbs_check` target:
+
+`make dtbs_check`
+
+This will first run the `dt_binding_check` which generates the processed schema.
+
+## json-schema Resources
+
+[JSON-Schema Specifications](http://json-schema.org/)
+
+[Using JSON Schema Book](http://usingjsonschema.com/)
-- 
2.17.1

