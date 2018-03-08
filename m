Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxWlm3GJCzF1cp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 11:36:20 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id d26so1658814pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 16:36:19 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] powerpc/powernv/mce: Don't silently restart the machine
Date: Thu,  8 Mar 2018 11:36:06 +1100
Message-Id: <20180308003606.10721-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On MCE the current code will restart the machine with
ppc_md.restart(). This case was extremely unlikely since
prior to that a skiboot call is made and that resulted in
a checkstop for analysis.

With newer skiboots, on P9 we don't checkstop the box by
default, instead we return back to the kernel to extract
useful information at the time of the MCE. While we still
get this information, this patch converts the restart to
a panic(), so that if configured a dump can be taken and
we can track and probably debug the potential issue causing
the MCE.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---

Changelog
	- Change panic to use the passed msg, instead of a hard
	coded MCE one, since this code path is common to both
	HMI's and MCE's

 arch/powerpc/platforms/powernv/opal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index c15182765ff5..516e23de5a3d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -490,9 +490,12 @@ void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
 	 *    opal to trigger checkstop explicitly for error analysis.
 	 *    The FSP PRD component would have already got notified
 	 *    about this error through other channels.
+	 * 4. We are running on a newer skiboot that by default does
+	 *    not cause a checkstop, drops us back to the kernel to
+	 *    extract context and state at the time of the error.
 	 */
 
-	ppc_md.restart(NULL);
+	panic(msg);
 }
 
 int opal_machine_check(struct pt_regs *regs)
-- 
2.13.6
