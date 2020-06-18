Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F19C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 04:19:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3989D21924
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 04:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yRBNzmCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3989D21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nTGF3rdgzDqh2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 14:19:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=yRBNzmCF; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nPTv74hbzDqqJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 11:28:51 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE0772222C;
 Thu, 18 Jun 2020 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592443728;
 bh=k5fJn4/BHCsHWqjor/jslrTNiMZt/S9sgjvZvWRPe4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yRBNzmCFyFgWkeWTPrZFHOa8X049PZz5Kp/S5c93CbbpFOsqVplG7ShN46kcjZbHV
 QSqDCZImL3i7vkV26Jvrm3ofSdXrRdx1pfa24vtWuqirDSgyeYjoT4PpX5xXGzHCSl
 Dw7HUX6WcuUiQbMA3for/ApbqGamU9Hgw5EjxWVU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 23/80] powerpc/crashkernel: Take "mem=" option
 into account
Date: Wed, 17 Jun 2020 21:27:22 -0400
Message-Id: <20200618012819.609778-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Hari Bathini <hbathini@linux.ibm.com>, Pingfan Liu <kernelfans@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Pingfan Liu <kernelfans@gmail.com>

[ Upstream commit be5470e0c285a68dc3afdea965032f5ddc8269d7 ]

'mem=" option is an easy way to put high pressure on memory during
some test. Hence after applying the memory limit, instead of total
mem, the actual usable memory should be considered when reserving mem
for crashkernel. Otherwise the boot up may experience OOM issue.

E.g. it would reserve 4G prior to the change and 512M afterward, if
passing
crashkernel="2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G",
and mem=5G on a 256G machine.

This issue is powerpc specific because it puts higher priority on
fadump and kdump reservation than on "mem=". Referring the following
code:
    if (fadump_reserve_mem() == 0)
            reserve_crashkernel();
    ...
    /* Ensure that total memory size is page-aligned. */
    limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
    memblock_enforce_memory_limit(limit);

While on other arches, the effect of "mem=" takes a higher priority
and pass through memblock_phys_mem_size() before calling
reserve_crashkernel().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1585749644-4148-1-git-send-email-kernelfans@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/machine_kexec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 9dafd7af39b8..cb4d6cd949fc 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -113,11 +113,12 @@ void machine_kexec(struct kimage *image)
 
 void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base;
+	unsigned long long crash_size, crash_base, total_mem_sz;
 	int ret;
 
+	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, total_mem_sz,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
@@ -176,6 +177,7 @@ void __init reserve_crashkernel(void)
 	/* Crash kernel trumps memory limit */
 	if (memory_limit && memory_limit <= crashk_res.end) {
 		memory_limit = crashk_res.end + 1;
+		total_mem_sz = memory_limit;
 		printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
 		       memory_limit);
 	}
@@ -184,7 +186,7 @@ void __init reserve_crashkernel(void)
 			"for crashkernel (System RAM: %ldMB)\n",
 			(unsigned long)(crash_size >> 20),
 			(unsigned long)(crashk_res.start >> 20),
-			(unsigned long)(memblock_phys_mem_size() >> 20));
+			(unsigned long)(total_mem_sz >> 20));
 
 	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
 	    memblock_reserve(crashk_res.start, crash_size)) {
-- 
2.25.1

