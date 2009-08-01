Return-Path: <BATV+f268737823f173ec3b40+2169+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D4B02B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 23:29:37 +1000 (EST)
Subject: [PATCH] Fix perfctr oops on ppc32
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
Content-Type: text/plain
Date: Sat, 01 Aug 2009 14:29:30 +0100
Message-Id: <1249133370.24204.3.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This seems to be the reason why the Fedora rawhide 2.6.31-rc kernel
doesn't boot. With some CPUs, cur_cpu_spec->oprofile_cpu_type can be
NULL -- which makes strcmp() unhappy.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
At first glance, it looks like there are a bunch of other places which
use cur_cpu_spec->oprofile_cpu_type without first checking if it's
non-NULL, but maybe those are all 64-bit and all 64-bit cpu types have
it set?

diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
index 75ff47f..ea383c1 100644
--- a/arch/powerpc/kernel/mpc7450-pmu.c
+++ b/arch/powerpc/kernel/mpc7450-pmu.c
@@ -408,7 +408,8 @@ struct power_pmu mpc7450_pmu = {
 
 static int init_mpc7450_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
+	if (cur_cpu_spec->oprofile_cpu_type &&
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
 		return -ENODEV;
 
 	return register_power_pmu(&mpc7450_pmu);


-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
