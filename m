Return-Path: <tomof@acm.org>
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] spufs: fix compile error
Date: Tue, 13 May 2008 18:07:42 +0900
Message-Id: <1210669662-17780-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: fujita <tomof@acm.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, paulus@samba.org,
	jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With CONFIG_VIRT_CPU_ACCOUNTING disabled, I got the following error:

linux-2.6/arch/powerpc/platforms/cell/spufs/file.c: In function 'spu_switch_log_notify':
linux-2.6/arch/powerpc/platforms/cell/spufs/file.c:2542: error: implicit declaration of function 'get_tb'
make[4]: *** [arch/powerpc/platforms/cell/spufs/file.o] Error 1

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/platforms/cell/spufs/file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 80911a3..c81341f 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -32,6 +32,7 @@
 #include <linux/marker.h>
 
 #include <asm/io.h>
+#include <asm/time.h>
 #include <asm/spu.h>
 #include <asm/spu_info.h>
 #include <asm/uaccess.h>
-- 
1.5.4.2
