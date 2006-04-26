Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C54A3679F0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 02:10:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3QGA7w3003225
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 12:10:07 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3QGA75Q230618
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 12:10:07 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3QGA7OH016777
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 12:10:07 -0400
Subject: [PATCH] nvram_print_partitions cosmetic fixup
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>, paulus@samba.org
Content-Type: text/plain
Date: Wed, 26 Apr 2006 11:09:46 -0500
Message-Id: <1146067786.27214.5.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a cosmetic fixup.   When printing the nvram partition table, the
first couple entries have a shorter 'index' value than the others, so
table is a bit askew.   This change makes the table look pretty.
Tested on pseries and g5.   Footnote: yes, this table is normally hidden
behind a DEBUG_NVRAM #define. 

Signed-off-by: Will Schmidt <willschm@us.ibm.com> 


diff --git a/arch/powerpc/kernel/nvram_64.c
b/arch/powerpc/kernel/nvram_64.c
index ada50aa..6960f09 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -204,7 +204,7 @@ static void nvram_print_partitions(char 
 	printk(KERN_WARNING "indx\t\tsig\tchks\tlen\tname\n");
 	list_for_each(p, &nvram_part->partition) {
 		tmp_part = list_entry(p, struct nvram_partition, partition);
-		printk(KERN_WARNING "%d    \t%02x\t%02x\t%d\t%s\n",
+		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%s\n",
 		       tmp_part->index, tmp_part->header.signature,
 		       tmp_part->header.checksum, tmp_part->header.length,
 		       tmp_part->header.name);
