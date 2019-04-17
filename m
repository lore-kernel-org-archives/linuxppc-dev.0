Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3884DC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:54:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50C420872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50C420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kkHw5wzgzDqPf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:54:36 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kjyY0DDjzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:39:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44kjyX3mkhz9s71; Wed, 17 Apr 2019 23:39:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44kjyX0R3lz9s5c;
 Wed, 17 Apr 2019 23:39:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 09/10] powerpc/64s: Implement KUAP for Radix MMU
In-Reply-To: <fff6b7e5-1b97-85ad-defa-c429b9746f04@c-s.fr>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-9-mpe@ellerman.id.au>
 <fff6b7e5-1b97-85ad-defa-c429b9746f04@c-s.fr>
Date: Wed, 17 Apr 2019 23:39:29 +1000
Message-ID: <87zhoou4xa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 08/03/2019 =C3=A0 02:16, Michael Ellerman a =C3=A9crit=C2=A0:
...
>> diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/power=
pc/include/asm/book3s/64/kup-radix.h
>> new file mode 100644
>> index 000000000000..3d60b04fc3f6
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
>> @@ -0,0 +1,107 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
>> +#define _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
>> +
>> +#include <linux/const.h>
>> +
>> +#define AMR_KUAP_BLOCK_READ	UL(0x4000000000000000)
>> +#define AMR_KUAP_BLOCK_WRITE	UL(0x8000000000000000)
>> +#define AMR_KUAP_BLOCKED	(AMR_KUAP_BLOCK_READ | AMR_KUAP_BLOCK_WRITE)
>> +#define AMR_KUAP_SHIFT		62
>> +
>> +#ifdef __ASSEMBLY__
>> +
>> +.macro kuap_restore_amr	gpr
>
> What about calling it just kuap_restore (kuap_check and=20
> kuap_save_and_lock) , for the day we add an different implementation for=
=20
> non RADIX ?

I don't think we have any plan to use anything other than AMR. We can
always rename them if we do.

>> +#ifdef CONFIG_PPC_KUAP
>> +	BEGIN_MMU_FTR_SECTION_NESTED(67)
>> +	ld	\gpr, STACK_REGS_KUAP(r1)
>> +	mtspr	SPRN_AMR, \gpr
>> +	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
>> +#endif
>> +.endm
>> +
>> +.macro kuap_check_amr gpr1 gpr2
>
> What about using .macro kuap_check_amr gpr1, gpr2 instead to have a=20
> standard form with a ',' like kuap_save_amr_and_lock

Yep, that was not intentional.

>> +#ifdef CONFIG_PPC_KUAP_DEBUG
>> +	BEGIN_MMU_FTR_SECTION_NESTED(67)
>> +	mfspr	\gpr1, SPRN_AMR
>> +	li	\gpr2, (AMR_KUAP_BLOCKED >> AMR_KUAP_SHIFT)
>> +	sldi	\gpr2, \gpr2, AMR_KUAP_SHIFT
>> +999:	tdne	\gpr1, \gpr2
>> +	EMIT_BUG_ENTRY 999b,__FILE__,__LINE__, \
>> +		(BUGFLAG_WARNING|BUGFLAG_ONCE)
>
> This should fit on a single line.
> Also add space after , and around |

Yep, copy/pasted from elsewhere.

>> +.macro kuap_save_amr_and_lock gpr1, gpr2, use_cr, msr_pr_cr
>> +#ifdef CONFIG_PPC_KUAP
>> +	BEGIN_MMU_FTR_SECTION_NESTED(67)
>> +	.ifnb \msr_pr_cr
>> +	bne	\msr_pr_cr, 99f
>> +	.endif
>> +	mfspr	\gpr1, SPRN_AMR
>> +	std	\gpr1, STACK_REGS_KUAP(r1)
>> +	li	\gpr2, (AMR_KUAP_BLOCKED >> AMR_KUAP_SHIFT)
>> +	sldi	\gpr2, \gpr2, AMR_KUAP_SHIFT
>> +	cmpd	\use_cr, \gpr1, \gpr2
>
> On ppc32, I would have used rlwinm. to do the test. Is there an=20
> equivalent rldinm. (unless we need to preserve cr0) ?

I prefer to have the CR field specified, so we don't accidentally
clobber cr0 in some path where it is live.

>> +	beq	\use_cr, 99f
>> +	// We don't isync here because we very recently entered via rfid
>
> Is this form of comment acceptable now ? It used to be /* */ only.

Yeah it is, at least in powerpc code :)

>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/inc=
lude/asm/exception-64s.h
>> index 937bb630093f..bef4e05a6823 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -497,6 +497,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>>   	RESTORE_CTR(r1, area);						   \
>>   	b	bad_stack;						   \
>>   3:	EXCEPTION_PROLOG_COMMON_1();					   \
>> +	kuap_save_amr_and_lock r9, r10, cr1, cr0;			   \
>
> What about moving this to 4f, to avoid the cr test and branch in=20
> kuap_save_amr_and_lock  ?

Moving it there wouldn't help, because user & kernel entry both go
through 4f. So we'd still need to check if we're coming from user.

Or did I misunderstand?

>>   	beq	4f;			/* if from kernel mode		*/ \
>>   	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
>>   	SAVE_PPR(area, r9);						   \

>> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-r=
adix.c
>> index 224bcd4be5ae..0c87832ddd6c 100644
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -553,6 +554,23 @@ void __init setup_kuep(bool disabled)
>>   }
>>   #endif
>>=20=20=20
>> +#ifdef CONFIG_PPC_KUAP
>> +void __init setup_kuap(bool disabled)
>> +{
>> +	if (disabled || !early_radix_enabled())
>> +		return;
>> +
>> +	if (smp_processor_id() =3D=3D boot_cpuid) {
>> +		pr_info("Activating Kernel Userspace Access Prevention\n");
>> +		cur_cpu_spec->mmu_features |=3D MMU_FTR_RADIX_KUAP;
>> +	}
>> +
>> +	/* Make sure userspace can't change the AMR */
>> +	mtspr(SPRN_UAMOR, 0);
>> +	mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
>
> No isync() needed here ?

Will add.

>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platf=
orms/Kconfig.cputype
>> index 60371784c9f1..5e53b9fd62aa 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -370,6 +371,13 @@ config PPC_KUAP
>>=20=20=20
>>   	  If you're unsure, say Y.
>>=20=20=20
>> +config PPC_KUAP_DEBUG
>> +	bool "Extra debugging for Kernel Userspace Access Protection"
>> +	depends on PPC_HAVE_KUAP && PPC_RADIX_MMU
>
> Why only PPC_RADIX_MMU ?

Because it doesn't do anything useful unless radix is enabled.

We can remove it when another platform wants it.

Thanks for the review.

cheers
