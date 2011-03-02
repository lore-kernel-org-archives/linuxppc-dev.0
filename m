Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9DF8B70E9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2011 04:20:55 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p22HANkJ019106
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 10:10:23 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p22HKpw9092508
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 10:20:52 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p22HKpff002577
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 10:20:51 -0700
Subject: [PATCH v4 1/2] add icswx support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 11:20:50 -0600
Message-ID: <1299086450.28840.9.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move SPRN_PID declearations in various locations into one place.

Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>

---
 arch/powerpc/include/asm/reg.h       |   10 ++++++++++
 arch/powerpc/include/asm/reg_booke.h |    3 ---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 125fc1a..bd0d36e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -170,6 +170,16 @@
 #define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode control */
 
 /* Special Purpose Registers (SPRNs)*/
+
+#ifdef CONFIG_40x
+#define SPRN_PID	0x3B1	/* Process ID */
+#else
+#define SPRN_PID	0x030	/* Process ID */
+#ifdef CONFIG_BOOKE
+#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
+#endif
+#endif
+
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
 #define SPRN_CTRLF	0x088
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index e68c69b..86ad812 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -150,8 +150,6 @@
  * or IBM 40x.
  */
 #ifdef CONFIG_BOOKE
-#define SPRN_PID	0x030	/* Process ID */
-#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
 #define SPRN_CSRR0	0x03A	/* Critical Save and Restore Register 0 */
 #define SPRN_CSRR1	0x03B	/* Critical Save and Restore Register 1 */
 #define SPRN_DEAR	0x03D	/* Data Error Address Register */
@@ -168,7 +166,6 @@
 #define SPRN_TCR	0x154	/* Timer Control Register */
 #endif /* Book E */
 #ifdef CONFIG_40x
-#define SPRN_PID	0x3B1	/* Process ID */
 #define SPRN_DBCR1	0x3BD	/* Debug Control Register 1 */		
 #define SPRN_ESR	0x3D4	/* Exception Syndrome Register */
 #define SPRN_DEAR	0x3D5	/* Data Error Address Register */
