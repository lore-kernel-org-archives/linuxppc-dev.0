Return-Path: <anton@samba.org>
Date: Wed, 5 Jun 2013 13:02:26 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Align thread->fpr to 16 bytes
Message-ID: <20130605130226.59f29836@kryten>
Mime-Version: 1.0
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


On newer CPUs we use VSX loads and stores to the thread->fpr array.
For best performance we need to ensure 16 byte alignment.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/processor.h
===================================================================
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -200,7 +200,7 @@ struct thread_struct {
 #endif
 #endif
 	/* FP and VSX 0-31 register set */
-	double		fpr[32][TS_FPRWIDTH];
+	double		fpr[32][TS_FPRWIDTH] __attribute__((aligned(16)));
 	struct {
 
 		unsigned int pad;
