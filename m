Return-Path: <monamagarwal123@gmail.com>
From: Monam Agarwal <monamagarwal123@gmail.com>
To: arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.or,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] arch/powerpc: Use RCU_INIT_POINTER(x,
 NULL) in platforms/cell/spu_syscalls.c
Date: Sat, 22 Mar 2014 12:20:56 +0530
Message-Id: <1395471056-2951-1-git-send-email-monamagarwal123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here rcu_assign_pointer() is ensuring that the
initialization of a structure is carried out before storing a pointer
to that structure.
So, rcu_assign_pointer(p, NULL) can always safely be converted to
RCU_INIT_POINTER(p, NULL).

Signed-off-by: Monam Agarwal <monamagarwal123@gmail.com>
---
 arch/powerpc/platforms/cell/spu_syscalls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 3844f13..38e0a1a 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -170,7 +170,7 @@ EXPORT_SYMBOL_GPL(register_spu_syscalls);
 void unregister_spu_syscalls(struct spufs_calls *calls)
 {
 	BUG_ON(spufs_calls->owner != calls->owner);
-	rcu_assign_pointer(spufs_calls, NULL);
+	RCU_INIT_POINTER(spufs_calls, NULL);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(unregister_spu_syscalls);
-- 
1.7.9.5
