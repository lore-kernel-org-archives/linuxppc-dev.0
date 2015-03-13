Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 300F21A2852
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:37:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:37:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D072F2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:37:50 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D8bgKa49741894
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:37:50 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D8bHAP026810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:37:17 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH slof] helpers: Fix SLOF_alloc_mem_aligned to meet callers
 expectation
Date: Fri, 13 Mar 2015 19:36:52 +1100
Message-Id: <1426235812-3749-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Every caller of SLOF_alloc_mem_aligned() assumes the size is the first
argument while it is not.

This switches align and size and fixes random memory corruptions.

This is grep for SLOF_alloc_mem_aligned with this patch applied:

include/helpers.h|27| extern void *SLOF_alloc_mem_aligned(long size, long align);
lib/libveth/veth.c|103| buffer_list = SLOF_alloc_mem_aligned(8192, 4096);
lib/libveth/veth.c|105| rx_queue = SLOF_alloc_mem_aligned(rx_queue_len, 16);
lib/libvirtio/virtio-net.c|101| vq[i].desc = SLOF_alloc_mem_aligned(virtio_vring_size(vq[i].size), 4096);
slof/helpers.c|70| void *SLOF_alloc_mem_aligned(long size, long align)

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/helpers.h | 2 +-
 slof/helpers.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/helpers.h b/include/helpers.h
index f6d4375..fb10534 100644
--- a/include/helpers.h
+++ b/include/helpers.h
@@ -24,7 +24,7 @@ extern void SLOF_usleep(uint32_t time);
 extern void *SLOF_dma_alloc(long size);
 extern void SLOF_dma_free(void *virt, long size);
 extern void *SLOF_alloc_mem(long size);
-extern void *SLOF_alloc_mem_aligned(long align, long size);
+extern void *SLOF_alloc_mem_aligned(long size, long align);
 extern void SLOF_free_mem(void *addr, long size);
 extern long SLOF_dma_map_in(void *virt, long size, int cacheable);
 extern void SLOF_dma_map_out(long phys, void *virt, long size);
diff --git a/slof/helpers.c b/slof/helpers.c
index c582996..d7c1888 100644
--- a/slof/helpers.c
+++ b/slof/helpers.c
@@ -67,7 +67,7 @@ void *SLOF_alloc_mem(long size)
 	return (void *)forth_pop();
 }
 
-void *SLOF_alloc_mem_aligned(long align, long size)
+void *SLOF_alloc_mem_aligned(long size, long align)
 {
 	unsigned long addr = (unsigned long)SLOF_alloc_mem(size + align - 1);
 	addr = addr + align - 1;
-- 
2.0.0
