Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 72B83DE053
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:49 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:48 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/10] powepc: Remove unnecessary of_get_flat_dt_prop casts
Message-ID: <20071122154647.GA26556@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

of_get_flat_dt_prop returns a void*.  There is no need to cast its
value when assigning to a pointer variable.  This also avoids warnings
on ppc32 where unsigned long is 32 bits.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/kernel/prom.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index acc0d24..e2e7d9c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -790,11 +790,11 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 #endif
 
 #ifdef CONFIG_KEXEC
-	lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
+	lprop = of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
 	if (lprop)
 		crashk_res.start = *lprop;
 
-	lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-size", NULL);
+	lprop = of_get_flat_dt_prop(node, "linux,crashkernel-size", NULL);
 	if (lprop)
 		crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
-- 
1.5.3.4
