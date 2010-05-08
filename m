Return-Path: <avolkov@varma-el.com>
Message-ID: <4BE5C203.6060509@varma-el.com>
Date: Sat, 08 May 2010 23:56:51 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Fix [e]glibc build process
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fix [e]glibc build process destruction (more precisely _assembler_
is die when try to compile getcontext.S since stdint.h coldn't be assembled)
intruduced by patch:

commit: 162d92dfb79a0b5fc03380b8819fa5f870ebf1e
Date: Mon, 8 Feb 2010 11:51:05 +0000 (11:51 +0000)
from: Dave Kleikamp

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>

---

 arch/powerpc/include/asm/ptrace.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 9e2d84c..025912b 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -27,8 +27,10 @@
 #ifdef __KERNEL__
 #include <linux/types.h>
 #else
+#ifndef __ASSEMBLY__
 #include <stdint.h>
 #endif
+#endif

 #ifndef __ASSEMBLY__
