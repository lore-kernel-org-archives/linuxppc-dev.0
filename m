Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CDCC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:46:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2A520872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2A520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kk6N4vwQzDq5f
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:46:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kjSc4hjnzDqNQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:17:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44kjSc29VSz9s5c; Wed, 17 Apr 2019 23:17:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44kjSb75Zyz9s4V;
 Wed, 17 Apr 2019 23:17:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 10/10] powerpc/mm: Detect bad KUAP faults
In-Reply-To: <8d24e5eb-7313-73d3-fd25-ec9e73e7abfc@c-s.fr>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-10-mpe@ellerman.id.au>
 <f1332a90-4404-8226-baae-f586c3f21fbb@c-s.fr>
 <8d24e5eb-7313-73d3-fd25-ec9e73e7abfc@c-s.fr>
Date: Wed, 17 Apr 2019 23:17:01 +1000
Message-ID: <8736mgvkj6.fsf@concordia.ellerman.id.au>
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

christophe leroy <christophe.leroy@c-s.fr> writes:
> Le 08/03/2019 =C3=A0 09:53, Christophe Leroy a =C3=A9crit=C2=A0:
>> Le 08/03/2019 =C3=A0 02:16, Michael Ellerman a =C3=A9crit=C2=A0:
...
>>> diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h=20
>>> b/arch/powerpc/include/asm/book3s/64/kup-radix.h
>>> index 3d60b04fc3f6..8d2ddc61e92e 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
>>> @@ -100,6 +100,18 @@ static inline void prevent_user_access(void=20
>>> __user *to, const void __user *from,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_kuap(AMR_KUAP_BLOCKED);
>>> =C2=A0 }
>>> +static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((is_write && (regs->kuap &=
 AMR_KUAP_BLOCK_WRITE)) ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!is_write && (regs->=
kuap & AMR_KUAP_BLOCK_READ))))
>>> +=C2=A0=C2=A0=C2=A0 {
>>=20
>> Should this { go on the previous line ?
>>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN(true, "Bug: %s fault b=
locked by AMR!", is_write ?=20
>>> "Write" : "Read");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>=20
>> Could just be
>>  =C2=A0=C2=A0=C2=A0=C2=A0return WARN(true, ....)
>>=20
>> Or even
>>  =C2=A0=C2=A0=C2=A0=C2=A0return WARN(mmu_has_feature(MMU_FTR_RADIX_KUAP)=
 &&
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((is_write && (regs->kuap & =
AMR_KUAP_BLOCK_WRITE)) ||
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!is_write && (regs->k=
uap & AMR_KUAP_BLOCK_READ))), ...);
>
> Could also be simplified as follows since (is_write && ...) and=20
> (!is_write && ...) are mutually exclusive:
>
> mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
> (regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ))

Yeah I guess that is better.

I'll do:

static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write)
{
	return WARN(mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
		    (regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ)=
),
		    "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
}


cheers
