Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CBDC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 01:04:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DF92075C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 01:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DF92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Znp03mf1zDqdk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 12:04:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Znm30wQFzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 12:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43Znm26zVyz9sN8; Thu, 10 Jan 2019 12:02:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Znm265pgz9sLw;
 Thu, 10 Jan 2019 12:02:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Show PAGE_SIZE in __die() output
In-Reply-To: <eb8df6c8-5850-cd50-778d-52102f4b4bbd@c-s.fr>
References: <20190108120500.2547-1-mpe@ellerman.id.au>
 <20190108120500.2547-2-mpe@ellerman.id.au>
 <324827d2-b736-5726-76d7-3ece152a30cd@c-s.fr>
 <eb8df6c8-5850-cd50-778d-52102f4b4bbd@c-s.fr>
Date: Thu, 10 Jan 2019 12:02:40 +1100
Message-ID: <87muo9s4sv.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 08/01/2019 =C3=A0 13:21, Christophe Leroy a =C3=A9crit=C2=A0:
>> Le 08/01/2019 =C3=A0 13:05, Michael Ellerman a =C3=A9crit=C2=A0:
>>> The page size the kernel is built with is useful info when debugging a
>>> crash, so add it to the output in __die().
>>>
>>> Result looks like eg:
>>>
>>> =C2=A0=C2=A0 kernel BUG at drivers/misc/lkdtm/bugs.c:63!
>>> =C2=A0=C2=A0 Oops: Exception in kernel mode, sig: 5 [#1]
>>> =C2=A0=C2=A0 LE PAGE_SIZE=3D64K SMP NR_CPUS=3D2048 NUMA pSeries
>>> =C2=A0=C2=A0 Modules linked in: vmx_crypto kvm binfmt_misc ip_tables
>>>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>> =C2=A0 arch/powerpc/kernel/traps.c | 12 ++++++++++++
>>> =C2=A0 1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>>> index 431a86d3f772..fc972e4eee5f 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -268,6 +268,18 @@ static int __die(const char *str, struct pt_regs=20
>>> *regs, long err)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_buf_puts(&s,=
 "BE ");
>>> +=C2=A0=C2=A0=C2=A0 seq_buf_puts(&s, "PAGE_SIZE=3D");
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_PPC_4K_PAGES))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_buf_puts(&s, "4K ");
>>> +=C2=A0=C2=A0=C2=A0 else if (IS_ENABLED(CONFIG_PPC_16K_PAGES))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_buf_puts(&s, "16K ");
>>> +=C2=A0=C2=A0=C2=A0 else if (IS_ENABLED(CONFIG_PPC_64K_PAGES))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_buf_puts(&s, "64K ");
>>> +=C2=A0=C2=A0=C2=A0 else if (IS_ENABLED(CONFIG_PPC_256K_PAGES))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_buf_puts(&s, "256K ");
>>=20
>> Can't we build all the above at once using PAGE_SHIFT ?
>>=20
>> Something like (untested):
>>=20
>> "%dK ", 1 << (PAGE_SHIFT - 10)
>
> Or even simplier:
>
> "%dK ", PAGE_SIZE / 1024

Yep, good point.

Clearly I have forgotten how to program over the break (if I ever knew).

cheers
