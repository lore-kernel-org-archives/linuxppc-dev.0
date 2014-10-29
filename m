Return-Path: <fabf@skynet.be>
Received: from mailrelay001.isp.belgacom.be (mailrelay001.isp.belgacom.be
 [195.238.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 5894D1A032D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 07:14:37 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 linux-next] powerpc: fix section mismatch warning
Date: Wed, 29 Oct 2014 21:14:27 +0100
Message-Id: <1414613667-2553-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding __init to MMU_setup() which uses __initdata boot_command_line.

Warning appeared since commit 3e47d1474c2b
("powerpc: Remove powerpc specific cmd_line")

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/powerpc/mm/init_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index cad68ff..415a51b 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -103,7 +103,7 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
 /*
  * Check for command-line options that affect what MMU_init will do.
  */
-void MMU_setup(void)
+void __init MMU_setup(void)
 {
 	/* Check for nobats option (used in mapin_ram). */
 	if (strstr(boot_command_line, "nobats")) {
-- 
1.9.3
