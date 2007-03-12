Return-Path: <will_schmidt@vnet.ibm.com>
Received: from news.rchland.ibm.com (rchp4.rochester.ibm.com [129.42.161.36])
	by ozlabs.org (Postfix) with ESMTP id EB788DDD0E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 06:41:00 +1100 (EST)
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH 2/2] [powerpc] replace if-then-else with a switch statement
Date: Mon, 12 Mar 2007 13:21:16 -0600
To: linuxppc-dev@ozlabs.org
Message-Id: <20070312192116.16630.92222.stgit@joxer.rchland.ibm.com>
In-Reply-To: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
References: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: sfr@canb.auug.org.au, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


convert a compound if-else blob to a switch statement.
This better fits the kernel coding style.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/kernel/lparcfg.c |   43 +++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 89486b6..0a4f9f5 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -130,30 +130,31 @@ #ifdef CONFIG_PPC_PSERIES
 /*
  * Methods used to fetch LPAR data when running on a pSeries platform.
  */
-/* find a better place for this function... */
 static void log_plpar_hcall_return(unsigned long rc, char *tag)
 {
-	if (rc == 0)		/* success, return */
+	switch(rc) {
+	case 0:
 		return;
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
+	case H_HARDWARE:
+		printk(KERN_INFO "plpar-hcall (%s) "
+				"Hardware fault\n", tag);
+		return;
+	case H_FUNCTION:
+		printk(KERN_INFO "plpar-hcall (%s) "
+				"Function not allowed\n", tag);
+		return;
+	case H_AUTHORITY:
+		printk(KERN_INFO "plpar-hcall (%s) "
+				"Not authorized to this function\n", tag);
+		return;
+	case H_PARAMETER:
+		printk(KERN_INFO "plpar-hcall (%s) "
+				"Bad parameter(s)\n",tag);
+		return;
+	default:
+		printk(KERN_INFO "plpar-hcall (%s) "
+				"Unexpected rc(0x%lx)\n", tag, rc);
+	}
 }
 
 /*
