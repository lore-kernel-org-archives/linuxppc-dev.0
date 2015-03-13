Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37D781A2AEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:41:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:41:21 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 154422CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:41:19 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D8fATK45547522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:41:18 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D8ejcE005386
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:40:45 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH slof] virtio: Fix vring allocation
Date: Fri, 13 Mar 2015 19:40:20 +1100
Message-Id: <1426236020-10278-1-git-send-email-aik@ozlabs.ru>
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

The value returned by virtio_vring_size() is used to allocate memory
for vring. The used descriptor list (array of vring_used_elem) is
counted by the header - vring_used struct - is not.

This fixes virtio_vring_size() to return the correct size.
At the moment rings are quite small (256) and allocated with
4096 alignment, this is why we have not been having issues with
this so far.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 lib/libvirtio/virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/libvirtio/virtio.c b/lib/libvirtio/virtio.c
index b010796..22615c4 100644
--- a/lib/libvirtio/virtio.c
+++ b/lib/libvirtio/virtio.c
@@ -33,7 +33,8 @@
 unsigned long virtio_vring_size(unsigned int qsize)
 {
 	return VQ_ALIGN(sizeof(struct vring_desc) * qsize + 2 * (2 + qsize))
-		+ VQ_ALIGN(sizeof(struct vring_used_elem) * qsize);
+               + VQ_ALIGN(sizeof(struct vring_used) +
+                          sizeof(struct vring_used_elem) * qsize);
 }
 
 
-- 
2.0.0
