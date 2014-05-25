Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B2791A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 07:31:15 +1000 (EST)
Date: Sun, 25 May 2014 14:31:00 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] hfsplus: fix compiler warning on PowerPC
Message-ID: <alpine.DEB.2.19.4.1405251425270.7552@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Sergei Antonov <saproj@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Sergei suggested to send this your way, so that it can be included into 
linux-next:

Commit a99b7069aab8fc3fb4f26d15795dc280b52e38b1 ("hfsplus: Fix 
undefined __divdi3 in hfsplus_init_header_node()") introduced do_div() to 
xattr.c and the warning below too.

As Geert remarked: "tmp" is "loff_t" which is "__kernel_loff_t", which
is "long long", i.e. signed, while include/asm-generic/div64.h compares
its type with "uint64_t". As inode sizes are positive, it should be safe 
to change the type of "tmp" to "u64". 

==============================
  CC [M]  fs/hfsplus/xattr_user.o
  CC [M]  fs/hfsplus/xattr_security.o
  CC [M]  fs/hfsplus/xattr.o
  CC [M]  fs/hfsplus/xattr_trusted.o
In file included from 
arch/powerpc/include/asm/div64.h:1:0,
                 from include/linux/kernel.h:124,
                 from include/asm-generic/bug.h:13,
                 from arch/powerpc/include/asm/bug.h:127,
                 from include/linux/bug.h:4,
                 from include/linux/thread_info.h:11,
                 from include/asm-generic/preempt.h:4,
                 from arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:18,
                 from include/linux/spinlock.h:50,
                 from include/linux/wait.h:8,
                 from include/linux/fs.h:6,
                 from fs/hfsplus/hfsplus_fs.h:19,
                 from fs/hfsplus/xattr.c:9:
fs/hfsplus/xattr.c: In function 
'hfsplus_init_header_node':
include/asm-generic/div64.h:43:28: warning: 
comparison of distinct pointer types lacks a cast [enabled by default]
  (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                            ^
fs/hfsplus/xattr.c:86:2: note: in expansion of 
macro 'do_div'
  do_div(tmp, node_size);
  ^
  LD [M]  fs/hfsplus/hfsplus.o
==============================

 Signed-off-by: Christian Kujau <lists@nerdbynature.de>
      Fixed-by: Geert Uytterhoeven <geert@linux-m68k.org>
      Acked-by: Sergei Antonov <saproj@gmail.com>
---

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 4e27edc..cd9ed4c 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -66,7 +66,7 @@ static void hfsplus_init_header_node(struct inode *attr_file,
 	char *bmp;
 	u32 used_nodes;
 	u32 used_bmp_bytes;
-	loff_t tmp;
+	u64 tmp;
 
 	hfs_dbg(ATTR_MOD, "init_hdr_attr_file: clump %u, node_size %u\n",
 				clump_size, node_size);


Thanks,
Christian.
-- 
BOFH excuse #388:

Bad user karma.
