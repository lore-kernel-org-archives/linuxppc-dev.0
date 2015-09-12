Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 32D021A2BD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2015 19:57:26 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc32: memcpy/memset: only use dcbz once cache is
 enabled
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <scottwood@freescale.com>
References: <20150910064112.7B7791A241C@localhost.localdomain>
 <1441922743.2909.8.camel@freescale.com>
 <1441934656.23806.3.camel@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, sojkam1@fel.cvut.cz,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <55F3F701.5030303@c-s.fr>
Date: Sat, 12 Sep 2015 11:57:21 +0200
MIME-Version: 1.0
In-Reply-To: <1441934656.23806.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/09/2015 03:24, Michael Ellerman a écrit :
> On Thu, 2015-09-10 at 17:05 -0500, Scott Wood wrote:
>>
>> I don't think this duplication is what Michael meant by "the normal cpu
>> feature sections".  What else is going to use this very specific
>> infrastructure?
> Yeah, sorry, I was hoping you could do it with the existing cpu feature
> mechanism.
>
> It looks like the timing doesn't work, ie. you need to patch this stuff in
> machine_init(), which is later than the regular patching which gets done in
> early_init().
>
> This is one of the festering differences we have between the 32 and 64-bit
> initialisation code, ie. on 64-bit we do the patching much later.
>
>

I've just thought about maybe another alternative.
Is there any issue with calling do_feature_fixups() twice for the same 
features ?
If not, we could define a MMU_CACHE_NOW_ON dummy MMU feature, then
call again do_feature_fixups() in machine_init() to patch memcpy/memset 
stuff, something like:

In arch/powerpc/include/asm/mmu.h:
+#define MMU_CACHE_NOW_ON                ASM_CONST(0x00008000)

In arch/powerpc/kernel/setup_32.c: @machine_init()

         udbg_early_init();

+        spec = identify_cpu(0, mfspr(SPRN_PVR));
+        do_feature_fixups(spec->mmu_features | MMU_CACHE_NOW_ON,
+                          &__start___mmu_ftr_fixup,
+                          &__stop___mmu_ftr_fixup);

         /* Do some early initialization based on the flat device tree */
         early_init_devtree(__va(dt_ptr));


Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
