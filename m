Return-Path: <linuxppc-dev+bounces-22527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6EFCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 22:19:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbxsL3D9Zz2xl5;
	Fri, 12 Jun 2026 08:19:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781203403;
	cv=none; b=g4FSVlgWLkq6TJHKo12gJvcpIk6wmBs4CQtbZzRBY3liiTwotsLpk1igqKND3Q2iFEKjHOULv4M3cjkM73zLZo6Zjo5H2rEdd4MdP+1uok3ZV/2z4FDf4cqynSqhLU223Lc0bdYii72l4rlXzBHVPH1WCVKWXGi2E+O2KXaER2X2VWvbRWtWWiYIQQ5Gzab5PB0ASMUGZfS98L24+H44/16q7S2Rt1DSFrjtm7tVYGaZg6AXHXaOLcJ5zrYecmHoY5G8CArX4XMZVFZST5vQyDa1c5xMDCZ/ho5ZbFAqpqRrElMGxKs3xFGDXfFdHimBwnEn9eD9KbTj+r+ote7Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781203403; c=relaxed/relaxed;
	bh=Dkv0Y88H+SR6ILk9sT/YTT+0skYukMCzceYVycVftns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4tqR57HpWHKf/12rUmLSaV2Lk7oKNXEzjFEGDucUYAwUWpFbosN+5/3HTEpwMTd1vno7t26JSHQqeA/TO7vEPhinovLGcKDDdygjFR5xlddGWrHlRuHaAuIKqrDu04KkP893EaB0WcCnaJLBXJXlyQYPYEAN0dA9YtwMPSbLuTWT1yTnCeVIXWilSwnP11NGHKn3pCthc4/ZljpJLq0wBB7+/K1eFPD5pQ1psYCxqEoNZ4re4sInMQjXQay8sfRr7kvHl/PhaJXUcWu0in8g2gkVCsBEZdDrhER2wDcivhfSytvHH/f08PB4RxVTzqBn3fvHkml13jH/gzb0Os7mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dDcc08x0; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=yHxSM7TA; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dDcc08x0;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=yHxSM7TA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 358 seconds by postgrey-1.37 at boromir; Fri, 12 Jun 2026 04:43:18 AEST
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbs3V2FJmz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 04:43:17 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gbrwN2g2kz9tWv;
	Thu, 11 Jun 2026 20:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781203028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dkv0Y88H+SR6ILk9sT/YTT+0skYukMCzceYVycVftns=;
	b=dDcc08x0dcrKswHlCVxuROso1L8H2qo5xxLwb2GdvV2xY4AFA5F9RTOimgpKn5pxzpRufh
	tuzqlDg4A/rMg7HKbaHXE3Vn8IMzlSkyObAvpKbFCrjOXigEghkfPqHyz21cbPm/v+RB2l
	lKbNlYW77r7imN2qll75tefdhZS8Z9cFOW+c5+P8mS+wPK4d4VwSyRmVXFe92peAB8WLng
	A5/8uiQVtk2fibFWyO1c3OU9AeUBbNZgE1rYZdsN/u0W8kE0k69/i6qInDr/o2vEse8Kkc
	7lH0fpN/C1Hu12dfoxky+PSj7B3F9OEOn08lRas9tdnimqiR3kdSw4VZBudakg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781203022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dkv0Y88H+SR6ILk9sT/YTT+0skYukMCzceYVycVftns=;
	b=yHxSM7TAtkgtiG7evw5aBg+nfR1e5mMA5TA7y6XTlvnRHkWVkwOgn7nzTTVwgiJfxrlSPw
	Fq6b2wdI56NyVbncWKl66lO/iR9AszePqYiGiIJS1Lnjbk/DbXPERUSPgNsiAwW8Xv8gBr
	9sJTd5vM8OCzoTh48DBrJTg+X4eYfzigRIXzj5phRIFhp3mxRKM/hXHh9qnPi3MkMWml1z
	9AbAxExj8Rl6A86dy7oZMZIJIUm83Z4Y6TQoBFXIF9dNdlS3J1vNIZLdCAFK8O2yqXcnEj
	+bODCeBRbhc1fQWZrgL1UmtZcarxtrM5WqAJEGAWdVgLtWZN++53G17Pw0dPfw==
To: Vineet Gupta <vgupta@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] Documentation: arch: fix brackets
Date: Thu, 11 Jun 2026 20:35:20 +0200
Message-ID: <20260611183525.153058-2-manuelebner@mailbox.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f6zk6t8i7udhsfuxo6bwkb9axkpyzqtj
X-MBO-RS-ID: 29289ebd505fa1394bb

Add missing and remove needless parentheses, brackets and curly braces.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/arch/arc/arc.rst                 |  2 +-
 .../arm/samsung/clksrc-change-registers.awk    |  2 +-
 Documentation/arch/arm/vlocks.rst              |  4 ++--
 .../arch/arm64/memory-tagging-extension.rst    |  2 +-
 Documentation/arch/powerpc/vas-api.rst         |  2 +-
 Documentation/arch/sparc/oradax/dax-hv-api.txt | 18 +++++++++---------
 Documentation/arch/sparc/oradax/oracle-dax.rst |  3 ++-
 7 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/arch/arc/arc.rst b/Documentation/arch/arc/arc.rst
index 6c4d978f3f4e..553851f43be7 100644
--- a/Documentation/arch/arc/arc.rst
+++ b/Documentation/arch/arc/arc.rst
@@ -36,7 +36,7 @@ Important note on ARC processors configurability
 
 ARC processors are highly configurable and several configurable options
 are supported in Linux. Some options are transparent to software
-(i.e cache geometries, some can be detected at runtime and configured
+(i.e cache geometries), some can be detected at runtime and configured
 and used accordingly, while some need to be explicitly selected or configured
 in the kernel's configuration utility (AKA "make menuconfig").
 
diff --git a/Documentation/arch/arm/samsung/clksrc-change-registers.awk b/Documentation/arch/arm/samsung/clksrc-change-registers.awk
index 7be1b8aa7cd9..48464397088c 100755
--- a/Documentation/arch/arm/samsung/clksrc-change-registers.awk
+++ b/Documentation/arch/arm/samsung/clksrc-change-registers.awk
@@ -163,4 +163,4 @@ BEGIN {
     }
 }
 
-// && ! /clksrc_clk.*=.*{/ { print $0 }
+// && ! /clksrc_clk.*=.*{/ { print $0 }}
diff --git a/Documentation/arch/arm/vlocks.rst b/Documentation/arch/arm/vlocks.rst
index 737aa8661a21..b0ac33263086 100644
--- a/Documentation/arch/arm/vlocks.rst
+++ b/Documentation/arch/arm/vlocks.rst
@@ -102,10 +102,10 @@ Features and limitations
 	if (I_won) {
 		/* we won the town election, let's go for the state */
 		my_state = states[(this_cpu >> 8) & 0xf];
-		I_won = vlock_lock(my_state, this_cpu & 0xf));
+		I_won = vlock_lock(my_state, this_cpu & 0xf);
 		if (I_won) {
 			/* and so on */
-			I_won = vlock_lock(the_whole_country, this_cpu & 0xf];
+			I_won = vlock_lock(the_whole_country, this_cpu & 0xf);
 			if (I_won) {
 				/* ... */
 			}
diff --git a/Documentation/arch/arm64/memory-tagging-extension.rst b/Documentation/arch/arm64/memory-tagging-extension.rst
index 679725030731..e6fe428f0e2a 100644
--- a/Documentation/arch/arm64/memory-tagging-extension.rst
+++ b/Documentation/arch/arm64/memory-tagging-extension.rst
@@ -222,7 +222,7 @@ programs should not retry in case of a non-zero system call return.
 address ABI control and MTE configuration of a process as per the
 ``prctl()`` options described in
 Documentation/arch/arm64/tagged-address-abi.rst and above. The corresponding
-``regset`` is 1 element of 8 bytes (``sizeof(long))``).
+``regset`` is 1 element of 8 bytes (``sizeof(long)``).
 
 Core dump support
 -----------------
diff --git a/Documentation/arch/powerpc/vas-api.rst b/Documentation/arch/powerpc/vas-api.rst
index a9625a2fa0c6..1d0d055356e3 100644
--- a/Documentation/arch/powerpc/vas-api.rst
+++ b/Documentation/arch/powerpc/vas-api.rst
@@ -293,7 +293,7 @@ Simple example
 				//Format CRB request with compression or
 				//uncompression
 				// Refer tests for vas_copy/vas_paste
-				vas_copy((&crb, 0, 1);
+				vas_copy(&crb, 0, 1);
 				vas_paste(addr, 0, 1);
 				// Poll on csb.flags with timeout
 				// csb address is listed in CRB
diff --git a/Documentation/arch/sparc/oradax/dax-hv-api.txt b/Documentation/arch/sparc/oradax/dax-hv-api.txt
index ef1a4c2bf08b..ef6088aeaa66 100644
--- a/Documentation/arch/sparc/oradax/dax-hv-api.txt
+++ b/Documentation/arch/sparc/oradax/dax-hv-api.txt
@@ -457,7 +457,7 @@ bits set, and terminate at a CCB that has the Conditional bit set, but not the P
 Offset   Size   Field Description
                 Bits         Field Description
                 [15:14]      Secondary Input Element Size (see Section 36.2.1.1.4,
-                             “Secondary Input Element Size”
+                             “Secondary Input Element Size”)
                 [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
                 [9]          Padding Direction selector: A value of 1 causes padding bytes
                              to be added to the left side of output elements. A value of 0
@@ -656,7 +656,7 @@ Offset         Size            Field Description
                                [18:16]      Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
                                             Element Offsets”)
                                [15:14]      Secondary Input Element Size (see Section 36.2.1.1.4,
-                                            “Secondary Input Element Size”
+                                            “Secondary Input Element Size”)
                                [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
                                [9:5]        Operand size for first scan criteria value. In a scan value
                                             operation, this is one of two potential exact match values.
@@ -793,13 +793,13 @@ Offset   Size   Field Description
                 [18:16]      Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
                              Element Offsets”)
                 [15:14]      Secondary Input Element Size (see Section 36.2.1.1.4,
-                             “Secondary Input Element Size”
+                             “Secondary Input Element Size”)
                 [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
                 [9]          Reserved
                 [8:0]        Test value used for comparison against the most significant bits
                              in the input values, when using 2 or 3 byte input elements.
-8        8      Completion (same fields as Section 36.2.1.2, “Extract command”
-16       8      Primary Input (same fields as Section 36.2.1.2, “Extract command”
+8        8      Completion (same fields as Section 36.2.1.2, “Extract command)”
+16       8      Primary Input (same fields as Section 36.2.1.2, “Extract command”)
 24       8      Data Access Control (same fields as Section 36.2.1.2, “Extract command”,
                 except Primary Input Length Format may not use the 0x0 value)
 32       8      Secondary Input, if used by Primary Input Format. Same fields as Primary
@@ -880,7 +880,7 @@ Offset   Size   Field Description
                                        [18:16]     Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
                                                    Element Offsets”)
                                        [15:14]     Secondary Input Element Size (see Section 36.2.1.1.4,
-                                                   “Secondary Input Element Size”
+                                                   “Secondary Input Element Size”)
 
 
                                                       524
@@ -895,8 +895,8 @@ Offset   Size   Field Description
                                                     causes padding bytes to be added to the right side of output
                                                     elements.
                                        [8:0]        Reserved
-        8              8               Completion (same fields as Section 36.2.1.2, “Extract command”
-        16             8               Primary Input (same fields as Section 36.2.1.2, “Extract command”
+        8              8               Completion (same fields as Section 36.2.1.2, “Extract command”)
+        16             8               Primary Input (same fields as Section 36.2.1.2, “Extract command”)
         24             8               Data Access Control (same fields as Section 36.2.1.2, “Extract command”)
         32             8               Secondary Bit Vector Input. Same fields as Primary Input.
         40             8               Reserved
@@ -949,7 +949,7 @@ Offset   Size   Field Description
                                    [31]        If set, this CCB functions as a Sync command. If clear, this
                                                CCB functions as a No-op command.
                                    [30:0]      Reserved
-       8             8             Completion (same fields as Section 36.2.1.2, “Extract command”
+       8             8             Completion (same fields as Section 36.2.1.2, “Extract command”)
        16            46            Reserved
 
 36.2.2. CCB Completion Area
diff --git a/Documentation/arch/sparc/oradax/oracle-dax.rst b/Documentation/arch/sparc/oradax/oracle-dax.rst
index d1e14d572918..67867ea7be40 100644
--- a/Documentation/arch/sparc/oradax/oracle-dax.rst
+++ b/Documentation/arch/sparc/oradax/oracle-dax.rst
@@ -438,7 +438,8 @@ that in user land::
 The output bitmap is ready for consumption immediately after the
 completion status indicates success.
 
-Excer[t from UltraSPARC Virtual Machine Specification
+Excer?t from UltraSPARC Virtual Machine Specification
+i guess this is wrong, but i don't know what's correct
 =====================================================
 
  .. include:: dax-hv-api.txt
-- 
2.54.0


