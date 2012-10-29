Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/ptrace: Remove unused addr parameter in
 ppc_del_hwdebug()
Date: Mon, 29 Oct 2012 12:13:17 +1100
Message-Id: <1351473197-27426-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1351473197-27426-1-git-send-email-mikey@neuling.org>
References: <1351473197-27426-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/ptrace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7dd32d1..817b411 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1451,7 +1451,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
 }
 
-static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
+static long ppc_del_hwdebug(struct task_struct *child, long data)
 {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	int ret = 0;
@@ -1633,7 +1633,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PPC_PTRACE_DELHWDEBUG: {
-		ret = ppc_del_hwdebug(child, addr, data);
+		ret = ppc_del_hwdebug(child, data);
 		break;
 	}
 
-- 
1.7.9.5
