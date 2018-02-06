Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zb5rQ4xyYzF0sh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 12:06:30 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id 13so195323plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Feb 2018 17:06:30 -0800 (PST)
Date: Tue, 6 Feb 2018 11:06:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, Florian Weimer
 <fweimer@redhat.com>, Jiri Slaby <jslaby@suse.cz>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Kernel 4.15 lost set_robust_list support on POWER 9
Message-ID: <20180206110616.5d1d5881@roar.ozlabs.ibm.com>
In-Reply-To: <1517867731.2312.146.camel@au1.ibm.com>
References: <3ef0c599-0285-e77a-c002-e21152823fb8@redhat.com>
 <d5f533cf-bd97-794a-38e8-6b6d8c005023@linux.vnet.ibm.com>
 <1517867731.2312.146.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 06 Feb 2018 08:55:31 +1100
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Mon, 2018-02-05 at 19:14 -0200, Mauricio Faria de Oliveira wrote:
> > Nick, Michael,  
> 
> +Aneesh.
> 
> > On 02/05/2018 10:48 AM, Florian Weimer wrote:  
> > > 7041  set_robust_list(0x7fff93dc3980, 24) = -1 ENOSYS (Function not 
> > > implemented)  
> > 
> > The regression was introduced by commit 371b8044 ("powerpc/64s: 
> > Initialize ISAv3 MMU registers before setting partition table").
> > 
> > The problem is Radix MMU specific (does not occur with 'disable_radix'),
> > and does not occur with that code reverted (ie do not set PIDR to zero).
> > 
> > Do you see any reasons why?
> > (wondering if at all related to access_ok() in include/asm/uaccess.h)

Does this help?

powerpc/64s/radix: allocate guard-PID for kernel contexts at boot

64s/radix uses PID 0 for its kernel mapping at the 0xCxxx (quadrant 3)
address. This mapping is also accessible at 0x0xxx when PIDR=0 -- the
top 2 bits just selects the addressing mode, which is effectively the
same when PIDR=0 -- so address 0 translates to physical address 0 by
the kernel's linear map.

Commit 371b8044 ("powerpc/64s: Initialize ISAv3 MMU registers before
setting partition table"), which zeroes PIDR at boot, caused this
situation, and that stops kernel access to NULL from faulting in boot.
Before this, we inherited what firmware or kexec gave, which is almost
always non-zero.

futex_atomic_cmpxchg detection is done in boot, by testing if it
returns -EFAULT on a NULL address. This breaks when kernel access to
NULL during boot does not fault.

This patch allocates a non-zero guard PID for init_mm, and switches
kernel context to the guard PID at boot. This disallows access to the
kernel mapping from quadrant 0 at boot.

The effectiveness of this protection will be diminished a little after
boot when kernel threads inherit the last context, but those should
have NULL guard areas, and it's possible we will actually prefer to do
a non-lazy switch back to the guard PID in a future change. For now,
this gives a minimal fix, and gives NULL pointer protection for boot.
---
 arch/powerpc/mm/pgtable-radix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 573a9a2ee455..6389a8527e4a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -20,6 +20,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/mmu_context.h>
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
@@ -333,6 +334,9 @@ static void __init radix_init_pgtable(void)
 		     "r" (TLBIEL_INVAL_SET_LPID), "r" (0));
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 	trace_tlbie(0, 0, TLBIEL_INVAL_SET_LPID, 0, 2, 1, 1);
+
+	init_mm.context.id = mmu_base_pid;
+	mmu_base_pid++;
 }
 
 static void __init radix_init_partition_table(void)
@@ -579,7 +583,7 @@ void __init radix__early_init_mmu(void)
 
 	radix_init_iamr();
 	radix_init_pgtable();
-
+	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
 		tlbiel_all();
 }
@@ -604,6 +608,7 @@ void radix__early_init_mmu_secondary(void)
 	}
 	radix_init_iamr();
 
+	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
 		tlbiel_all();
 }
-- 
2.15.1
