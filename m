Return-Path: <anton@samba.org>
Date: Fri, 2 May 2014 10:46:10 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] powerpc: Move via-cuda symbol exports next to function
 definitions
Message-ID: <20140502104610.228c9b7b@kryten>
In-Reply-To: <20140502104418.4cee8f15@kryten>
References: <20140502104418.4cee8f15@kryten>
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


Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -128,10 +128,6 @@ EXPORT_SYMBOL(smp_hw_index);
 #endif
 #endif
 
-#ifdef CONFIG_ADB_CUDA
-EXPORT_SYMBOL(cuda_request);
-EXPORT_SYMBOL(cuda_poll);
-#endif /* CONFIG_ADB_CUDA */
 EXPORT_SYMBOL(to_tm);
 
 #ifdef CONFIG_PPC32
Index: b/drivers/macintosh/via-cuda.c
===================================================================
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -379,6 +379,7 @@ cuda_request(struct adb_request *req, vo
     req->reply_expected = 1;
     return cuda_write(req);
 }
+EXPORT_SYMBOL(cuda_request);
 
 static int
 cuda_write(struct adb_request *req)
@@ -441,6 +442,7 @@ cuda_poll(void)
     if (cuda_irq)
 	enable_irq(cuda_irq);
 }
+EXPORT_SYMBOL(cuda_poll);
 
 static irqreturn_t
 cuda_interrupt(int irq, void *arg)
