Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77D2F1A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 13:06:24 +1000 (AEST)
Received: by igbqf9 with SMTP id qf9so54867279igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2015 20:06:22 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] devicetree: add ibm-nx-powernv details
Date: Wed,  8 Apr 2015 23:05:56 -0400
Message-Id: <1428548756-16485-1-git-send-email-ddstreet@ieee.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a devicetree description for property nodes for the NX Coprocessor
in an IBM PowerPC processor.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
---

Is this the right location/naming for this file?
And did I get the content format right?

Should this file be called "ibm-nx-opal.txt" instead of "ibm-nx-powernv.txt",
since it's the Opal firmware that provides the nodes (although they are
used by the PowerNV platform kernel)?

The 842 properties are used by the PowerNV 842 driver patch set I
sent out yesterday, and which I'll send a v2 of soon.

.../devicetree/bindings/crypto/ibm-nx-powernv.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/ibm-nx-powernv.txt

diff --git a/Documentation/devicetree/bindings/crypto/ibm-nx-powernv.txt b/Documentation/devicetree/bindings/crypto/ibm-nx-powernv.txt
new file mode 100644
index 0000000..e031636
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/ibm-nx-powernv.txt
@@ -0,0 +1,40 @@
+Device-tree bindings for PowerNV platform IBM Nest (NX) Coprocessor
+-------------------------------------------------------------------
+
+Required properties:
+
+- compatible: must contain "ibm,power-nx"; may also contain the processor
+              version, e.g. "ibm,power8-nx"
+
+Optional properties:
+
+- ibm,842-coprocessor-type: CT of this NX 842 coprocessor
+- ibm,842-coprocessor-instance: CI of this NX 842 coprocessor
+
+If present, the NX-842 Coprocessor Type (CT) and Coprocessor Instance (CI)
+can be used in an ICSWX instruction to communicate with the NX-842
+coprocessor, to perform hardware compression/decompression.
+
+Additionally, there must be an "ibm,chip-id" node at some point in the
+direct devicetree hierarchy leading to the nx node; typically the nx
+node's parent is an xscom node, which contains the "ibm,chip-id" property.
+
+Example:
+
+nx@2010000 {
+	compatible = "ibm,power-nx", "ibm,power8-nx";
+	ibm,842-coprocessor-type = <0x3>;
+	ibm,842-coprocessor-instance = <0x1>;
+	name = "nx";
+	reg = <0x2010000 0x4000>;
+	linux,phandle = <0x85>;
+	phandle = <0x85>;
+};
+
+with a parent of:
+
+xscom@3fc0000000000 {
+	ibm,chip-id = <0x0>;
+	nx@2010000;
+	...
+};
-- 
2.1.0
