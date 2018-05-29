Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w37y0NsMzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 16:03:57 +1000 (AEST)
Message-Id: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 06:03:53 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/kernel/nvram_64.o
arch/powerpc/kernel/nvram_64.c: In function 'nvram_create_partition':
arch/powerpc/kernel/nvram_64.c:1042:2: error: 'strncpy' specified bound 12 equals destination size [-Werror=stringop-truncation]
  strncpy(new_part->header.name, name, 12);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  CC      arch/powerpc/kernel/trace/ftrace.o
In function 'make_field',
    inlined from 'ps3_repository_read_boot_dat_address' at arch/powerpc/platforms/ps3/repository.c:900:9:
arch/powerpc/platforms/ps3/repository.c:106:2: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
  strncpy((char *)&n, text, 8);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2:
 - Using strnlen(src, sizeof(dest)) instead of min(strlen(src), sizeof(dest))
 - Changed nvram one to memcpy() to still fit the entire fied (thanks to benh)

 arch/powerpc/kernel/nvram_64.c          | 2 +-
 arch/powerpc/platforms/ps3/repository.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index ba681dac7b46..cf7772cdc3fd 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -1039,7 +1039,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 	new_part->index = free_part->index;
 	new_part->header.signature = sig;
 	new_part->header.length = size;
-	strncpy(new_part->header.name, name, 12);
+	memcpy(new_part->header.name, name, strnlen(name, sizeof(new_part->header.name)));
 	new_part->header.checksum = nvram_checksum(&new_part->header);
 
 	rc = nvram_write_header(new_part);
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 50dbaf24b1ee..e49c887787c4 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -101,9 +101,9 @@ static u64 make_first_field(const char *text, u64 index)
 
 static u64 make_field(const char *text, u64 index)
 {
-	u64 n;
+	u64 n = 0;
 
-	strncpy((char *)&n, text, 8);
+	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
 	return n + index;
 }
 
-- 
2.13.3
