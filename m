Return-Path: <anton@samba.org>
Date: Mon, 23 Jul 2012 16:42:32 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Lack of firmware flash support is not an error
Message-ID: <20120723164232.1988f3ca@kryten>
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


Reduce the severity of the warning given when firmware flash is
not supported. Not all platforms have it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/rtas_flash.c
===================================================================
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -709,7 +709,7 @@ static int __init rtas_flash_init(void)
 
 	if (rtas_token("ibm,update-flash-64-and-reboot") ==
 		       RTAS_UNKNOWN_SERVICE) {
-		printk(KERN_ERR "rtas_flash: no firmware flash support\n");
+		pr_info("rtas_flash: no firmware flash support\n");
 		return 1;
 	}
 
