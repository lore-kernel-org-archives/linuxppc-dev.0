Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 606792C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 17:30:45 +1100 (EST)
Message-ID: <51495774.9080809@asianux.com>
Date: Wed, 20 Mar 2013 14:30:12 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 michael@ellerman.id.au, dhowells@redhat.com, geoff@infradead.org
Subject: [PATCH] PowerPC:kernel: section mismatch from smp_release_cpus to
 __initdata spinning_secondaries
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org >> \"linux-kernel@vger.kernel.org\""
 <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  the smp_release_cpus is a normal funciton and called in normal environments,
  but it calls the __initdata spinning_secondaries.
  need modify spinning_secondaries to match smp_release_cpus.

the related warning:
  (the linker report boot_paca.33377, but it should be spinning_secondaries)

-----------------------------------------------------------------------------

WARNING: arch/powerpc/kernel/built-in.o(.text+0x23176): Section mismatch in reference from the function .smp_release_cpus() to the variable .init.data:boot_paca.33377
The function .smp_release_cpus() references
the variable __initdata boot_paca.33377.
This is often because .smp_release_cpus lacks a __initdata 
annotation or the annotation of boot_paca.33377 is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x231fe): Section mismatch in reference from the function .smp_release_cpus() to the variable .init.data:boot_paca.33377
The function .smp_release_cpus() references
the variable __initdata boot_paca.33377.
This is often because .smp_release_cpus lacks a __initdata 
annotation or the annotation of boot_paca.33377 is wrong.

-----------------------------------------------------------------------------



Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/kernel/setup_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 75fbaceb..e8a2f2e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -76,7 +76,7 @@
 #endif
 
 int boot_cpuid = 0;
-int __initdata spinning_secondaries;
+int spinning_secondaries;
 u64 ppc64_pft_size;
 
 /* Pick defaults since we might want to patch instructions
-- 
1.7.7.6
