Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A51C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:09:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD41218B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD41218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q2ZC32zfzDqRt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 21:09:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q2XT4KHDzDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 21:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Q2XS58nRz9sQv;
 Thu, 21 Mar 2019 21:07:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/highmem: change BUG_ON() to WARN_ON()
In-Reply-To: <9048ba12-a014-3ebe-c414-26f87401c758@c-s.fr>
References: <0365f99ce2b9273e269a241394957cba924f995e.1551951985.git.christophe.leroy@c-s.fr>
 <87va0c23s8.fsf@concordia.ellerman.id.au>
 <9048ba12-a014-3ebe-c414-26f87401c758@c-s.fr>
Date: Thu, 21 Mar 2019 21:07:35 +1100
Message-ID: <87sgvg1qxk.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 21/03/2019 =C3=A0 06:29, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> In arch/powerpc/mm/highmem.c, BUG_ON() is called only when
>>> CONFIG_DEBUG_HIGHMEM is selected, this means the BUG_ON() is
>>> not vital and can be replaced by a a WARN_ON
>>>
>>> At the sametime, use IS_ENABLED() instead of #ifdef to clean a bit.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/mm/highmem.c | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
>>> index 82a0e37557a5..b68c9f20fbdf 100644
>>> --- a/arch/powerpc/mm/highmem.c
>>> +++ b/arch/powerpc/mm/highmem.c
>>> @@ -56,7 +54,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
>>>   void __kunmap_atomic(void *kvaddr)
>>>   {
>>>   	unsigned long vaddr =3D (unsigned long) kvaddr & PAGE_MASK;
>>> -	int type __maybe_unused;
>>> +	int type;
>>=20
>> Why don't we move type into the block below.
>
> Yes you're right, when Mathieu introduced the __maybe_unused, I was=20
> wrongly thinging that kmap_atomic_idx() was doing something important=20
> that had to be done also when DEBUG was not selected, but indeed it does=
=20
> nothing else than returning the type.
>
> I'll send a new patch.

I can just fix it up when applying.

cheers
