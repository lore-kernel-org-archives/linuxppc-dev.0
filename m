Return-Path: <groeck7@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgL7X4rCRzDqbZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:34:13 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g2so8467993pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:34:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
Date: Mon, 12 Feb 2018 14:34:07 -0800
Message-Id: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If KEXEC_CORE is not enabled, PowerNV builds fail as follows.

arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
arch/powerpc/platforms/powernv/smp.c:236:4: error:
	implicit declaration of function 'crash_ipi_callback'

Add dummy function calls, similar to kdump_in_progress(), to solve the
problem.

Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/include/asm/kexec.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 9dcbfa6bbb91..d8b1e8e7e035 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -140,6 +140,12 @@ static inline bool kdump_in_progress(void)
 	return false;
 }
 
+static inline void crash_ipi_callback(struct pt_regs *regs) { }
+
+static inline void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
+{
+}
+
 #endif /* CONFIG_KEXEC_CORE */
 #endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
2.7.4
