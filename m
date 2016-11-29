Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSsx604GyzDvtC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 05:47:38 +1100 (AEDT)
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Geoff Levand <geoff@infradead.org>
Subject: powerpc/ps3: Fix system hang with GCC 5 builds
Message-ID: <0778d754-b261-9d69-d309-a12970ce1cfa@infradead.org>
Date: Tue, 29 Nov 2016 10:47:32 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC 5 generates different code for this bootwrapper null check
that causes the PS3 to hang very early in its bootup.  This
check is of limited value, so just get rid of it.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
  arch/powerpc/boot/ps3-head.S | 5 -----
  arch/powerpc/boot/ps3.c      | 8 +-------
  2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/ps3-head.S b/arch/powerpc/boot/ps3-head.S
index b6fcbaf..3dc44b0 100644
--- a/arch/powerpc/boot/ps3-head.S
+++ b/arch/powerpc/boot/ps3-head.S
@@ -57,11 +57,6 @@ __system_reset_overlay:
  	bctr
  
  1:
-	/* Save the value at addr zero for a null pointer write check later. */
-
-	li	r4, 0
-	lwz	r3, 0(r4)
-
  	/* Primary delays then goes to _zimage_start in wrapper. */
  
  	or	31, 31, 31 /* db16cyc */
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 4ec2d86..a05558a 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -119,13 +119,12 @@ void ps3_copy_vectors(void)
  	flush_cache((void *)0x100, 512);
  }
  
-void platform_init(unsigned long null_check)
+void platform_init(void)
  {
  	const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */
  	void *chosen;
  	unsigned long ft_addr;
  	u64 rm_size;
-	unsigned long val;
  
  	console_ops.write = ps3_console_write;
  	platform_ops.exit = ps3_exit;
@@ -153,11 +152,6 @@ void platform_init(unsigned long null_check)
  
  	printf(" flat tree at 0x%lx\n\r", ft_addr);
  
-	val = *(unsigned long *)0;
-
-	if (val != null_check)
-		printf("null check failed: %lx != %lx\n\r", val, null_check);
-
  	((kernel_entry_t)0)(ft_addr, 0, NULL);
  
  	ps3_exit();
-- 
2.7.4
