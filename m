Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id 1B4D867F06
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 04:03:55 +1000 (EST)
Date: Sat, 6 Aug 2005 15:03:53 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806180353.GW5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx: add cpm_get_cpmp() to make cpmp visible to modules

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6-8xx/arch/ppc/8xx_io/commproc.c
===================================================================
--- 2.6-8xx.orig/arch/ppc/8xx_io/commproc.c	2005-08-03 17:26:05.000000000 -0300
+++ 2.6-8xx/arch/ppc/8xx_io/commproc.c	2005-08-05 17:13:21.000000000 -0300
@@ -462,3 +462,10 @@
 	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
+cpm8xx_t *cpm_get_cpmp(void)
+{
+	return cpmp;
+}
+EXPORT_SYMBOL(cpm_get_cpmp);
+
Index: 2.6-8xx/include/asm/commproc.h
===================================================================
--- 2.6-8xx.orig/include/asm/commproc.h	2005-07-28 12:06:51.000000000 -0300
+++ 2.6-8xx/include/asm/commproc.h	2005-08-05 17:14:28.000000000 -0300
@@ -78,6 +78,7 @@
 extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(uint offset);
 extern void cpm_setbrg(uint brg, uint rate);
+extern cpm8xx_t *cpm_get_cpmp(void);
 
 extern uint m8xx_cpm_hostalloc(uint size);
 extern int  m8xx_cpm_hostfree(uint start);
