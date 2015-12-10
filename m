Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 395141A1044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:32:17 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 17:32:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AF74C2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:31:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBA7UknA27000834
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:30:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBA7Ud7q008549
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:30:40 +1100
Message-ID: <566929FA.2050409@linux.vnet.ibm.com>
Date: Thu, 10 Dec 2015 15:30:02 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, tglx@linutronix.de
Subject: [PATCH] powerpc/nvram: Fix an incorrect partition merge
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

When we merge two contiguous partitions whose signatures are marked
NVRAM_SIG_FREE, We need update prev's length and checksum, then write it
to nvram, not cur's. So lets fix this mistake now.

Also use memset instead of strncpy to set the partition's name. It's
more readable if we want to fill up with duplicate chars .

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/nvram_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 21a278b7..40e80ca 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -969,7 +969,7 @@ int __init nvram_remove_partition(const char *name, int sig,
 
 		/* Make partition a free partition */
 		part->header.signature = NVRAM_SIG_FREE;
-		strncpy(part->header.name, "wwwwwwwwwwww", 12);
+		memset(part->header.name, 'w', 12);
 		part->header.checksum = nvram_checksum(&part->header);
 		rc = nvram_write_header(part);
 		if (rc <= 0) {
@@ -987,8 +987,8 @@ int __init nvram_remove_partition(const char *name, int sig,
 		}
 		if (prev) {
 			prev->header.length += part->header.length;
-			prev->header.checksum = nvram_checksum(&part->header);
-			rc = nvram_write_header(part);
+			prev->header.checksum = nvram_checksum(&prev->header);
+			rc = nvram_write_header(prev);
 			if (rc <= 0) {
 				printk(KERN_ERR "nvram_remove_partition: nvram_write failed (%d)\n", rc);
 				return rc;
-- 
2.5.0
