Return-Path: <anton@samba.org>
Date: Thu, 1 May 2014 08:07:20 +1000
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/powernv: Reduce panic timeout from 180s to 10s
Message-ID: <20140501080720.40566339@kryten>
In-Reply-To: <20140430212942.GC9671@iris.ozlabs.ibm.com>
References: <20140501072004.5b694f54@kryten>
 <20140430212942.GC9671@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've already dropped the default pseries timeout to 10s, do
the same for powernv.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/setup.c | 2 ++
 1 file changed, 2 insertions(+)

v2: fix the commit message as Paul pointed out

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 23aab41..a789307 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -39,6 +39,8 @@
 
 static void __init pnv_setup_arch(void)
 {
+	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
+
 	/* Initialize SMP */
 	pnv_smp_init();
 
-- 
1.9.1
