Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts10-srv.bellnexxia.net (tomts10.bellnexxia.net
	[209.226.175.54]) by ozlabs.org (Postfix) with ESMTP id 9F912DDF0B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 09:37:08 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts10-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070207223706.EZKM1723.tomts10-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Feb 2007 17:37:06 -0500
Date: Wed, 7 Feb 2007 17:37:05 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] symbol irq_desc exported twice in arch/ppc
Message-ID: <20070207223705.GB22740@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

symbol irq_desc exported twice in arch/ppc

arch/ppc/kernel/ppc_ksyms.c should not export irq_desc since it is
exported in irq/handle.c.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -223,7 +223,6 @@ EXPORT_SYMBOL(screen_info);
=20
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(timer_interrupt);
-EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(console_drivers);
 #ifdef CONFIG_XMON
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
