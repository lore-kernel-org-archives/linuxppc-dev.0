Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8649C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:14:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BEB2087E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7v6cdp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BEB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4319dP43JczDq68
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 07:14:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q7v6cdp5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q7v6cdp5"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4319DN2ZktzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 06:56:04 +1100 (AEDT)
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B733920864;
 Thu, 22 Nov 2018 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542916562;
 bh=J8fd+RdSOCcFObM5X+Gf/Z7EkEy3Eaymnt/mEDiVnfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q7v6cdp5/skyH4t7qqMzix8SWcAw7E4E3n37/ilQ1+1XbAmp0OL32r4UCWCvJ83cG
 OK5rDTPJxTR2zTd88G64xySM3X9SXBGdWz4VXE6do2Ph15IX5JkrQGOuBS1amAUv3l
 nBamhsqbwNr5axWcjQhex1/DWWshS+lzzvcEit8Q=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/21] powerpc/numa: Suppress "VPHN is not
 supported" messages
Date: Thu, 22 Nov 2018 14:54:48 -0500
Message-Id: <20181122195452.13520-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

[ Upstream commit 437ccdc8ce629470babdda1a7086e2f477048cbd ]

When VPHN function is not supported and during cpu hotplug event,
kernel prints message 'VPHN function not supported. Disabling
polling...'. Currently it prints on every hotplug event, it floods
dmesg when a KVM guest tries to hotplug huge number of vcpus, let's
just print once and suppress further kernel prints.

Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9fead0796364..40fb9a8835fe 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1261,7 +1261,7 @@ static long vphn_get_associativity(unsigned long cpu,
 
 	switch (rc) {
 	case H_FUNCTION:
-		printk(KERN_INFO
+		printk_once(KERN_INFO
 			"VPHN is not supported. Disabling polling...\n");
 		stop_topology_update();
 		break;
-- 
2.17.1

