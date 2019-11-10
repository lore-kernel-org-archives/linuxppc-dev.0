Return-Path: <SRS0=1oEm=ZC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59385C43331
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Nov 2019 03:04:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07849208C3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Nov 2019 03:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="En4ZCbQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07849208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 479f4L03hWzF4yy
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Nov 2019 14:04:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="En4ZCbQu"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 479dY703mSzF3xL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Nov 2019 13:40:59 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF8B0215EA;
 Sun, 10 Nov 2019 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573353656;
 bh=COVWsDCNKbR38Yw+05vHLBxceN6cUCoS+2GIdiYO/IE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=En4ZCbQunj0rTnalbr4gdE+QpPIiZ9LIRAGAPGKJ/HebMz/WPYd4ynkBAdvzd5JbG
 W5gm/3QN4TNT4q7tc3h3wxACg3SrgFq/v++Qb3L8J8soAVdA+kyd2V94SN12ottXuX
 FkPn2HGlRmJxXabotcBMistj70npvPhO3WiLGiyI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 030/191] powerpc/pseries: Disable CPU hotplug
 across migrations
Date: Sat,  9 Nov 2019 21:37:32 -0500
Message-Id: <20191110024013.29782-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

[ Upstream commit 85a88cabad57d26d826dd94ea34d3a785824d802 ]

When performing partition migrations all present CPUs must be online
as all present CPUs must make the H_JOIN call as part of the migration
process. Once all present CPUs make the H_JOIN call, one CPU is returned
to make the rtas call to perform the migration to the destination system.

During testing of migration and changing the SMT state we have found
instances where CPUs are offlined, as part of the SMT state change,
before they make the H_JOIN call. This results in a hung system where
every CPU is either in H_JOIN or offline.

To prevent this this patch disables CPU hotplug during the migration
process.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 9e41a9de43235..95d1264ba7952 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -985,6 +985,7 @@ int rtas_ibm_suspend_me(u64 handle)
 		goto out;
 	}
 
+	cpu_hotplug_disable();
 	stop_topology_update();
 
 	/* Call function on all CPUs.  One of us will make the
@@ -999,6 +1000,7 @@ int rtas_ibm_suspend_me(u64 handle)
 		printk(KERN_ERR "Error doing global join\n");
 
 	start_topology_update();
+	cpu_hotplug_enable();
 
 	/* Take down CPUs not online prior to suspend */
 	cpuret = rtas_offline_cpus_mask(offline_mask);
-- 
2.20.1

