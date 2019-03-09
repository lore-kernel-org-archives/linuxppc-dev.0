Return-Path: <SRS0=JAc6=RM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD5AC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 13:06:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B61C207E0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 13:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uPAg4uNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B61C207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Gl4W6jhPzDqBS
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 00:06:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="uPAg4uNM"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Gl2g3QLvzDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2019 00:04:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Gl2Z3QZJz9vRZq;
 Sat,  9 Mar 2019 14:04:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=uPAg4uNM; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CNV1d3R5hwrL; Sat,  9 Mar 2019 14:04:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Gl2Z1rWfz9vRZp;
 Sat,  9 Mar 2019 14:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552136694; bh=+Rt7i6fNjhhxxw/80wiSF1shy02m/8tTy1oJQ/SPEs0=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=uPAg4uNMqPjoBewIQLmgu6DkMVcdacTeJw73eW/OO/4oubkGxiOacjju0ATzT69Dw
 Hb08RbZuorIDimuh/82kZRH4m1KsmNfOKCelboUv/jZXYOTae36iGG0ps7sVwh8Xgw
 VI36VLMKB7nESdVr+qKO9Iyz7BtYOSJCFpBmy0dQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B9B68BFBC;
 Sat,  9 Mar 2019 14:04:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id C4jkz2mKiG2o; Sat,  9 Mar 2019 14:04:55 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BAF908B806;
 Sat,  9 Mar 2019 14:04:54 +0100 (CET)
Subject: Re: [PATCH 7/7] powerpc/book3s32: Implement Kernel Userspace Access
 Protection
From: christophe leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
References: <cover.1551820474.git.christophe.leroy@c-s.fr>
 <cc0bb290a0dabcdbc422fd4721e000ea115a5beb.1551820475.git.christophe.leroy@c-s.fr>
Message-ID: <331677fa-2504-1add-5dff-d1554ab617ea@c-s.fr>
Date: Sat, 9 Mar 2019 14:04:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cc0bb290a0dabcdbc422fd4721e000ea115a5beb.1551820475.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190309-0, 09/03/2019), Outbound message
X-Antivirus-Status: Clean
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Russel,

As you can see in patchwork, snowpatch report 3477 new sparse warning(s) 
with this series.

Half of them are because of a cast of __user pointer to u32. I'll fix it 
by adding __force to the cast.

The other half comes from the use of min() macro. The induced warning is 
"warning: expression using sizeof(void)". This is because of a bug in 
sparse.

The above bug is fixed in sparse 0.6.0. Could you update snowpatch to 
use that version ?

Thanks
Christophe

Le 05/03/2019 à 22:18, Christophe Leroy a écrit :
> This patch implements Kernel Userspace Access Protection for
> book3s/32.
> 
> Due to limitations of the processor page protection capabilities,
> the protection is only against writing. read protection cannot be
> achieved using page protection.
> 
> The previous patch modifies the page protection so that RW user
> pages are RW for Key 0 and RO for Key 1, and it sets Key 0 for
> both user and kernel.
> 
> This patch changes userspace segment registers are set to Ku 0
> and Ks 1. When kernel needs to write to RW pages, the associated
> segment register is then changed to Ks 0 in order to allow write
> access to the kernel.
> 
> In order to avoid having the read all segment registers when
> locking/unlocking the access, some data is kept in the thread_struct
> and saved on stack on exceptions. The field identifies both the
> first unlocked segment and the first segment following the last
> unlocked one. When no segment is unlocked, it contains value 0.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/book3s/32/kup.h | 96 ++++++++++++++++++++++++++++++++
>   arch/powerpc/include/asm/kup.h           |  3 +
>   arch/powerpc/include/asm/processor.h     |  3 +
>   arch/powerpc/kernel/asm-offsets.c        |  3 +
>   arch/powerpc/kernel/head_32.S            |  7 +++
>   arch/powerpc/mm/ppc_mmu_32.c             | 10 ++++
>   arch/powerpc/platforms/Kconfig.cputype   |  1 +
>   7 files changed, 123 insertions(+)
>   create mode 100644 arch/powerpc/include/asm/book3s/32/kup.h
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
> new file mode 100644
> index 000000000000..3f02db633849
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_BOOK3S_32_KUP_H
> +#define _ASM_POWERPC_BOOK3S_32_KUP_H
> +
> +#ifdef CONFIG_PPC_KUAP
> +
> +#include <asm/book3s/32/mmu-hash.h>
> +
> +#ifdef __ASSEMBLY__
> +
> +.macro kuap_update_sr	gpr1, gpr2, gpr3	/* NEVER use r0 as gpr2 due to addis */
> +101:	mtsrin	\gpr1, \gpr2
> +	addi	\gpr1, \gpr1, 0x111		/* next VSID */
> +	rlwinm	\gpr1, \gpr1, 0, 0xf0ffffff	/* clear VSID overflow */
> +	addis	\gpr2, \gpr2, 0x1000		/* address of next segment */
> +	cmplw	\gpr2, \gpr3
> +	blt-	101b
> +.endm
> +
> +.macro kuap_save_and_lock	sp, thread, gpr1, gpr2, gpr3
> +	lwz	\gpr2, KUAP(\thread)
> +	rlwinm.	\gpr3, \gpr2, 28, 0xf0000000
> +	stw	\gpr2, STACK_REGS_KUAP(\sp)
> +	beq+	102f
> +	li	\gpr1, 0
> +	stw	\gpr1, KUAP(\thread)
> +	mfsrin	\gpr1, \gpr2
> +	oris	\gpr1, \gpr1, SR_KS@h	/* set Ks */
> +	kuap_update_sr	\gpr1, \gpr2, \gpr3
> +102:
> +.endm
> +
> +.macro kuap_restore	sp, current, gpr1, gpr2, gpr3
> +	lwz	\gpr2, STACK_REGS_KUAP(\sp)
> +	rlwinm.	\gpr3, \gpr2, 28, 0xf0000000
> +	stw	\gpr2, THREAD + KUAP(\current)
> +	beq+	102f
> +	mfsrin	\gpr1, \gpr2
> +	rlwinm	\gpr1, \gpr1, 0, ~SR_KS	/* Clear Ks */
> +	kuap_update_sr	\gpr1, \gpr2, \gpr3
> +102:
> +.endm
> +
> +.macro kuap_check	current, gpr
> +#ifdef CONFIG_PPC_KUAP_DEBUG
> +	lwz	\gpr2, KUAP(thread)
> +999:	twnei	\gpr, 0
> +	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
> +#endif
> +.endm
> +
> +#else /* !__ASSEMBLY__ */
> +
> +#include <linux/sched.h>
> +
> +static inline void kuap_update_sr(u32 sr, u32 addr, u32 end)
> +{
> +	barrier();	/* make sure thread.kuap is updated before playing with SRs */
> +	while (addr < end) {
> +		mtsrin(sr, addr);
> +		sr += 0x111;		/* next VSID */
> +		sr &= 0xf0ffffff;	/* clear VSID overflow */
> +		addr += 0x10000000;	/* address of next segment */
> +	}
> +	isync();	/* Context sync required after mtsrin() */
> +}
> +
> +static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
> +{
> +	u32 addr = (u32)to;
> +	u32 end = min(addr + size, TASK_SIZE);
> +
> +	if (!addr || addr >= TASK_SIZE || !size)
> +		return;
> +
> +	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
> +	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
> +}
> +
> +static inline void prevent_user_access(void __user *to, const void __user *from, u32 size)
> +{
> +	u32 addr = (u32)to;
> +	u32 end = min(addr + size, TASK_SIZE);
> +
> +	if (!addr || addr >= TASK_SIZE || !size)
> +		return;
> +
> +	current->thread.kuap = 0;
> +	kuap_update_sr(mfsrin(addr) | SR_KS, addr, end);	/* set Ks */
> +}
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* CONFIG_PPC_KUAP */
> +
> +#endif /* _ASM_POWERPC_BOOK3S_32_KUP_H */
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
> index 2ab9e904c22c..2f42e8c19506 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -8,6 +8,9 @@
>   #ifdef CONFIG_PPC_8xx
>   #include <asm/nohash/32/kup-8xx.h>
>   #endif
> +#ifdef CONFIG_PPC_BOOK3S_32
> +#include <asm/book3s/32/kup.h>
> +#endif
>   
>   #ifdef __ASSEMBLY__
>   #ifndef CONFIG_PPC_KUAP
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 3351bcf42f2d..540949b397d4 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -164,6 +164,9 @@ struct thread_struct {
>   	unsigned long	rtas_sp;	/* stack pointer for when in RTAS */
>   #endif
>   #endif
> +#if defined(CONFIG_PPC_BOOK3S_32) && defined(CONFIG_PPC_KUAP)
> +	unsigned long	kuap;		/* opened segments for user access */
> +#endif
>   	/* Debug Registers */
>   	struct debug_reg debug;
>   	struct thread_fp_state	fp_state;
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 66202e02fee2..60b82198de7c 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -147,6 +147,9 @@ int main(void)
>   #if defined(CONFIG_KVM) && defined(CONFIG_BOOKE)
>   	OFFSET(THREAD_KVM_VCPU, thread_struct, kvm_vcpu);
>   #endif
> +#if defined(CONFIG_PPC_BOOK3S_32) && defined(CONFIG_PPC_KUAP)
> +	OFFSET(KUAP, thread_struct, kuap);
> +#endif
>   
>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>   	OFFSET(PACATMSCRATCH, paca_struct, tm_scratch);
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 46b633514422..d5dc62997267 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -900,6 +900,9 @@ load_up_mmu:
>   	li	r0, NUM_USER_SEGMENTS /* load up user segment register values */
>   	mtctr	r0		/* for context 0 */
>   	li	r3, 0		/* Kp = 0, Ks = 0, VSID = 0 */
> +#ifdef CONFIG_PPC_KUAP
> +	oris	r3, r3, SR_KS@h	/* Set Ks */
> +#endif
>   	li	r4,0
>   3:	mtsrin	r3,r4
>   	addi	r3,r3,0x111	/* increment VSID */
> @@ -907,6 +910,7 @@ load_up_mmu:
>   	bdnz	3b
>   	li	r0, 16 - NUM_USER_SEGMENTS /* load up kernel segment registers */
>   	mtctr	r0			/* for context 0 */
> +	rlwinm	r3, r3, 0, ~SR_KS	/* Ks = 0 */
>   	oris	r3, r3, SR_KP@h		/* Kp = 1 */
>   3:	mtsrin	r3, r4
>   	addi	r3, r3, 0x111	/* increment VSID */
> @@ -1015,6 +1019,9 @@ _ENTRY(switch_mmu_context)
>   	blt-	4f
>   	mulli	r3,r3,897	/* multiply context by skew factor */
>   	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
> +#ifdef CONFIG_PPC_KUAP
> +	oris	r3, r3, SR_KS@h	/* Set Ks */
> +#endif
>   	li	r0,NUM_USER_SEGMENTS
>   	mtctr	r0
>   
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index 2d5b0d50fb31..417cf33aa5ba 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -392,3 +392,13 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>   	else /* Anything else has 256M mapped */
>   		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
>   }
> +
> +#ifdef CONFIG_PPC_KUAP
> +void __init setup_kuap(bool disabled)
> +{
> +	pr_info("Activating Kernel Userspace Access Protection\n");
> +
> +	if (disabled)
> +		pr_warn("KUAP cannot be disabled yet on 6xx when compiled in\n");
> +}
> +#endif
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index ab586963893a..e3a5cbcc7700 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -25,6 +25,7 @@ config PPC_BOOK3S_32
>   	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
>   	select PPC_FPU
>   	select PPC_HAVE_PMU_SUPPORT
> +	select PPC_HAVE_KUAP
>   
>   config PPC_85xx
>   	bool "Freescale 85xx"
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

