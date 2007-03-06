Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0952FDDEE5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 10:11:49 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l26NBhEg024953
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 18:11:43 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l26NBhNi279156
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 18:11:43 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l26NBhpw006386
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 18:11:43 -0500
Subject: [PATCH] [POWERPC] fix up log_plpar_hcall_return
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 06 Mar 2007 17:11:41 -0600
Message-Id: <1173222701.13165.9.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is mostly cosmetic.  This updates log_plpar_hcall_return() to use a
case statement rather than an if-then-else jumble, and moves it to
rtas.c where it can be near the other rtas related functions. 

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
---
 arch/powerpc/kernel/lparcfg.c |   25 -------------------------
 arch/powerpc/kernel/rtas.c    |   29 +++++++++++++++++++++++++++++
 include/asm-powerpc/rtas.h    |    1 +
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 89486b6..e89471f 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -130,31 +130,6 @@ #ifdef CONFIG_PPC_PSERIES
 /*
  * Methods used to fetch LPAR data when running on a pSeries platform.
  */
-/* find a better place for this function... */
-static void log_plpar_hcall_return(unsigned long rc, char *tag)
-{
-	if (rc == 0)		/* success, return */
-		return;
-/* check for null tag ? */
-	if (rc == H_HARDWARE)
-		printk(KERN_INFO
-		       "plpar-hcall (%s) failed with hardware fault\n", tag);
-	else if (rc == H_FUNCTION)
-		printk(KERN_INFO
-		       "plpar-hcall (%s) failed; function not allowed\n", tag);
-	else if (rc == H_AUTHORITY)
-		printk(KERN_INFO
-		       "plpar-hcall (%s) failed; not authorized to this"
-		       " function\n", tag);
-	else if (rc == H_PARAMETER)
-		printk(KERN_INFO "plpar-hcall (%s) failed; Bad parameter(s)\n",
-		       tag);
-	else
-		printk(KERN_INFO
-		       "plpar-hcall (%s) failed with unexpected rc(0x%lx)\n",
-		       tag, rc);
-
-}
 
 /*
  * H_GET_PPP hcall returns info in 4 parms.
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 9d0735a..b215b6b 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -506,6 +506,35 @@ int rtas_error_rc(int rtas_rc)
 	return rc;
 }
 
+/* provide a human-readible description of some hcall return codes. */
+void log_plpar_hcall_return(unsigned long rc, char *tag)
+{
+	switch(rc) {
+	case 0:
+		return;
+	case H_HARDWARE:
+		printk(KERN_INFO "plpar-hcall (%s) "
+					"Hardware fault\n", tag);
+		return;
+	case H_FUNCTION:
+		printk(KERN_INFO "plpar-hcall (%s) "
+					"Function not allowed\n", tag);
+		return;
+	case H_AUTHORITY:
+		printk(KERN_INFO "plpar-hcall (%s) "
+				"Not authorized to this function\n", tag);
+		return;
+	case H_PARAMETER:
+		printk(KERN_INFO "plpar-hcall (%s) "
+					"Bad parameter(s)\n",tag);
+		return;
+	default:
+		printk(KERN_INFO "plpar-hcall (%s) "
+					"Unexpected rc(0x%lx)\n", tag, rc);
+	}
+}
+EXPORT_SYMBOL(log_plpar_hcall_return);
+
 int rtas_get_power_level(int powerdomain, int *level)
 {
 	int token = rtas_token("get-power-level");
diff --git a/include/asm-powerpc/rtas.h b/include/asm-powerpc/rtas.h
index 8eaa7b2..f36aaba 100644
--- a/include/asm-powerpc/rtas.h
+++ b/include/asm-powerpc/rtas.h
@@ -185,6 +185,7 @@ extern int early_init_dt_scan_rtas(unsig
 		const char *uname, int depth, void *data);
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
+extern void log_plpar_hcall_return(unsigned long rc, char *tag);
 
 /* Error types logged.  */
 #define ERR_FLAG_ALREADY_LOGGED	0x0
