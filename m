Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e74b6f429f71479547bbae5871cdc87b7c6b78b5.1239028836.git.michael@ellerman.id.au>
In-Reply-To: <db258c8de9d950c23d61abdcd121361a7bb40f75.1239028836.git.michael@ellerman.id.au>
References: <db258c8de9d950c23d61abdcd121361a7bb40f75.1239028836.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/ftrace: Fix printf format warning
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Tue,  7 Apr 2009 00:40:46 +1000 (EST)
Cc: srostedt@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

'tramp' is an unsigned long, so print it with %lx.

Fixes the following build warning:
arch/powerpc/kernel/ftrace.c:291: error: format ‘%x’ expects type ‘unsigned int’, but argument 2 has type ‘long unsigned int’

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index e9d9d38..e1edf5a 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -288,7 +288,7 @@ __ftrace_make_nop(struct module *mod,
 	if (tramp & 0x8000)
 		tramp -= 0x10000;
 
-	pr_debug(" %x ", tramp);
+	pr_debug(" %lx ", tramp);
 
 	if (tramp != addr) {
 		printk(KERN_ERR
-- 
1.6.2.1
