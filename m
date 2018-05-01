Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZmKr5r0mzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 12:57:36 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id i194-v6so7579280pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 19:57:36 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, anton@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [resend] Revert "powerpc/powernv: Increase memory block size to 1GB
 on radix"
Date: Tue,  1 May 2018 12:57:25 +1000
Message-Id: <20180501025725.7441-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit was a stop-gap to prevent crashes on hotunplug, caused by
the mismatch between the 1G mappings used for the linear mapping and the
memory block size. Those issues are now resolved because we split the
linear mapping at hotunplug time if necessary, as implemented in commit
4dd5f8a99e79 ("powerpc/mm/radix: Split linear mapping on hot-unplug").

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---

Resend with a newer commit message grabbed from an email sent by mpe.

 arch/powerpc/platforms/powernv/setup.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ef8c9ce53a61..fa63d3fff14c 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -356,15 +356,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static unsigned long pnv_memory_block_size(void)
 {
-	/*
-	 * We map the kernel linear region with 1GB large pages on radix. For
-	 * memory hot unplug to work our memory block size must be at least
-	 * this size.
-	 */
-	if (radix_enabled())
-		return 1UL * 1024 * 1024 * 1024;
-	else
-		return 256UL * 1024 * 1024;
+	return 256UL * 1024 * 1024;
 }
 #endif
 
-- 
2.13.6
