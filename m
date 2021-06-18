Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC718C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 03:54:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8686113C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 03:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8686113C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5lRn4Tr6z3cFc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:54:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=NFPxsyiX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=NFPxsyiX; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5lMM5VJ6z3c02
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 13:50:55 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G5lML5vkjz9sXN; Fri, 18 Jun 2021 13:50:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4G5lML5NKxz9sj1; Fri, 18 Jun 2021 13:50:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1623988254; bh=CcxyT4e8OBvNkp7XWwfzYsj7Af5mzi5Wuftr2lML6Rs=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=NFPxsyiXZuiA/2B/Prga+rGeRZIXQElzYHuiYpEeCO+3WOFqTdQWCFvYOCc+6sLTb
 Y9ODhKzyMEsqJZA6c3qtENcp7fRWz3yM+wE0Gq/9JPzqhGL2Cj+rpuS1GfaSu2xEnV
 SV2LMhN87LhjyDgZpMAxvNmbPt/O2xoBdR1OLt+FTzd9mxfCDamrwymyAYTZJBAPOS
 xYEfrUotrPY8xgSZpgkQulO3A9r2P1oj52HepVFc75ZE+5ZBtiUnhUiXtN5O18j+ir
 vUgJVZGwA3pehItAMsQ5tAzMi+zoAFNzN5dJ4B8syYPh6/0ZdXUtCM++JpIxDAmDSn
 FoVR4bFSC429Q==
Date: Fri, 18 Jun 2021 13:45:11 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/9] powerpc/microwatt: Populate platform bus from
 device-tree
Message-ID: <YMwWx98+PMibZq/G@thinks.paulus.ozlabs.org>
References: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Just like any other embedded platform.

Add an empty soc node.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/boot/dts/microwatt.dts      | 7 +++++++
 arch/powerpc/platforms/microwatt/setup.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/boot/dts/microwatt.dts b/arch/powerpc/boot/dts/microwatt.dts
index ac264ad3faaf..9b6140c90370 100644
--- a/arch/powerpc/boot/dts/microwatt.dts
+++ b/arch/powerpc/boot/dts/microwatt.dts
@@ -95,4 +95,11 @@ chosen {
 					  00 00 00 00 00 00 00 00 40 00 40];
 	};
 
+	soc@c0000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ranges = <0 0 0xc0000000 0x40000000>;
+	};
 };
diff --git a/arch/powerpc/platforms/microwatt/setup.c b/arch/powerpc/platforms/microwatt/setup.c
index d80d52612672..5af4adf881bc 100644
--- a/arch/powerpc/platforms/microwatt/setup.c
+++ b/arch/powerpc/platforms/microwatt/setup.c
@@ -8,6 +8,8 @@
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
 
@@ -16,6 +18,12 @@ static int __init microwatt_probe(void)
 	return of_machine_is_compatible("microwatt-soc");
 }
 
+static int __init microwatt_populate(void)
+{
+	return of_platform_default_populate(NULL, NULL, NULL);
+}
+machine_arch_initcall(microwatt, microwatt_populate);
+
 define_machine(microwatt) {
 	.name			= "microwatt",
 	.probe			= microwatt_probe,
-- 
2.31.1

