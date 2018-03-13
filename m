Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4019fN6qsLzF1Bx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 10:14:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: sukadev@linux.vnet.ibm.com,
	npiggin@gmail.com
Subject: [PATCH] powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT CPU
 features
Date: Wed, 14 Mar 2018 10:14:11 +1100
Message-Id: <20180313231411.9537-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running virtualised the powerpc kernel is able to run the system
in "compat mode" - which means the kernel and hardware are pretending
to userspace that the CPU is an older version than it actually is.

AT_BASE_PLATFORM is an AUXV entry that we export to userspace for use
when we're running in that mode, which tells userspace the "platform"
string for the real CPU version, as opposed to the faked version.

Although we don't support compat mode when using DT CPU features, and
arguably don't need to set AT_BASE_PLATFORM, the existing cputable
based code always sets it even when we're running bare metal. That
means the lack of AT_BASE_PLATFORM is a user-visible artifact of the
fact that the kernel is using DT CPU features, which we don't want.

So set it in the DT CPU features code also.

This results in eg:
  $ LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
  AT_PLATFORM:     power9
  AT_BASE_PLATFORM:power9

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 945e2c29ad2d..0bcfb0f256e1 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -720,6 +720,9 @@ static void __init cpufeatures_setup_finished(void)
 		cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
 	}
 
+	/* Make sure powerpc_base_platform is non-NULL */
+	powerpc_base_platform = cur_cpu_spec->platform;
+
 	system_registers.lpcr = mfspr(SPRN_LPCR);
 	system_registers.hfscr = mfspr(SPRN_HFSCR);
 	system_registers.fscr = mfspr(SPRN_FSCR);
-- 
2.14.1
