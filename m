Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 074101A0015
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 13:26:38 +1000 (AEST)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14A86140216
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 13:26:35 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so56648736pac.2
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2015 20:26:32 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH] powerpc: Set the correct kernel taint on machine check errors.
Date: Mon, 15 Jun 2015 13:25:19 +1000
Message-Id: <1434338719-8416-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This means the 'M' flag will work properly when the kernel prints a backtrace.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6530f1b..37de90f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -297,6 +297,8 @@ long machine_check_early(struct pt_regs *regs)
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
 	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
 		handled = cur_cpu_spec->machine_check_early(regs);
 	return handled;
-- 
2.1.4
