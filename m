Return-Path: <SRS0=kV/c=XT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C2C432C2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 16:56:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F97620665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ3iZUKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F97620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46d6lK0M6yzDqDb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 02:55:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="YQ3iZUKL"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46d6T5248RzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 02:43:37 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8623D21783;
 Tue, 24 Sep 2019 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569343415;
 bh=3loIcDQngfLweMnZa6U8G6TzR0+So+oYGalFp8PX9FM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YQ3iZUKL242p9lOOq0iYnIJvRngFeB7O2gj+2Zgb3Z4Zr3KY8l03XHWNJKfLW9W89
 m1v+2wk6qMyF/fv2IGMGXZUwRnV+O2qnfP5sHd/8EKIYtdK7UTX2Ny8ZDH0BAxmR7n
 m91msdRcinaKCWyg9ldcXuSkBzND7XPX8fuFl+/w=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 42/87] powerpc/xmon: Check for HV mode when
 dumping XIVE info from OPAL
Date: Tue, 24 Sep 2019 12:40:58 -0400
Message-Id: <20190924164144.25591-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Cédric Le Goater <clg@kaod.org>

[ Upstream commit c3e0dbd7f780a58c4695f1cd8fc8afde80376737 ]

Currently, the xmon 'dx' command calls OPAL to dump the XIVE state in
the OPAL logs and also outputs some of the fields of the internal XIVE
structures in Linux. The OPAL calls can only be done on baremetal
(PowerNV) and they crash a pseries machine. Fix by checking the
hypervisor feature of the CPU.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190814154754.23682-2-clg@kaod.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 14e56c25879fa..25d4adccf750f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2534,13 +2534,16 @@ static void dump_pacas(void)
 static void dump_one_xive(int cpu)
 {
 	unsigned int hwid = get_hard_smp_processor_id(cpu);
-
-	opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_POOL, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_OS, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_USER, hwid);
-	opal_xive_dump(XIVE_DUMP_VP, hwid);
-	opal_xive_dump(XIVE_DUMP_EMU_STATE, hwid);
+	bool hv = cpu_has_feature(CPU_FTR_HVMODE);
+
+	if (hv) {
+		opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
+		opal_xive_dump(XIVE_DUMP_TM_POOL, hwid);
+		opal_xive_dump(XIVE_DUMP_TM_OS, hwid);
+		opal_xive_dump(XIVE_DUMP_TM_USER, hwid);
+		opal_xive_dump(XIVE_DUMP_VP, hwid);
+		opal_xive_dump(XIVE_DUMP_EMU_STATE, hwid);
+	}
 
 	if (setjmp(bus_error_jmp) != 0) {
 		catch_memory_errors = 0;
-- 
2.20.1

