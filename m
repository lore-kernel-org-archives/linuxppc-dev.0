Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400zl56cPLzDrLY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 02:47:45 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 68so28448pfx.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 08:47:45 -0700 (PDT)
Date: Wed, 14 Mar 2018 01:47:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/14] powerpc/64: move default SPR recording
Message-ID: <20180314014733.651972d8@roar.ozlabs.ibm.com>
In-Reply-To: <87zi3cf9i6.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-8-npiggin@gmail.com>
 <87zi3cf9i6.fsf@concordia.ellerman.id.au>
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

On Tue, 13 Mar 2018 23:25:05 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Move this into the early setup code, and don't iterate over CPU masks.
> > We don't want to call into sysfs so early from setup, and a future patch
> > won't initialize CPU masks by the time this is called.
> > ---
> >  arch/powerpc/kernel/paca.c     |  3 +++
> >  arch/powerpc/kernel/setup.h    |  9 +++------
> >  arch/powerpc/kernel/setup_64.c |  8 ++++++++
> >  arch/powerpc/kernel/sysfs.c    | 18 +++++++-----------
> >  4 files changed, 21 insertions(+), 17 deletions(-)  
> 
> This patch, and 8, 9, 10, aren't signed-off by you.
> 
> I'll assume you just forgot and add it.

Can I give you an incremental fix for this patch? dscr_default
is zero at this point, so set it from spr_default_dscr before
setting pacas.

Remove the assignment from initialise_paca -- this happens too
early and gets overwritten anyway.

---
 arch/powerpc/kernel/paca.c  | 3 ---
 arch/powerpc/kernel/sysfs.c | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 2f3187501a36..7736188c764f 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -133,9 +133,6 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
 	new_paca->data_offset = 0xfeeeeeeeeeeeeeeeULL;
-#ifdef CONFIG_PPC64
-	new_paca->dscr_default = spr_default_dscr;
-#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	new_paca->slb_shadow_ptr = NULL;
 #endif
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index aaab582a640c..755dc98a57ae 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -20,6 +20,7 @@
 #include <asm/firmware.h>
 
 #include "cacheinfo.h"
+#include "setup.h"
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -592,6 +593,7 @@ static void sysfs_create_dscr_default(void)
 		int err = 0;
 		int cpu;
 
+		dscr_default = spr_default_dscr;
 		for_each_possible_cpu(cpu)
 			paca_ptrs[cpu]->dscr_default = dscr_default;
 
-- 
2.16.1
