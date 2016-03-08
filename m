Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id CED081A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 18:59:16 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH 1/1] powerpc/embedded6xx: Make reboot works on MVME5100
Date: Tue,  8 Mar 2016 08:59:12 +0100
Message-Id: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mtmsr() function hangs during restart. Make reboot works on
MVME5100 removing that function call.
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 8f65aa3..118cc33 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -179,9 +179,7 @@ static void mvme5100_show_cpuinfo(struct seq_file *m)
 
 static void mvme5100_restart(char *cmd)
 {
-
 	local_irq_disable();
-	mtmsr(mfmsr() | MSR_IP);
 
 	out_8((u_char *) restart, 0x01);
 
-- 
2.7.2
