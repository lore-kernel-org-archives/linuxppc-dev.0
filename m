Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EC99DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:01:12 +1100 (EST)
Received: from [99.236.101.138] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1IpRzQ-0007qG-Kv
	for linuxppc-dev@ozlabs.org; Tue, 06 Nov 2007 12:13:24 -0500
Date: Tue, 6 Nov 2007 12:11:42 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC: Use "is_power_of_2" macro for simplicity.
Message-ID: <Pine.LNX.4.64.0711061210520.25269@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 22c3b4f..53b4e91 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/log2.h>

 #include <asm/rheap.h>

@@ -254,8 +255,7 @@ rh_info_t *rh_create(unsigned int alignment)
 {
 	rh_info_t *info;

-	/* Alignment must be a power of two */
-	if ((alignment & (alignment - 1)) != 0)
+	if (!is_power_of_2(alignment))
 		return ERR_PTR(-EINVAL);

 	info = kmalloc(sizeof(*info), GFP_KERNEL);
@@ -303,8 +303,7 @@ void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 	int i;
 	rh_block_t *blk;

-	/* Alignment must be a power of two */
-	if ((alignment & (alignment - 1)) != 0)
+	if (!is_power_of_2(alignment))
 		return;

 	info->alignment = alignment;
@@ -446,8 +445,7 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 	rh_block_t *newblk;
 	unsigned long start, sp_size;

-	/* Validate size, and alignment must be power of two */
-	if (size <= 0 || (alignment & (alignment - 1)) != 0)
+	if (size <= 0 || !is_power_of_2(alignment))
 		return (unsigned long) -EINVAL;

 	/* Align to configured alignment */
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
