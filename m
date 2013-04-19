Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 059622C0168
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 21:48:26 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 19 Apr 2013 17:13:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C591D1258052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 17:19:51 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3JBmDqU59900092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 17:18:13 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3JBmJJU026041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 21:48:19 +1000
Subject: [PATCH RESEND] powerpc/rtas_flash: Free kmem upon module exit
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2013 17:18:09 +0530
Message-ID: <20130419114737.20439.54937.stgit@hegdevasant>
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

Memory allocated to flash_block_list in rtas_flash_write
is not freed during module exit. We hit below call trace
if we unload rtas_flash module after loading new firmware
image and before rebooting the system.

Feb  6 08:42:10 eagle3 kernel: kmem_cache_destroy rtas_flash_cache: Slab cache still has objects
Feb  6 08:42:10 eagle3 kernel: Call Trace:
Feb  6 08:42:10 eagle3 kernel: [c00000001c303b40] [c000000000014940] .show_stack+0x70/0x1c0 (unreliable)
Feb  6 08:42:10 eagle3 kernel: [c00000001c303bf0] [c000000000199bec] .kmem_cache_destroy+0x15c/0x170
Feb  6 08:42:10 eagle3 kernel: [c00000001c303c90] [d000000006fa1208] .rtas_flash_cleanup+0x3c/0x80 [rtas_flash]
Feb  6 08:42:10 eagle3 kernel: [c00000001c303e30] [c000000000009954] syscall_exit+0x0/0x94

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index c642f01..a7020d2 100644
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
 
