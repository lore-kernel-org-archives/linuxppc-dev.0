Return-Path: <apw@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5098367B24
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 13:45:06 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5D3j3E4013700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jun 2006 23:45:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5D3iqjb287428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jun 2006 21:44:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5D3j36D022039
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jun 2006 21:45:03 -0600
Date: Mon, 12 Jun 2006 23:45:02 -0400
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix builtin command line interaction with firmware
Message-ID: <20060613034502.GA15130@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Amos Waterland <apw@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems that prom_init's early_cmdline_parse is broken on at least
Apple 970 xserves and IBM JS20 blades with SLOF.  The firmware of these
machines returns -1 and 1 respectively when getprop is called for the
bootargs property of /chosen, causing Linux to ignore its builtin
command line in favor of a null string.  This patch makes Linux use its
builtin command line if getprop returns an error or a null string.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0f0caf0342f39b4437dcb3e9f2f1d62bfb4e3e7d
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f70bd09..2e63a90 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -574,7 +574,7 @@ static void __init early_cmdline_parse(v
 	if ((long)_prom->chosen > 0)
 		l = prom_getprop(_prom->chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
 #ifdef CONFIG_CMDLINE
-	if (l == 0) /* dbl check */
+	if (l <= 0 || p[0] == '\0') /* dbl check */
 		strlcpy(RELOC(prom_cmd_line),
 			RELOC(CONFIG_CMDLINE), sizeof(prom_cmd_line));
 #endif /* CONFIG_CMDLINE */
-- 
1.0.4
