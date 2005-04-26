Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0FB7267A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 04:48:34 +1000 (EST)
Date: Tue, 26 Apr 2005 11:48:28 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050426184828.GA22714@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: backport Book-E decrementer handling fix from 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo,

this is backport of Matt Porter's patch for Book-E decrementer 
handling in timer_interrupt. 

The fix has been in 2.6 from August but never made it to 2.4, and I 
re-discovered this fix last week :)

Original Matt's post to linuxppc-dev with explanation can be found at:
http://ozlabs.org/pipermail/linuxppc-dev/2004-August/017458.html

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

===== arch/ppc/kernel/time.c 1.16 vs edited =====
--- 1.16/arch/ppc/kernel/time.c	2003-07-03 09:56:34 -07:00
+++ edited/arch/ppc/kernel/time.c	2005-04-26 11:37:58 -07:00
@@ -150,7 +150,7 @@
 
 	hardirq_enter(cpu);
 
-	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
+	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
 		if (!user_mode(regs))
 			ppc_do_profile(instruction_pointer(regs));
