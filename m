Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427yKx4M6WzF3Cv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 16:09:09 +1000 (AEST)
Message-Id: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: fix csum_ipv6_magic() on little endian platforms
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jianlin Shi <jishi@redhat.com>, Xin Long <lucien.xin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Date: Mon, 10 Sep 2018 06:09:04 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On little endian platforms, csum_ipv6_magic() keeps len and proto in
CPU byte order. This generates a bad results leading to ICMPv6 packets
from other hosts being dropped by powerpc64le platforms.

In order to fix this, len and proto should be converted to network
byte order ie bigendian byte order. However checksumming 0x12345678
and 0x56341278 provide the exact same result so it is enough to
rotate the sum of len and proto by 1 byte.

PPC32 only support bigendian so the fix is needed for PPC64 only

Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
Reported-by: Jianlin Shi <jishi@redhat.com>
Reported-by: Xin Long <lucien.xin@gmail.com>
Cc: <stable@vger.kernel.org> # 4.18+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/checksum_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 886ed94b9c13..2a68c43e13f5 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
 	addc	r0, r8, r9
 	ld	r10, 0(r4)
 	ld	r11, 8(r4)
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	rotldi	r5, r5, 8
+#endif
 	adde	r0, r0, r10
 	add	r5, r5, r7
 	adde	r0, r0, r11
-- 
2.13.3
