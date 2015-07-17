Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50D481A19AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 17:20:14 +1000 (AEST)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] powerpc/nvram: Fix function name in some errors messages.
Date: Fri, 17 Jul 2015 09:20:00 +0200
Message-Id: <1571506ab2693a3128625c94f4f89dd802bb6dd2.1437117145.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4fd8daff1bb5daad99d909aa75ff5c2702c4c490.1437117145.git.christophe.jaillet@wanadoo.fr>
References: <4fd8daff1bb5daad99d909aa75ff5c2702c4c490.1437117145.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4fd8daff1bb5daad99d909aa75ff5c2702c4c490.1437117145.git.christophe.jaillet@wanadoo.fr>
References: <4fd8daff1bb5daad99d909aa75ff5c2702c4c490.1437117145.git.christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'nvram_create_os_partition' should be 'nvram_create_partition'.
Use __func__ to have it right, as done elsewhere in this file.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/kernel/nvram_64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 574ff59..4dab163 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -1065,7 +1065,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 	/* Create our OS partition */
 	new_part = kmalloc(sizeof(*new_part), GFP_KERNEL);
 	if (!new_part) {
-		pr_err("nvram_create_os_partition: kmalloc failed\n");
+		pr_err("%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -1077,8 +1077,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 
 	rc = nvram_write_header(new_part);
 	if (rc <= 0) {
-		pr_err("nvram_create_os_partition: nvram_write_header "
-		       "failed (%d)\n", rc);
+		pr_err("%s: nvram_write_header failed (%d)\n", __func__, rc);
 		kfree(new_part);
 		return rc;
 	}
@@ -1091,8 +1090,8 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 		free_part->header.checksum = nvram_checksum(&free_part->header);
 		rc = nvram_write_header(free_part);
 		if (rc <= 0) {
-			pr_err("nvram_create_os_partition: nvram_write_header "
-			       "failed (%d)\n", rc);
+			pr_err("%s: nvram_write_header failed (%d)\n",
+			       __func__, rc);
 			return rc;
 		}
 	} else {
@@ -1106,11 +1105,12 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 	     tmp_index += NVRAM_BLOCK_LEN) {
 		rc = ppc_md.nvram_write(nv_init_vals, NVRAM_BLOCK_LEN, &tmp_index);
 		if (rc <= 0) {
-			pr_err("nvram_create_partition: nvram_write failed (%d)\n", rc);
+			pr_err("%s: nvram_write failed (%d)\n",
+			       __func__, rc);
 			return rc;
 		}
 	}
-	
+
 	return new_part->index + NVRAM_HEADER_LEN;
 }
 
-- 
2.1.4
