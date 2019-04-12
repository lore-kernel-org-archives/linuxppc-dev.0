Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BBAC10F13
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 01:46:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28D32186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 01:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyCakz6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28D32186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gLMt6cGNzDqTL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=okaya@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="uyCakz6U"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gLKV5MvHzDqTk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 11:44:12 +1000 (AEST)
Received: from
 sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown
 [52.191.113.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F083D2184B;
 Fri, 12 Apr 2019 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1555033449;
 bh=b+3JRdiqd3xm94iRtsnB84wYg5vwpS62BhaMpIzJp+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uyCakz6UAf5YhBO5j3uPZlvrzJK8/6bhvMuVZo5EWTD7ZEmeGQS9kdxkBfH6TEnd3
 b5LHogS4NNNFh42WlI9xhFH5Q9O6lo9d4WYeo58wwOvkK0uja9mfL7bN7wnz/sMg4R
 DDAYgZZwf4bI/+LXB8A9nNahIJLa5GG8vjufjD9U=
From: Sinan Kaya <okaya@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] powerpc: Replace CONFIG_DEBUG_KERNEL with
 CONFIG_DEBUG_MISC
Date: Fri, 12 Apr 2019 01:43:52 +0000
Message-Id: <20190412014355.25307-3-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412014355.25307-1-okaya@kernel.org>
References: <20190412014355.25307-1-okaya@kernel.org>
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
Cc: keescook@chromium.org, Sinan Kaya <okaya@kernel.org>, josh@joshtriplett.org,
 Paul Mackerras <paulus@samba.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
defined CONFIG_DEBUG_MISC instead to keep the current code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/powerpc/kernel/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index e8e93c2c7d03..7a1708875d27 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -610,7 +610,7 @@ SYSFS_PMCSETUP(pa6t_pmc2, SPRN_PA6T_PMC2);
 SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
 SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
 SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_MISC
 SYSFS_SPRSETUP(hid0, SPRN_HID0);
 SYSFS_SPRSETUP(hid1, SPRN_HID1);
 SYSFS_SPRSETUP(hid4, SPRN_HID4);
@@ -639,7 +639,7 @@ SYSFS_SPRSETUP(tsr0, SPRN_PA6T_TSR0);
 SYSFS_SPRSETUP(tsr1, SPRN_PA6T_TSR1);
 SYSFS_SPRSETUP(tsr2, SPRN_PA6T_TSR2);
 SYSFS_SPRSETUP(tsr3, SPRN_PA6T_TSR3);
-#endif /* CONFIG_DEBUG_KERNEL */
+#endif /* CONFIG_DEBUG_MISC */
 #endif /* HAS_PPC_PMC_PA6T */
 
 #ifdef HAS_PPC_PMC_IBM
@@ -680,7 +680,7 @@ static struct device_attribute pa6t_attrs[] = {
 	__ATTR(pmc3, 0600, show_pa6t_pmc3, store_pa6t_pmc3),
 	__ATTR(pmc4, 0600, show_pa6t_pmc4, store_pa6t_pmc4),
 	__ATTR(pmc5, 0600, show_pa6t_pmc5, store_pa6t_pmc5),
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_MISC
 	__ATTR(hid0, 0600, show_hid0, store_hid0),
 	__ATTR(hid1, 0600, show_hid1, store_hid1),
 	__ATTR(hid4, 0600, show_hid4, store_hid4),
@@ -709,7 +709,7 @@ static struct device_attribute pa6t_attrs[] = {
 	__ATTR(tsr1, 0600, show_tsr1, store_tsr1),
 	__ATTR(tsr2, 0600, show_tsr2, store_tsr2),
 	__ATTR(tsr3, 0600, show_tsr3, store_tsr3),
-#endif /* CONFIG_DEBUG_KERNEL */
+#endif /* CONFIG_DEBUG_MISC */
 };
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
-- 
2.21.0

