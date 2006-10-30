Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6A5C967CA6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 18:18:47 +1100 (EST)
Date: Mon, 30 Oct 2006 18:18:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] [POWERPC] Wire up sys_migrate_pages
Message-Id: <20061030181826.634e086d.sfr@canb.auug.org.au>
In-Reply-To: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
References: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, ak@suse.de, ppc-dev <linuxppc-dev@ozlabs.org>,
	pj@sgi.com, paulus@samba.org, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/systbl.h |    2 +-
 include/asm-powerpc/unistd.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index eac85ce..c6a0318 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -261,7 +261,7 @@ SYSX(sys_ni_syscall, ppc_fadvise64_64, p
 PPC_SYS_SPU(rtas)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
+COMPAT_SYS(migrate_pages)
 COMPAT_SYS(mbind)
 COMPAT_SYS(get_mempolicy)
 COMPAT_SYS(set_mempolicy)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 464a48c..b5fe932 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -276,7 +276,7 @@ #endif
 #define __NR_rtas		255
 #define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
-/* 258 currently unused */
+#define __NR_migrate_pages	258
 #define __NR_mbind		259
 #define __NR_get_mempolicy	260
 #define __NR_set_mempolicy	261
-- 
1.4.3.2
