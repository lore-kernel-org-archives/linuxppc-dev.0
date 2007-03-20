Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 14:29:54 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] bypass hcall stats until cpu features have run
Message-ID: <20070320192954.GE11953@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I noticed that we execute hcalls before cpu feature code has run (eg for
setting up the bolted kernel region). Create an unconditional branch
that we nop out all the time to fix this.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hvCall.S	2007-03-08 09:08:11.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/hvCall.S	2007-03-08 09:15:12.000000000 -0600
@@ -30,9 +30,14 @@
 	
 /*
  * postcall is performed immediately before function return which
- * allows liberal use of volatile registers.
+ * allows liberal use of volatile registers. We branch around this
+ * in early init (eg when populating the MMU hashtable) by using an
+ * unconditional cpu feature.
  */
 #define HCALL_INST_POSTCALL					\
+BEGIN_FTR_SECTION;						\
+	b	1f;						\
+END_FTR_SECTION(0, 1);						\
 	ld	r4,STK_PARM(r3)(r1);	/* validate opcode */	\
 	cmpldi	cr7,r4,MAX_HCALL_OPCODE;			\
 	bgt-	cr7,1f;						\
