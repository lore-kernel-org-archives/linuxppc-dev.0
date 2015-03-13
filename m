Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DF9A1A074A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 20:43:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 19:43:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6BDF12BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 20:43:02 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D9grUL48038036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 20:43:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D9gRK0018732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 20:42:28 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH slof v2] virtio: Fix vring allocation
Date: Fri, 13 Mar 2015 20:42:03 +1100
Message-Id: <1426239723-25789-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <878uf1p84j.fsf@abhimanyu.in.ibm.com>
References: <878uf1p84j.fsf@abhimanyu.in.ibm.com>
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
Changes:
v2:
* remove magic numbers
---
 lib/libvirtio/virtio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/libvirtio/virtio.c b/lib/libvirtio/virtio.c
index b010796..f9c00a6 100644
--- a/lib/libvirtio/virtio.c
+++ b/lib/libvirtio/virtio.c
@@ -32,8 +32,10 @@
  */
 unsigned long virtio_vring_size(unsigned int qsize)
 {
-	return VQ_ALIGN(sizeof(struct vring_desc) * qsize + 2 * (2 + qsize))
-		+ VQ_ALIGN(sizeof(struct vring_used_elem) * qsize);
+	return VQ_ALIGN(sizeof(struct vring_desc) * qsize +
+                        sizeof(struct vring_avail) + sizeof(uint16_t) * qsize) +
+               VQ_ALIGN(sizeof(struct vring_used) +
+                        sizeof(struct vring_used_elem) * qsize);
 }
 
 
-- 
2.0.0
