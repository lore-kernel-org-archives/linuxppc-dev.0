Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 01:35:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2B920727
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 01:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WjpcLOF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2B920727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NWDh0sTJzDr0X
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 11:35:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NWBk50X5zDqv2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 11:33:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WjpcLOF+; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49NWBh5Gvbz9sRR;
 Fri, 15 May 2020 11:33:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589506398;
 bh=HZwpMgwZ+gFLuEKxJKcGHxze54wRm1UiNaTXNQ+beNM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WjpcLOF+33jdOQ+SZpanPAJqwMRfkc0KU+9mBz8E4uQS6A17ArPHEPg325R9HXMO2
 KseIUv4/AGA3jEFrpqzOdpaO8k9XuF+bZJ2YTPZHEmbAgNQh3vUaNg21T4tiyCNwRY
 IpSOLjHYsHEabBNvQdlj54yuh5KYwPyfrfeLskk4gnfVC+AIljQyeumBnwdBODaZJ9
 qnKlfzlYUHhLp6yX4nq9BRjBua4nh5/CtKo8HGAjGsqlCGQULteYGImjNcdTeDbiIx
 XhMXaDWhKP2cJiBEX/TE0wqdMtKXxAjIyyhxUOP9SV2l9pA1n58tkG1LjAVt0VzSc7
 DEW1mUq/15N6w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 23/30] powerpc: Add prefixed instructions to
 instruction data type
In-Reply-To: <56ca6bcb-c719-a049-63b0-aae73023bde5@csgroup.eu>
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-24-jniethe5@gmail.com>
 <56ca6bcb-c719-a049-63b0-aae73023bde5@csgroup.eu>
Date: Fri, 15 May 2020 11:33:32 +1000
Message-ID: <871rnmasnn.fsf@mpe.ellerman.id.au>
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
Cc: christophe.leroy@c-s.fr, alistair@popple.id.au, npiggin@gmail.com,
 bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 06/05/2020 =C3=A0 05:40, Jordan Niethe a =C3=A9crit=C2=A0:
>> For powerpc64, redefine the ppc_inst type so both word and prefixed
>> instructions can be represented. On powerpc32 the type will remain the
>> same.  Update places which had assumed instructions to be 4 bytes long.

...

>> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/a=
sm/uaccess.h
>> index c0a35e4586a5..217897927926 100644
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -105,11 +105,49 @@ static inline int __access_ok(unsigned long addr, =
unsigned long size,
>>   #define __put_user_inatomic(x, ptr) \
>>   	__put_user_nosleep((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
>>=20=20=20
>> +#ifdef __powerpc64__
>
> Replace by CONFIG_PPC64
>
>> +#define __get_user_instr(x, ptr)			\
>> +({							\
>> +	long __gui_ret =3D 0;				\
>> +	unsigned long __gui_ptr =3D (unsigned long)ptr;	\
>> +	struct ppc_inst __gui_inst;			\
>> +	unsigned int prefix, suffix;			\
>> +	__gui_ret =3D __get_user(prefix, (unsigned int __user *)__gui_ptr);	\
>
> __get_user() can be costly especially with KUAP. I think you should=20
> perform a 64 bits read and fallback on a 32 bits read only if the 64=20
> bits read failed.

I worry that might break something.

It _should_ be safe, but I'm paranoid.

If we think the KUAP overhead is a problem then I think we'd be better
off pulling the KUAP disable/enable into this macro.

>> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/featur=
e-fixups.c
>> index 2bd2b752de4f..a8238eff3a31 100644
>> --- a/arch/powerpc/lib/feature-fixups.c
>> +++ b/arch/powerpc/lib/feature-fixups.c
>> @@ -84,12 +84,13 @@ static int patch_feature_section(unsigned long value=
, struct fixup_entry *fcur)
>>   	src =3D alt_start;
>>   	dest =3D start;
>>=20=20=20
>> -	for (; src < alt_end; src++, dest++) {
>> +	for (; src < alt_end; src =3D (void *)src + ppc_inst_len(ppc_inst_read=
(src)),
>> +	     (dest =3D (void *)dest + ppc_inst_len(ppc_inst_read(dest)))) {
>
> Can we do this outside the for() for readability ?

I have an idea for cleaning these up, will post it as a follow-up to the se=
ries.

>> diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
>> index 08dedd927268..eb6f9ee28ac6 100644
>> --- a/arch/powerpc/lib/inst.c
>> +++ b/arch/powerpc/lib/inst.c
>> @@ -3,9 +3,49 @@
>>    *  Copyright 2020, IBM Corporation.
>>    */
>>=20=20=20
>> +#include <asm/ppc-opcode.h>
>>   #include <linux/uaccess.h>
>>   #include <asm/inst.h>
>>=20=20=20
>> +#ifdef __powerpc64__
>> +int probe_user_read_inst(struct ppc_inst *inst,
>> +			 struct ppc_inst *nip)
>> +{
>> +	unsigned int val, suffix;
>> +	int err;
>> +
>> +	err =3D probe_user_read(&val, nip, sizeof(val));
>
> A user read is costly with KUAP. Can we do a 64 bits read and perform a=20
> 32 bits read only when 64 bits read fails ?

Same comment as above.


cheers
