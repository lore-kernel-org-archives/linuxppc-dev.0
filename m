Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2550F67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 02:42:21 +1000 (EST)
Date: Tue, 19 Apr 2005 08:52:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050419115253.GA2780@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: update DataTLBMiss exception comment
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

Since v2.6 DataTLBMiss doesnt jump to the page fault handler, it instead
loads invalid TLB which in turn causes a DataTLBError exception.

The comment on top of it haven't been update since the change. 

What about this?

--- head_8xx.S.orig	2005-04-19 13:29:14.000000000 -0300
+++ head_8xx.S	2005-04-19 13:34:44.000000000 -0300
@@ -289,13 +289,11 @@
  * For the MPC8xx, this is a software tablewalk to load the instruction
  * TLB.  It is modelled after the example in the Motorola manual.  The task
  * switch loads the M_TWB register with the pointer to the first level table.
- * If we discover there is no second level table (the value is zero), the
- * plan was to load that into the TLB, which causes another fault into the
- * TLB Error interrupt where we can handle such problems.  However, that did
- * not work, so if we discover there is no second level table, we restore
- * registers and branch to the error exception.  We have to use the MD_xxx
- * registers for the tablewalk because the equivalent MI_xxx registers
- * only perform the attribute functions.
+ * If we discover there is no second level table (value is zero) or if there 
+ * is an invalid pte, we load that into the TLB, which causes another fault 
+ * into the TLB Error interrupt where we can handle such problems.  
+ * We have to use the MD_xxx registers for the tablewalk because the 
+ * equivalent MI_xxx registers only perform the attribute functions.
  */
 InstructionTLBMiss:
 #ifdef CONFIG_8xx_CPU6
