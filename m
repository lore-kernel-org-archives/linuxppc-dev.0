Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8ADFF2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 15:43:41 +1100 (EST)
Message-ID: <5100B53C.3030109@asianux.com>
Date: Thu, 24 Jan 2013 12:14:52 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] arch/powerpc/kernel: using %12.12s instead of %12s for
 avoiding memory overflow.
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  for tmp_part->header.name:
    it is "Terminating null required only for names < 12 chars".
    so need to limit the %.12s for it in printk

  additional info:

    %12s  limit the width, not for the original string output length
          if name length is more than 12, it still can be fully displayed.
          if name length is less than 12, the ' ' will be filled before name.

    %.12s truly limit the original string output length (precision)


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/kernel/nvram_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index bec1e93..57bf6d2 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -202,7 +202,7 @@ static void __init nvram_print_partitions(char * label)
 	printk(KERN_WARNING "--------%s---------\n", label);
 	printk(KERN_WARNING "indx\t\tsig\tchks\tlen\tname\n");
 	list_for_each_entry(tmp_part, &nvram_partitions, partition) {
-		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12s\n",
+		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12.12s\n",
 		       tmp_part->index, tmp_part->header.signature,
 		       tmp_part->header.checksum, tmp_part->header.length,
 		       tmp_part->header.name);
-- 
1.7.10.4
