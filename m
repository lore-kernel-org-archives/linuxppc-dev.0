Return-Path: <ibmirkin@gmail.com>
Received: from mail-qe0-x22c.google.com (mail-qe0-x22c.google.com
 [IPv6:2607:f8b0:400d:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 305F72C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 11:43:52 +1100 (EST)
Received: by mail-qe0-f44.google.com with SMTP id nd7so1143582qeb.31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Dec 2013 16:43:47 -0800 (PST)
Sender: Ilia Mirkin <ibmirkin@gmail.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/44x: fix ocm_block allocation
Date: Fri,  6 Dec 2013 19:43:37 -0500
Message-Id: <1386377017-909-1-git-send-email-imirkin@alum.mit.edu>
Cc: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>,
 Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allocate enough memory for the ocm_block structure, not just a pointer
to it.

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
---

I have neither the hardware to test nor the toolchain to even build-test
this. However this seems like a fairly obvious fix (and I have to wonder how
this ever worked at all). Found with spatch.

Actually further investigation makes it seem like this function is never
called, perhaps it should just be removed? If it is kept around though, would
be nice to apply this patch so that tools don't trip over this wrong code.

 arch/powerpc/sysdev/ppc4xx_ocm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/sysdev/ppc4xx_ocm.c
index b7c4345..85d9e37 100644
--- a/arch/powerpc/sysdev/ppc4xx_ocm.c
+++ b/arch/powerpc/sysdev/ppc4xx_ocm.c
@@ -339,7 +339,7 @@ void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
 		if (IS_ERR_VALUE(offset))
 			continue;
 
-		ocm_blk = kzalloc(sizeof(struct ocm_block *), GFP_KERNEL);
+		ocm_blk = kzalloc(sizeof(struct ocm_block), GFP_KERNEL);
 		if (!ocm_blk) {
 			printk(KERN_ERR "PPC4XX OCM: could not allocate ocm block");
 			rh_free(ocm_reg->rh, offset);
-- 
1.8.3.2
