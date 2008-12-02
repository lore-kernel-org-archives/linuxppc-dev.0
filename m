Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB506DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 06:37:40 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH][for 2.6.28] powerpc: Use physical cpu id when setting the
	processor affinity
Date: Tue,  2 Dec 2008 13:37:01 -0600
Message-Id: <1228246621-25622-1-git-send-email-galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the CONFIG_SMP case the irq_choose_cpu() code was returning back
a logical cpu id not the physical id.  We were writing that directly
into the HW register.

We need to be calling get_hard_smp_processor_id() so irq_choose_cpu()
always returns a physical cpu id.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b24e1d0..1890fb0 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -600,7 +600,7 @@ static int irq_choose_cpu(unsigned int virt_irq)
 		cpuid = first_cpu(tmp);
 	}
 
-	return cpuid;
+	return get_hard_smp_processor_id(cpuid);
 }
 #else
 static int irq_choose_cpu(unsigned int virt_irq)
-- 
1.5.6.5
