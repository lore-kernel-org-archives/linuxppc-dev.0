Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965EC433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 10:42:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E99C600EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 10:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E99C600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HW2rp43LSz3cDJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 21:42:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ZHQFcloz;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HW2r55Tcmz3086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Oct 2021 21:41:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ZHQFcloz; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HW2r25ssqz4xb7;
 Fri, 15 Oct 2021 21:41:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1634294483;
 bh=bNysAT2yE6w9wiegIMNjvhocdCZCDmy22h3I/pa+wWE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ZHQFclozr7Q1JKGkjwCJByE/6A8Azu988BmRVgSmSYyB6LHM4DapCpXF6XAhJoZRQ
 o4eiUrMs3v1BOT0BnSRrh5g+cCBjRKh8qa60suzHiKDpffBI2X0ziATBaQeO5kJ2Pp
 QbAp7pzGYDNIWB0Vs6Zr9b442c1laPozYhdTPSI93pZ2eqnLD9ReFLXcq/inrIxX1P
 VcCt4aP6MuZzJv4mKqr33zxoxR+zbBaASyer++umvBHAf8bGOsZQaB7E+CnVf3dIl2
 7/sWjDuAJE6ujIxGCtxHhzoENsw6ALk6YWDSvxRuDX500X8pRhqrMSwrCys89S4T7T
 XC0mrkwCTCJGQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Joel Stanley
 <joel@jms.id.au>, Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v2] powerpc/s64: Clarify that radix lacks DEBUG_PAGEALLOC
In-Reply-To: <6fb9e0ec-8ac8-1cc3-38de-78749ffee623@csgroup.eu>
References: <20211013213438.675095-1-joel@jms.id.au>
 <6fb9e0ec-8ac8-1cc3-38de-78749ffee623@csgroup.eu>
Date: Fri, 15 Oct 2021 21:41:17 +1100
Message-ID: <875ytyy3hu.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 13/10/2021 =C3=A0 23:34, Joel Stanley a =C3=A9crit=C2=A0:
>> The page_alloc.c code will call into __kernel_map_pages when
>> DEBUG_PAGEALLOC is configured and enabled.
>>=20
>> As the implementation assumes hash, this should crash spectacularly if
>> not for a bit of luck in __kernel_map_pages. In this function
>> linear_map_hash_count is always zero, the for loop exits without doing
>> any damage.
>>=20
>> There are no other platforms that determine if they support
>> debug_pagealloc at runtime. Instead of adding code to mm/page_alloc.c to
>> do that, this change turns the map/unmap into a noop when in radix
>> mode and prints a warning once.
>>=20
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> v2: Put __kernel_map_pages in pgtable.h
>>=20
>>   arch/powerpc/include/asm/book3s/64/hash.h    |  2 ++
>>   arch/powerpc/include/asm/book3s/64/pgtable.h | 11 +++++++++++
>>   arch/powerpc/include/asm/book3s/64/radix.h   |  3 +++
>>   arch/powerpc/mm/book3s64/hash_utils.c        |  2 +-
>>   arch/powerpc/mm/book3s64/radix_pgtable.c     |  7 +++++++
>>   5 files changed, 24 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/in=
clude/asm/book3s/64/hash.h
>> index d959b0195ad9..674fe0e890dc 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -255,6 +255,8 @@ int hash__create_section_mapping(unsigned long start=
, unsigned long end,
>>   				 int nid, pgprot_t prot);
>>   int hash__remove_section_mapping(unsigned long start, unsigned long en=
d);
>>=20=20=20
>> +void hash__kernel_map_pages(struct page *page, int numpages, int enable=
);
>> +
>>   #endif /* !__ASSEMBLY__ */
>>   #endif /* __KERNEL__ */
>>   #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc=
/include/asm/book3s/64/pgtable.h
>> index 5d34a8646f08..265661ded238 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -1101,6 +1101,17 @@ static inline void vmemmap_remove_mapping(unsigne=
d long start,
>>   }
>>   #endif
>>=20=20=20
>> +#ifdef CONFIG_DEBUG_PAGEALLOC
>> +static inline void __kernel_map_pages(struct page *page, int numpages, =
int enable)
>> +{
>> +	if (radix_enabled()) {
>> +		radix__kernel_map_pages(page, numpages, enable);
>> +		return;
>> +	}
>> +	hash__kernel_map_pages(page, numpages, enable);
>
> I'd have prefered something like below
>
> 	if (radix_enabled())
> 		radix__kernel_map_pages(page, numpages, enable);
> 	else
> 		hash__kernel_map_pages(page, numpages, enable);

I did that when applying.

cheers
