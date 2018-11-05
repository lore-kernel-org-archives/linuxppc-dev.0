Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7F2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 09:06:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534C820868
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 09:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534C820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pRcZ2wJtzF0jF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pRVQ62MLzF1KD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 20:01:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42pRVQ2ntgz9sB5; Mon,  5 Nov 2018 20:01:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42pRVQ2Wl3z9sB7; Mon,  5 Nov 2018 20:01:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add some documentation of ISA versions
Date: Mon,  5 Nov 2018 20:01:01 +1100
Message-Id: <20181105090101.7693-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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
Cc: mikey@neuling.org, paulus@samba.org, anton@samba.org, miltonm@realtime.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add some documentation on which CPU versions map to which ISA
versions. This is all publicly available information, some of it
already in the kernel source, but it's much nicer to have it all in
one place.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/powerpc/isa-versions.rst | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/powerpc/isa-versions.rst

Please send corrections if you notice anything wrong.

Also happy to take patches to add other CPUs and other features, this is
just a start.

diff --git a/Documentation/powerpc/isa-versions.rst b/Documentation/powerpc/isa-versions.rst
new file mode 100644
index 000000000000..812e20cc898c
--- /dev/null
+++ b/Documentation/powerpc/isa-versions.rst
@@ -0,0 +1,74 @@
+CPU to ISA Version Mapping
+==========================
+
+Mapping of some CPU versions to relevant ISA versions.
+
+========= ====================
+CPU       Architecture version
+========= ====================
+Power9    Power ISA v3.0B
+Power8    Power ISA v2.07
+Power7    Power ISA v2.06
+Power6    Power ISA v2.05
+PA6T      Power ISA v2.04
+Cell PPU  - Power ISA v2.02 with some minor exceptions
+          - Plus Altivec/VMX ~= 2.03
+Power5++  Power ISA v2.04 (no VMX)
+Power5+   Power ISA v2.03
+Power5    - PowerPC User Instruction Set Architecture Book I v2.02
+          - PowerPC Virtual Environment Architecture Book II v2.02
+          - PowerPC Operating Environment Architecture Book III v2.02
+PPC970    - PowerPC User Instruction Set Architecture Book I v2.01
+          - PowerPC Virtual Environment Architecture Book II v2.01
+          - PowerPC Operating Environment Architecture Book III v2.01
+          - Plus Altivec/VMX ~= 2.03
+========= ====================
+
+
+Key Features
+------------
+
+========== ==================
+CPU        VMX (aka. Altivec)
+========== ==================
+Power9     Yes
+Power8     Yes
+Power7     Yes
+Power6     Yes
+PA6T       Yes
+Cell PPU   Yes
+Power5++   No
+Power5+    No
+Power5     No
+PPC970     Yes
+========== ==================
+
+========== ====
+CPU        VSX
+========== ====
+Power9     Yes
+Power8     Yes
+Power7     Yes
+Power6     No
+PA6T       No
+Cell PPU   No
+Power5++   No
+Power5+    No
+Power5     No
+PPC970     No
+========== ====
+
+========== ====================
+CPU        Transactional Memory
+========== ====================
+Power9     Yes (* see transactional_memory.txt)
+Power8     Yes
+Power7     No
+Power6     No
+PA6T       No
+Cell PPU   No
+Power5++   No
+Power5+    No
+Power5     No
+PPC970     No
+========== ====================
-- 
2.17.2

