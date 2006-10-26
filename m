Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BAD8167BEB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 13:35:14 +1000 (EST)
Date: Thu, 26 Oct 2006 13:26:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] Constify compat_get_bitmap argument
Message-Id: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, ak@suse.de,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This means we can call it when the bitmap we want to fetch is declared
const.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compat.h |    2 +-
 kernel/compat.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

This is headed towards getting sys_migrate_pages wired up for powerpc.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f4ebf96..f155319 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -196,7 +196,7 @@ #define BITS_PER_COMPAT_LONG    (8*sizeo
 #define BITS_TO_COMPAT_LONGS(bits) \
 	(((bits)+BITS_PER_COMPAT_LONG-1)/BITS_PER_COMPAT_LONG)
 
-long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
+long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size);
 long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size);
diff --git a/kernel/compat.c b/kernel/compat.c
index 75573e5..d4898aa 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -678,7 +678,7 @@ int get_compat_sigevent(struct sigevent
 		? -EFAULT : 0;
 }
 
-long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
+long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size)
 {
 	int i, j;
-- 
1.4.3.2
