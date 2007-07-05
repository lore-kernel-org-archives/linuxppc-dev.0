Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A8ED8DDF33
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:51 +1000 (EST)
Message-Id: <20070705170242.720725000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:07 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 34/35] Work around errata 4505
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Workaround for Errata 4504: PMC0 doesn't seem to set SIARLOG when
an exception occurs. Instead, log the PC for when we took the actual
exception.



Index: 2.6.21/arch/powerpc/oprofile/op_model_pa6t.c
===================================================================
--- 2.6.21.orig/arch/powerpc/oprofile/op_model_pa6t.c
+++ 2.6.21/arch/powerpc/oprofile/op_model_pa6t.c
@@ -215,6 +215,9 @@ static void pa6t_handle_interrupt(struct
 			if (oprofile_running && ctr[i].enabled) {
 				if (mmcr0 & PA6T_MMCR0_SIARLOG)
 					oprofile_add_ext_sample(pc, regs, i, is_kernel);
+				else if (i < 2)
+					/* PMC0/1 might not set SIARLOG, just log PC at time of fault */
+					oprofile_add_ext_sample(regs->nip, regs, i, is_kernel);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0UL);

--
