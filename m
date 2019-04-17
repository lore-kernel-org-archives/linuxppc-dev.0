Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A4C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:43:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013A620872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013A620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kk3G17T5zDqHn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:43:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kjMw06KmzDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44kjMv4Vrkz9s5c; Wed, 17 Apr 2019 23:12:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44kjMv2TGQz9s4V;
 Wed, 17 Apr 2019 23:12:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 10/10] powerpc/mm: Detect bad KUAP faults
In-Reply-To: <f1332a90-4404-8226-baae-f586c3f21fbb@c-s.fr>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-10-mpe@ellerman.id.au>
 <f1332a90-4404-8226-baae-f586c3f21fbb@c-s.fr>
Date: Wed, 17 Apr 2019 23:12:56 +1000
Message-ID: <875zrcvkpz.fsf@concordia.ellerman.id.au>
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
>> When KUAP is enabled we have logic to detect page faults that occur
>> outside of a valid user access region and are blocked by the AMR.
>>=20
>> What we don't have at the moment is logic to detect a fault *within* a
>> valid user access region, that has been incorrectly blocked by AMR.
>> This is not meant to ever happen, but it can if we incorrectly
>> save/restore the AMR, or if the AMR was overwritten for some other
>> reason.
>>=20
>> Currently if that happens we assume it's just a regular fault that
>> will be corrected by handling the fault normally, so we just return.
>> But there is nothing the fault handling code can do to fix it, so the
>> fault just happens again and we spin forever, leading to soft lockups.
>>=20
>> So add some logic to detect that case and WARN() if we ever see it.
>> Arguably it should be a BUG(), but it's more polite to fail the access
>> and let the kernel continue, rather than taking down the box. There
>> should be no data integrity issue with failing the fault rather than
>> BUG'ing, as we're just going to disallow an access that should have
>> been allowed.
>>=20
>> To make the code a little easier to follow, unroll the condition at
>> the end of bad_kernel_fault() and comment each case, before adding the
>> call to bad_kuap_fault().
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>=20
>> v5: New.
>>=20
>>   .../powerpc/include/asm/book3s/64/kup-radix.h | 12 +++++++++
>>   arch/powerpc/include/asm/kup.h                |  1 +
>>   arch/powerpc/mm/fault.c                       | 25 ++++++++++++++++---
>>   3 files changed, 35 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/power=
pc/include/asm/book3s/64/kup-radix.h
>> index 3d60b04fc3f6..8d2ddc61e92e 100644
>> --- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
>> +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
>> @@ -100,6 +100,18 @@ static inline void prevent_user_access(void __user =
*to, const void __user *from,
>>   	set_kuap(AMR_KUAP_BLOCKED);
>>   }
>>=20=20=20
>> +static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write)
>> +{
>> +	if (mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
>> +	    ((is_write && (regs->kuap & AMR_KUAP_BLOCK_WRITE)) ||
>> +	     (!is_write && (regs->kuap & AMR_KUAP_BLOCK_READ)))) {
>
> Should this { go on the previous line ?

Yeah I guess.

>> +		WARN(true, "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Rea=
d");
>> +		return true;
>
> Could just be
> 	return WARN(true, ....)
>
> Or even
> 	return WARN(mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
> 	    ((is_write && (regs->kuap & AMR_KUAP_BLOCK_WRITE)) ||
> 	     (!is_write && (regs->kuap & AMR_KUAP_BLOCK_READ))), ...);

That's not any more readable IMO.


>> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/k=
up.h
>> index f79d4d970852..ccbd2a249575 100644
>> --- a/arch/powerpc/include/asm/kup.h
>> +++ b/arch/powerpc/include/asm/kup.h
>> @@ -28,6 +28,7 @@ static inline void prevent_user_access(void __user *to=
, const void __user *from,
>>   				       unsigned long size) { }
>>   static inline void allow_read_from_user(const void __user *from, unsig=
ned long size) {}
>>   static inline void allow_write_to_user(void __user *to, unsigned long =
size) {}
>> +static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write) =
{ return false; }
>>   #endif /* CONFIG_PPC_KUAP */
>>=20=20=20
>>   static inline void prevent_read_from_user(const void __user *from, uns=
igned long size)
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 463d1e9d026e..b5d3578d9f65 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -224,7 +225,7 @@ static int mm_fault_error(struct pt_regs *regs, unsi=
gned long addr,
>>=20=20=20
>>   /* Is this a bad kernel fault ? */
>>   static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error=
_code,
>> -			     unsigned long address)
>> +			     unsigned long address, bool is_write)
>
> We have regs, do we need is_write in addition ?

It comes from error_code, which we also have. But I don't see any harm
passing it as we already have it calculated and sitting in a GPR.

cheers
