Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7H784BD4zDrC6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 02:41:23 +1100 (AEDT)
Subject: [PATCH 1/2] powerpc/oprofile/cell: Delete an error message for a
 failed memory allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net,
 Al Viro <viro@zeniv.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Robert Richter <rric@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <596db1f4-5965-d6f8-af02-38b570b10d8a@users.sourceforge.net>
Message-ID: <ce22780f-a968-e955-6a09-5ab66c68d0ac@users.sourceforge.net>
Date: Thu, 5 Oct 2017 17:41:09 +0200
MIME-Version: 1.0
In-Reply-To: <596db1f4-5965-d6f8-af02-38b570b10d8a@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Oct 2017 17:10:11 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/oprofile/cell/spu_task_sync.c | 8 --------
 arch/powerpc/oprofile/cell/vma_map.c       | 2 --
 2 files changed, 10 deletions(-)

diff --git a/arch/powerpc/oprofile/cell/spu_task_sync.c b/arch/powerpc/oprofile/cell/spu_task_sync.c
index 44d67b167e0b..f1dd732b2998 100644
--- a/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ b/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -210,9 +210,6 @@ prepare_cached_spu_info(struct spu *spu, unsigned long objectId)
 	 */
 	info = kzalloc(sizeof(struct cached_info), GFP_KERNEL);
 	if (!info) {
-		printk(KERN_ERR "SPU_PROF: "
-		       "%s, line %d: create vma_map failed\n",
-		       __func__, __LINE__);
 		retval = -ENOMEM;
 		goto err_alloc;
 	}
@@ -481,11 +478,6 @@ static int oprofile_spu_buff_create(void)
 					     GFP_KERNEL);
 
 		if (!spu_buff[spu].buff) {
-			printk(KERN_ERR "SPU_PROF: "
-			       "%s, line %d:  oprofile_spu_buff_create "
-		       "failed to allocate spu buffer %d.\n",
-			       __func__, __LINE__, spu);
-
 			/* release the spu buffers that have been allocated */
 			while (spu >= 0) {
 				kfree(spu_buff[spu].buff);
diff --git a/arch/powerpc/oprofile/cell/vma_map.c b/arch/powerpc/oprofile/cell/vma_map.c
index c579b16845da..a115d9ede053 100644
--- a/arch/powerpc/oprofile/cell/vma_map.c
+++ b/arch/powerpc/oprofile/cell/vma_map.c
@@ -72,8 +72,6 @@ vma_map_add(struct vma_to_fileoffset_map *map, unsigned int vma,
 	struct vma_to_fileoffset_map *new =
 		kzalloc(sizeof(struct vma_to_fileoffset_map), GFP_KERNEL);
 	if (!new) {
-		printk(KERN_ERR "SPU_PROF: %s, line %d: malloc failed\n",
-		       __func__, __LINE__);
 		vma_map_free(map);
 		return NULL;
 	}
-- 
2.14.2
