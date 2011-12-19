Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4431EB703E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 13:06:53 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 19 Dec 2011 02:01:03 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBJ22vPI1204346
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 13:02:57 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBJ26n4n001097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 13:06:50 +1100
Message-ID: <1324260407.3006.17.camel@ThinkPad-T61>
Subject: [PATCH powerpc] fix unpaired __trace_hcall_entry and
 __trace_hcall_exit
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Mon, 19 Dec 2011 10:06:47 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unpaired calling of __trace_hcall_entry and __trace_hcall_exit could
cause incorrect preempt count. And it might happen as the global
variable hcall_tracepoint_refcount is checked separately before calling
them. 

I don't know much about the powerpc arch. But the idea here is to store
the hcall_tracepoint_refcount locally, so __trace_hcall_entry and
__trace_hcall_exit will be called or not called in pair by checking the
same value. 

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hvCall.S |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index fd05fde..1240bd2 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -14,6 +14,7 @@
 #include <asm/ptrace.h>
 	
 #define STK_PARM(i)     (48 + ((i)-3)*8)
+#define REG_SIZE        (2*8)
 
 #ifdef CONFIG_TRACEPOINTS
 
@@ -32,11 +33,12 @@ hcall_tracepoint_refcount:
  * unconditional cpu feature.
  */
 #define HCALL_INST_PRECALL(FIRST_REG)				\
+	std	r31,-8(r1);					\
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
-	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
-	cmpdi	r12,0;						\
+	ld      r31,hcall_tracepoint_refcount@toc(r2);		\
+	cmpdi	r31,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
 	std	r3,STK_PARM(r3)(r1);				\
@@ -49,9 +51,9 @@ END_FTR_SECTION(0, 1);						\
 	std	r10,STK_PARM(r10)(r1);				\
 	std	r0,16(r1);					\
 	addi	r4,r1,STK_PARM(FIRST_REG);			\
-	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
+	stdu	r1,-STACK_FRAME_OVERHEAD-REG_SIZE(r1);		\
 	bl	.__trace_hcall_entry;				\
-	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
+	addi	r1,r1,STACK_FRAME_OVERHEAD+REG_SIZE;		\
 	ld	r0,16(r1);					\
 	ld	r3,STK_PARM(r3)(r1);				\
 	ld	r4,STK_PARM(r4)(r1);				\
@@ -74,8 +76,7 @@ END_FTR_SECTION(0, 1);						\
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
-	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
-	cmpdi	r12,0;						\
+	cmpdi	r31,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
 	ld	r6,STK_PARM(r3)(r1);				\
@@ -83,13 +84,14 @@ END_FTR_SECTION(0, 1);						\
 	mr	r4,r3;						\
 	mr	r3,r6;						\
 	std	r0,16(r1);					\
-	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
+	stdu	r1,-STACK_FRAME_OVERHEAD-REG_SIZE(r1);		\
 	bl	.__trace_hcall_exit;				\
-	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
+	addi	r1,r1,STACK_FRAME_OVERHEAD+REG_SIZE;		\
 	ld	r0,16(r1);					\
 	ld	r3,STK_PARM(r3)(r1);				\
 	mtlr	r0;						\
-1:
+1:								\
+	ld	r31,-8(r1);
 
 #define HCALL_INST_POSTCALL_NORETS				\
 	li	r5,0;						\
-- 
1.7.5.4
