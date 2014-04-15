Return-Path: <cody@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 06503140093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 03:11:18 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 13:11:16 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3B31238C801A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:13 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3FHBDoM4063500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:11:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3FHBBwh022633
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:11 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v2 1/6] powerpc/perf/hv_24x7: probe errors changed to
 pr_debug(), padding fixed
Date: Tue, 15 Apr 2014 10:10:50 -0700
Message-Id: <1397581855-4585-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, David.Laight@aculab.com,
 Anton Blanchard <anton@samba.org>, Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fixup for "powerpc/perf: Add support for the hv 24x7 interface"

Makes the "not enabled" message less awful (and hides it in most cases).

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 297c9105..f5bca73 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -485,13 +485,13 @@ static int hv_24x7_init(void)
 	struct hv_perf_caps caps;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
-		pr_info("not a virtualized system, not enabling\n");
+		pr_debug("not a virtualized system, not enabling\n");
 		return -ENODEV;
 	}
 
 	hret = hv_perf_caps_get(&caps);
 	if (hret) {
-		pr_info("could not obtain capabilities, error 0x%80lx, not enabling\n",
+		pr_debug("could not obtain capabilities, not enabling, rc=%ld\n",
 				hret);
 		return -ENODEV;
 	}
-- 
1.9.2
