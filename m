Return-Path: <mjw@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D10D67C9E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 07:42:00 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kALKfvPd029063
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 15:41:57 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kALKfv4A485162
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 13:41:57 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kALKfvvV003360
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 13:41:57 -0700
Received: from wecm-9-67-41-233.wecm.ibm.com (wecm-9-67-41-233.wecm.ibm.com
	[9.67.41.233])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kALKfuba003288
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 13:41:57 -0700
Subject: [PATCH] powerpc: Make 970MP detectable by oprofile
From: Mike Wolf <mjw@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 21 Nov 2006 14:41:54 -0600
Message-Id: <1164141715.9752.5.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the oprofile_cpu_type in cputables.c to be ppc64/970MP.  Oprofile
needs to distinquish the MP from other 970 processors so it can add some
new counters specific to the 970MP

Signed-off-by: Mike Wolf <mjw@us.ibm.com>

---diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 911ac44..0b01faa 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -225,7 +225,7 @@ #ifdef CONFIG_PPC64
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970MP,
 		.cpu_restore		= __restore_cpu_ppc970,
-		.oprofile_cpu_type	= "ppc64/970",
+		.oprofile_cpu_type	= "ppc64/970MP",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
 	},
