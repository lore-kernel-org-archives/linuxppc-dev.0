Return-Path: <SRS0=Gjys=LP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21009C49361
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 06:50:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3905E6109E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 06:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3905E6109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G7gC23bcgz3btv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 16:50:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=d9afjnhq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=d9afjnhq; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G7gBQ4xKBz2yXd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 16:49:50 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G7gBG5gw9z9sWM; Mon, 21 Jun 2021 16:49:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1624258182;
 bh=MUJYhz0XfkAq6cNhnd9n85QD6OvL7N7pHUuZimBLQuc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=d9afjnhqGvsSpZsNBq03bqaDU7iyW/d+GfVIr+DbjTjntnugfeYpiJvVlh+VmO+Ng
 EqLQREstGl3rYwtKfcvvhVxFTmFt5Dz8JqVm1+MrGJbixIlwX8ybksVqKQgFnyWHKe
 sylNQ/U98B56mq38GLzr1rr3CdvN6L4y8FTmUhKILcWSRk5lRTcBY2eRmNpHCYWjWC
 UtYwCWuoD8LmDpkPcMDKbPwBzu8Jznf4iTkKpVHpB9BHy+guv6O/tgNVUKOHUyEF7U
 90lnJgz8ME0N+DYakHeMRagOdKmIPOqEQdsLrqAF1wyEuoscdLXj6q/n2bZblPOexc
 i1GWfm2oqaKXg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/prom_init: Pass linux_banner to firmware via
 option vector 7
Date: Mon, 21 Jun 2021 16:49:38 +1000
Message-Id: <20210621064938.2021419-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621064938.2021419-1-mpe@ellerman.id.au>
References: <20210621064938.2021419-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Pass the value of linux_banner to firmware via option vector 7.

Option vector 7 is described in "LoPAR" Linux on Power Architecture
Reference v2.9, in table B.7 on page 824:

  An ASCII character formatted null terminated string that describes
  the client operating system. The string shall be human readable and
  may be displayed on the console.

The string can be up to 256 bytes total, including the nul terminator.

linux_banner contains lots of information, and should make it possible
to identify the exact kernel version that is running:

  const char linux_banner[] =
  "Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
  LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";

For example:
  Linux version 4.15.0-144-generic (buildd@bos02-ppc64el-018) (gcc
  version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #148-Ubuntu SMP Sat May 8
  02:32:13 UTC 2021 (Ubuntu 4.15.0-144.148-generic 4.15.18)

It's also printed at boot to the console/dmesg, which should make it
possible to correlate what firmware receives with the console/dmesg on
the machine.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

NB. linux_banner is already allowed by prom_init_check.sh

LoPAR: https://openpowerfoundation.org/?resource_lib=linux-on-power-architecture-reference-a-papr-linux-subset-review-draft
---
 arch/powerpc/kernel/prom_init.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index c18d55f8b951..7343076b261c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -27,6 +27,7 @@
 #include <linux/initrd.h>
 #include <linux/bitops.h>
 #include <linux/pgtable.h>
+#include <linux/printk.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -944,6 +945,10 @@ struct option_vector6 {
 	u8 os_name;
 } __packed;
 
+struct option_vector7 {
+	u8 os_id[256];
+} __packed;
+
 struct ibm_arch_vec {
 	struct { u32 mask, val; } pvrs[14];
 
@@ -966,6 +971,9 @@ struct ibm_arch_vec {
 
 	u8 vec6_len;
 	struct option_vector6 vec6;
+
+	u8 vec7_len;
+	struct option_vector7 vec7;
 } __packed;
 
 static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
@@ -1112,6 +1120,9 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 		.secondary_pteg = 0,
 		.os_name = OV6_LINUX,
 	},
+
+	/* option vector 7: OS Identification */
+	.vec7_len = VECTOR_LENGTH(sizeof(struct option_vector7)),
 };
 
 static struct ibm_arch_vec __prombss ibm_architecture_vec  ____cacheline_aligned;
@@ -1340,6 +1351,10 @@ static void __init prom_check_platform_support(void)
 	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
 	       sizeof(ibm_architecture_vec));
 
+	prom_strscpy_pad(ibm_architecture_vec.vec7.os_id, linux_banner, 256);
+	// Ensure nul termination
+	ibm_architecture_vec.vec7.os_id[255] = '\0';
+
 	if (prop_len > 1) {
 		int i;
 		u8 vec[8];
-- 
2.25.1

