Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F9762C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 22:18:31 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 16:46:23 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 50C53394004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 16:48:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r18BIKE432440368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 16:48:20 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r18BIKCx032762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 22:18:20 +1100
Received: from hegdevasant.in.ibm.com (hegdevasant.in.ibm.com [9.124.35.78])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r18BIKR5032747
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 22:18:20 +1100
Subject: [PATCH] powerpc/rtas_flash: Free kmem upon module exit
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Fri, 08 Feb 2013 16:48:36 +0530
Message-ID: <20130208111742.31083.67858.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory allocated to rtas_firmware_flash_list in rtas_flash_write
is not freed during module exit. We hit below call trace if we
unload rtas_flash module after loading new firmware image and
before rebooting the system.

Call trace:
----------
Feb  6 08:42:10 eagle3 kernel: kmem_cache_destroy rtas_flash_cache: Slab cache still has objects
Feb  6 08:42:10 eagle3 kernel: Call Trace:
Feb  6 08:42:10 eagle3 kernel: [c00000001c303b40] [c000000000014940] .show_stack+0x70/0x1c0 (unreliable)
Feb  6 08:42:10 eagle3 kernel: [c00000001c303bf0] [c000000000199bec] .kmem_cache_destroy+0x15c/0x170
Feb  6 08:42:10 eagle3 kernel: [c00000001c303c90] [d000000006fa1208] .rtas_flash_cleanup+0x3c/0x80 [rtas_flash]
Feb  6 08:42:10 eagle3 kernel: [c00000001c303d20] [c0000000000f8970] .SyS_delete_module+0x1d0/0x2e0
Feb  6 08:42:10 eagle3 kernel: [c00000001c303e30] [c000000000009954] syscall_exit+0x0/0x94

This patch frees rtas_firmware_flash_list during module exit.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 8329190..e22ef34 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -790,6 +790,11 @@ static void __exit rtas_flash_cleanup(void)
 {
 	rtas_flash_term_hook = NULL;
 
+	if (rtas_firmware_flash_list) {
+		free_flash_list(rtas_firmware_flash_list);
+		rtas_firmware_flash_list = NULL;
+	}
+
 	if (flash_block_cache)
 		kmem_cache_destroy(flash_block_cache);
 
