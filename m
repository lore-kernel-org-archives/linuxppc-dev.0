Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BAC433FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 00:24:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DB622A84
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 00:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DB622A84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrvmM3hTSzDqPF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 11:24:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrvjY147DzDqtK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 11:21:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=iXVlNHV7; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CrvjQ4CCFz9sWR;
 Thu, 10 Dec 2020 11:21:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1607559694;
 bh=gUZqycqRbXTyBxFOg8awmtGV88oSNS0vpFmP17hRE8I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=iXVlNHV7UeasFgTcvPoOsDtvudLakpBzfGe/AodMrzWLe6r723U2AbOJKaPvvv7CY
 rCHNeEBRzlnTZqStVaQAbsyEv+pDNCUuBsko533qvj8TfG2p5gcg2XTofGs1v5rcZN
 Dn9i0TmnpAI6JubAMqDCkzjm7pE+xatB2SAo0EBlEuM0CaEFWbKn8SROn1iRJEAIJ6
 AbTi1WWeOSOIUico+Q0SDITrF+vUggxyOOiWawqRXlUGtfCaVmxl+4FbAs6RyzUvRE
 uWP9xksLPBCG/ZwJM97i74ms5+I/AVrkJPcqN2LNXOUKWGn3WqbMG12MLmQs2N9Ed3
 8JS1BtcWXh2hQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v1 2/6] powerpc/8xx: Always pin kernel text TLB
In-Reply-To: <a726961f-f440-b553-6c46-341a860dc90a@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
 <203b89de491e1379f1677a2685211b7c32adfff0.1606231483.git.christophe.leroy@csgroup.eu>
 <87lfe7s1j3.fsf@mpe.ellerman.id.au>
 <a726961f-f440-b553-6c46-341a860dc90a@csgroup.eu>
Date: Thu, 10 Dec 2020 11:21:29 +1100
Message-ID: <87ft4ese7q.fsf@mpe.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 09/12/2020 =C3=A0 11:43, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> There is no big poing in not pinning kernel text anymore, as now
>>> we can keep pinned TLB even with things like DEBUG_PAGEALLOC.
>>>
>>> Remove CONFIG_PIN_TLB_TEXT, making it always right.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/Kconfig               |  3 +--
>>>   arch/powerpc/kernel/head_8xx.S     | 20 +++-----------------
>>>   arch/powerpc/mm/nohash/8xx.c       |  3 +--
>>>   arch/powerpc/platforms/8xx/Kconfig |  7 -------
>>>   4 files changed, 5 insertions(+), 28 deletions(-)
>>>
>> ...
>>> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
>>> index 231ca95f9ffb..19a3eec1d8c5 100644
>>> --- a/arch/powerpc/mm/nohash/8xx.c
>>> +++ b/arch/powerpc/mm/nohash/8xx.c
>>> @@ -186,8 +186,7 @@ void mmu_mark_initmem_nx(void)
>>>   	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
>>>   	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
>>>=20=20=20
>>> -	if (IS_ENABLED(CONFIG_PIN_TLB_TEXT))
>>> -		mmu_pin_tlb(block_mapped_ram, false);
>>> +	mmu_pin_tlb(block_mapped_ram, false);
>>>   }
>>=20
>> This broke mpc885_ads_defconfig with:
>
> :surprise:
>
> How did I get it working ? Anyway, thanks for fixing it.

No worries. I figured you must have tested with some other series(s)
applied and/or with different configs, it happens :)

cheers
