Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 521DB67BBC
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 02:06:52 +1100 (EST)
Subject: [PATCH] smp-tbsync on 32-bit
From: Adrian Cox <adrian@humboldt.co.uk>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 14:35:48 +0000
Message-Id: <1163774148.9390.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch below fixes an arithmetic wrap-around issue on 32bit machines
using smp-tbsync. Without this patch a timebase value over
0x000000007fffffff will hang the boot process while bringing up
secondary CPUs.

Signed-off-by: Adrian Cox <adrian@humboldt.co.uk>

--- a/arch/powerpc/kernel/smp-tbsync.c
+++ b/arch/powerpc/kernel/smp-tbsync.c
@@ -78,7 +78,7 @@ static int __devinit start_contest(int c
 {
 	int i, score=0;
 	u64 tb;
-	long mark;
+	u64 mark;
 
 	tbsync->cmd = cmd;
 


-- 
Adrian Cox <adrian@humboldt.co.uk>
