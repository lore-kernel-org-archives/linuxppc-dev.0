Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 816E9DDF4D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 07:27:20 +1100 (EST)
Date: Wed, 30 Jan 2008 22:03:17 +0200
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [2.6 patch] hvc_rtas_init() must be __init
Message-ID: <20080130200317.GH29368@does.not.exist>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following section mismatch:

<--  snip  -->

...
WARNING: vmlinux.o(.text+0x2fbca8): Section mismatch in reference from the function .hvc_rtas_init() to the function .devinit.text:.hvc_alloc()
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
1cc00c4ad5c881db2fc256ced43f3b5ce5c76e1c 
diff --git a/drivers/char/hvc_rtas.c b/drivers/char/hvc_rtas.c
index bb09413..88590d0 100644
--- a/drivers/char/hvc_rtas.c
+++ b/drivers/char/hvc_rtas.c
@@ -76,7 +76,7 @@ static struct hv_ops hvc_rtas_get_put_ops = {
 	.put_chars = hvc_rtas_write_console,
 };
 
-static int hvc_rtas_init(void)
+static int __init hvc_rtas_init(void)
 {
 	struct hvc_struct *hp;
 
