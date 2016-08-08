Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Qr715kgzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 04:27:34 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u78H5YM1089611
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 14:27:32 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24n8ty988s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 14:27:32 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 12:27:31 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: add doc for ibm,hotplug-aperture
Date: Mon,  8 Aug 2016 13:27:20 -0500
In-Reply-To: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1470680843-28702-2-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 .../bindings/powerpc/opal/hotplug-aperture.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt

diff --git a/Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt b/Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt
new file mode 100644
index 0000000..b8dffaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt
@@ -0,0 +1,26 @@
+Designated hotplug memory
+-------------------------
+
+This binding describes a region of hotplug memory which is not present at boot,
+allowing its eventual NUMA associativity to be prespecified.
+
+Required properties:
+
+- compatible
+	"ibm,hotplug-aperture"
+
+- reg
+	base address and size of the region (standard definition)
+
+- ibm,associativity
+	NUMA associativity (standard definition)
+
+Example:
+
+A 2 GiB aperture at 0x100000000, to be part of nid 3 when hotplugged:
+
+	hotplug-memory@100000000 {
+		compatible = "ibm,hotplug-aperture";
+		reg = <0x0 0x100000000 0x0 0x80000000>;
+		ibm,associativity = <0x4 0x0 0x0 0x0 0x3>;
+	};
-- 
1.8.3.1
