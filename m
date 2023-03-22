Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FC7C6FD1C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Mar 2023 03:36:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhDfR4r2Mz3cj7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Mar 2023 14:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SHIscMUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=126.com (client-ip=220.181.12.29; helo=m126.mail.126.com; envelope-from=windhl@126.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SHIscMUX;
	dkim-atps=neutral
X-Greylist: delayed 1825 seconds by postgrey-1.36 at boromir; Wed, 22 Mar 2023 14:35:35 AEDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhDdM12wMz3c2j
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2023 14:35:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=F+3Kf
	CSK6KUGSAgjIPLcuQEtKa3TJE/IcMpjTXLV1rU=; b=SHIscMUXNjSePtkd6gptY
	M9yhL8S2lSwT75WBkMkmAb6E58jxTPZxi1CH/gQdP5F6G4Dzrxffo6FM5dGRuzyT
	PTUOW0M8hY3H/VJLs9Z0uFqnhnMl14d8l2cEiHVCawHDvfU5BWFSx+SV4VoChPBv
	ZYmY4cqD3UgprvM3Yb7Z2M=
Received: from localhost.localdomain (unknown [124.16.139.61])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wBnOFI3cBpkuYWWAQ--.2256S2;
	Wed, 22 Mar 2023 11:04:24 +0800 (CST)
From: Liang He <windhl@126.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	windhl@126.com
Subject: [PATCH] powerpc/mpc5xxx: Add missing fwnode_handle_put()
Date: Wed, 22 Mar 2023 11:04:23 +0800
Message-Id: <20230322030423.1855440-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnOFI3cBpkuYWWAQ--.2256S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw18JF15trW8XrW7CF4fAFb_yoWDCFX_Ka
	s7uFyxArs8Jr1rCFs3AryfJ3y7J3y5GryxCr1Ig34xJw1Yk3yDZrWIvFyUWryUuayayay5
	G3yUtwsxAa4S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKD737UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAA6F2JVmg8uBAAAsd
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In mpc5xxx_fwnode_get_bus_frequency(), we should add
fwnode_handle_put() when break out of the iteration
fwnode_for_each_parent_node() as it will automatically
increase and decrease the refcounter.

Fixes: de06fba62af6 ("powerpc/mpc5xxx: Switch mpc5xxx_get_bus_frequency() to use fwnode")
Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/sysdev/mpc5xxx_clocks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
index c5bf7e1b3780..58cee28e2399 100644
--- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -25,8 +25,10 @@ unsigned long mpc5xxx_fwnode_get_bus_frequency(struct fwnode_handle *fwnode)
 
 	fwnode_for_each_parent_node(fwnode, parent) {
 		ret = fwnode_property_read_u32(parent, "bus-frequency", &bus_freq);
-		if (!ret)
+		if (!ret) {
+			fwnode_handle_put(parent);
 			return bus_freq;
+		}
 	}
 
 	return 0;
-- 
2.25.1

