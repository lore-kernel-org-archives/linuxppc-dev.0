Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4F61A19AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 17:20:12 +1000 (AEST)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] powerpc/nvram: Add missing kfree in error path
Date: Fri, 17 Jul 2015 09:19:59 +0200
Message-Id: <4fd8daff1bb5daad99d909aa75ff5c2702c4c490.1437117145.git.christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If 'nvram_write_header' fails, then 'new_part' should be freed, otherwise,
there is a memory leak.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is *untested* because I have no way to trigger the error.
---
 arch/powerpc/kernel/nvram_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 1e703f8..574ff59 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -1079,6 +1079,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 	if (rc <= 0) {
 		pr_err("nvram_create_os_partition: nvram_write_header "
 		       "failed (%d)\n", rc);
+		kfree(new_part);
 		return rc;
 	}
 	list_add_tail(&new_part->partition, &free_part->partition);
-- 
2.1.4
