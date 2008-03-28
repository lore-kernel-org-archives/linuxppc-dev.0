Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2F2ADE64E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:21:59 +1100 (EST)
Message-Id: <200803282121.m2SLL8wT010667@imap1.linux-foundation.org>
Subject: [patch 03/24] drivers/block/viodasd.c: Use FIELD_SIZEOF
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 28 Mar 2008 14:21:08 -0700
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org, julia@diku.dk,
	jens.axboe@oracle.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Robert P.J. Day proposed to use the macro FIELD_SIZEOF in replace of code
that matches its definition.

The modification was made using the following semantic patch
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@haskernel@
@@

#include <linux/kernel.h>

@depends on haskernel@
type t;
identifier f;
@@

- (sizeof(((t*)0)->f))
+ FIELD_SIZEOF(t, f)

@depends on haskernel@
type t;
identifier f;
@@

- sizeof(((t*)0)->f)
+ FIELD_SIZEOF(t, f)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/viodasd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/viodasd.c~drivers-block-viodasdc-use-field_sizeof drivers/block/viodasd.c
--- a/drivers/block/viodasd.c~drivers-block-viodasdc-use-field_sizeof
+++ a/drivers/block/viodasd.c
@@ -69,7 +69,7 @@ MODULE_LICENSE("GPL");
 enum {
 	PARTITION_SHIFT = 3,
 	MAX_DISKNO = HVMAXARCHITECTEDVIRTUALDISKS,
-	MAX_DISK_NAME = sizeof(((struct gendisk *)0)->disk_name)
+	MAX_DISK_NAME = FIELD_SIZEOF(struct gendisk, disk_name)
 };
 
 static DEFINE_SPINLOCK(viodasd_spinlock);
_
