Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 741371A1047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 21:01:40 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 9 Dec 2015 15:31:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 01086125805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 15:31:56 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB9A1Vr01180124
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 15:31:31 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB9A0wbD018477
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 15:30:59 +0530
Message-ID: <5667FBD5.2050206@linux.vnet.ibm.com>
Date: Wed, 09 Dec 2015 18:00:53 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] powerpc/nvram: Fix a memory leak in err path
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


If kmemdup fails, We need kfree *buff* first then return -ENOMEM.
Otherwise there is a memory leak.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/nvram_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 32e2652..21a278b7 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -542,9 +542,9 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 			time->tv_nsec = 0;
 		}
 		*buf = kmemdup(buff + hdr_size, length, GFP_KERNEL);
+		kfree(buff);
 		if (*buf == NULL)
 			return -ENOMEM;
-		kfree(buff);
 
 		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
 			*compressed = true;
-- 
2.5.0
