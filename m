Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyWjv0WYpzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 19:37:38 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] mm: fix RODATA_TEST failure "rodata_test: test data was not
 read only"
To: Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Jinbum Park <jinb.park7@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Thu, 21 Sep 2017 11:37:28 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc, RODATA_TEST fails with message the following messages:

[    6.199505] Freeing unused kernel memory: 528K
[    6.203935] rodata_test: test data was not read only

This is because GCC allocates it to .data section:

c0695034 g     O .data	00000004 rodata_test_data

Since commit 056b9d8a76924 ("mm: remove rodata_test_data export,
add pr_fmt"), rodata_test_data is used only inside rodata_test.c
By declaring it static, it gets properly allocated into .rodata
section instead of .data:

c04df710 l     O .rodata	00000004 rodata_test_data

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 mm/rodata_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 6bb4deb12e78..d908c8769b48 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -14,7 +14,7 @@
 #include <linux/uaccess.h>
 #include <asm/sections.h>
 
-const int rodata_test_data = 0xC3;
+static const int rodata_test_data = 0xC3;
 
 void rodata_test(void)
 {
-- 
2.13.3
