Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F3FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:45:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F8664EFD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F8664EFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F22Bp5f5mz3c5x
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 22:45:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=BLFuyB4f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=BLFuyB4f; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F22BK3lgGz2yR2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 22:44:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F22BG3w08z9sRR;
 Fri, 19 Mar 2021 22:44:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616154295;
 bh=4OvAWpSdUbbA7qhkw2mCkkhz/DdW53pscA/IF09MLJg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BLFuyB4fhDCvrCBffIHe4uqM28aNMCHfhsASgbXl5PTe5zPaG76x8VtQXCaiZQk/c
 GIY5rvklTy7vkHHkPhp/rcy38YQ2pkS23NRVm+K6gh6DMiCoq+wAlvCfw+xyZYRaTv
 nZ9klLiCg/Pl4S0YDh6llB4bZlW8WfsIF4AmBUbPSMRCN8/qPE7vKaFDt4jO9RnKRJ
 7Ygo3Gt6Yq6myY13MmOL/biZNWvQqet1IlvvpP68JmBSIIW2GjLKbrfaLsb+8EpWXb
 ZiqFiYON4tkeMbkWtr0o8TYydaNIBB9DTC2uwEp814hORhuxip7PM6erBUEZSNq+64
 bsufL632tThyQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 28/32] powerpc/64s: interrupt implement exit logic in C
In-Reply-To: <1615879834.64tfygznle.astroid@bobo.none>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <20200225173541.1549955-29-npiggin@gmail.com>
 <2d68d9ad-c3a2-2372-a5b2-1a1e3fdb41e4@csgroup.eu>
 <1615879834.64tfygznle.astroid@bobo.none>
Date: Fri, 19 Mar 2021 22:44:53 +1100
Message-ID: <874kh78j0q.fsf@mpe.ellerman.id.au>
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
Cc: Michal Suchanek <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Christophe Leroy's message of March 15, 2021 11:41 pm:
>>=20
>> Le 25/02/2020 =C3=A0 18:35, Nicholas Piggin a =C3=A9crit=C2=A0:
>>> Implement the bulk of interrupt return logic in C. The asm return code
>>> must handle a few cases: restoring full GPRs, and emulating stack store.
>>>=20
>>> The stack store emulation is significantly simplfied, rather than creat=
ing
>>> a new return frame and switching to that before performing the store, it
>>> uses the PACA to keep a scratch register around to perform thestore.
>>>=20
>>> The asm return code is moved into 64e for now. The new logic has made
>>> allowance for 64e, but I don't have a full environment that works well
>>> to test it, and even booting in emulated qemu is not great for stress
>>> testing. 64e shouldn't be too far off working with this, given a bit
>>> more testing and auditing of the logic.
>>>=20
>>> This is slightly faster on a POWER9 (page fault speed increases about
>>> 1.1%), probably due to reduced mtmsrd.
>>>=20
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>>> ---
>>=20
>> ...
>>=20
>>> +notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs=
, unsigned long msr)
>>> +{
>>=20
>> ...
>>=20
>>> +
>>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>> +	local_paca->tm_scratch =3D regs->msr;
>>> +#endif
>>=20
>> Could we define a helper for that in asm/tm.h, that voids when CONFIG_PP=
C_TRANSACTIONAL_MEM is not=20
>> selected ?
>
> Yeah I wanted to do something about that. I don't know what it's used=20
> for here. I guess it saves the return MSR so if that causes a crash then=
=20
> the next oops would see it, but I wonder if we can just get that from=20
> SRR1 + program check error codes, or if there is something we can't
> reconstruct from there.

In the cases when you need it, you can't reconstruct it :)

But given the TM code is on life support we could probably drop
tm_scratch.

I don't think we've used it in anger for several years. Probably since
265e60a170d0 ("powerpc/64s: Use emergency stack for kernel TM Bad Thing
program checks") (Oct 2017).

If one of us has to debug some hairy TM issue we can always add it back
temporarily in a dev kernel.

cheers
