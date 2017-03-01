Return-Path: <David.Daney@cavium.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0063.outbound.protection.outlook.com [104.47.33.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYTyX2mbgzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 09:05:07 +1100 (AEDT)
From: David Daney <david.daney@cavium.com>
To: Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Chris Metcalf <cmetcalf@mellanox.com>, Ralf Baechle <ralf@linux-mips.org>,
 Russell King <linux@armlinux.org.uk>, Rabin Vincent <rabin@rab.in>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>,
 David Daney <david.daney@cavium.com>
Subject: [PATCH] module: set __jump_table alignment to 8
Date: Wed,  1 Mar 2017 14:04:53 -0800
Message-Id: <20170301220453.4756-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For powerpc the __jump_table section in modules is not aligned, this
causes a WARN_ON() splat when loading a module containing a __jump_table.

Strict alignment became necessary with commit 3821fd35b58d
("jump_label: Reduce the size of struct static_key"), currently in
linux-next, which uses the two least significant bits of pointers to
__jump_table elements.

Fix by forcing __jump_table to 8, which is the same alignment used for
this section in the kernel proper.

Signed-off-by: David Daney <david.daney@cavium.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
---
 scripts/module-common.lds | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/module-common.lds b/scripts/module-common.lds
index 73a2c7d..53234e8 100644
--- a/scripts/module-common.lds
+++ b/scripts/module-common.lds
@@ -19,4 +19,6 @@ SECTIONS {
 
 	. = ALIGN(8);
 	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
+
+	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
-- 
2.9.3
