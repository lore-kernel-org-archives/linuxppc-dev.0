Return-Path: <SRS0=Nfv6=VJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA7CC742A8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 07:02:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74EA2084B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 07:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74EA2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45lP4X2qhvzDqrj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 17:02:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45lP2225MSzDqnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2019 17:00:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45lP2107h2z9s00;
 Fri, 12 Jul 2019 17:00:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 3/3] powerpc/module64: Use symbolic instructions names.
In-Reply-To: <9bc00fb4-379a-e19b-4d27-32fff8f9781b@c-s.fr>
References: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556865423.git.christophe.leroy@c-s.fr>
 <6fb61d1c9104b0324d4a9c445f431c0928c7ea25.1556865423.git.christophe.leroy@c-s.fr>
 <87bly5ibsd.fsf@concordia.ellerman.id.au>
 <9bc00fb4-379a-e19b-4d27-32fff8f9781b@c-s.fr>
Date: Fri, 12 Jul 2019 17:00:08 +1000
Message-ID: <87wogneo07.fsf@concordia.ellerman.id.au>
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
Cc: Ulirch Weigand <Ulrich.Weigand@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 08/07/2019 =C3=A0 02:56, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> To increase readability/maintainability, replace hard coded
>>> instructions values by symbolic names.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>> v3: fixed warning by adding () in an 'if' around X | Y (unlike said in =
v2 history, this change was forgotten in v2)
>>> v2: rearranged comments
>>>
>>>   arch/powerpc/kernel/module_64.c | 53 +++++++++++++++++++++++++++-----=
---------
>>>   1 file changed, 35 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/modu=
le_64.c
>>> index c2e1b06253b8..b33a5d5e2d35 100644
>>> --- a/arch/powerpc/kernel/module_64.c
>>> +++ b/arch/powerpc/kernel/module_64.c
>>> @@ -704,18 +711,21 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>> ...
>>>   			/*
>>>   			 * If found, replace it with:
>>>   			 *	addis r2, r12, (.TOC.-func)@ha
>>>   			 *	addi r2, r12, (.TOC.-func)@l
>>>   			 */
>>> -			((uint32_t *)location)[0] =3D 0x3c4c0000 + PPC_HA(value);
>>> -			((uint32_t *)location)[1] =3D 0x38420000 + PPC_LO(value);
>>> +			((uint32_t *)location)[0] =3D PPC_INST_ADDIS | __PPC_RT(R2) |
>>> +						    __PPC_RA(R12) | PPC_HA(value);
>>> +			((uint32_t *)location)[1] =3D PPC_INST_ADDI | __PPC_RT(R2) |
>>> +						    __PPC_RA(R12) | PPC_LO(value);
>>>   			break;
>>=20
>> This was crashing and it's amazing how long you can stare at a
>> disassembly and not see the difference between `r2` and `r12` :)
>
> Argh, yes. I was misleaded by the comment I guess. Sorry for that and=20
> thanks for fixing.

No worries, yes the comment was the problem. I fixed that as well.

cheers
