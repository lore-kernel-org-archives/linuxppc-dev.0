Return-Path: <SRS0=OFQA=UG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231DDC28CC3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 07:27:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E522089E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 07:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BytiIeZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E522089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KvJ43bySzDqxc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 17:27:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BytiIeZw"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KvFq0zSWzDqv9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 17:25:50 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id n2so679081pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jun 2019 00:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=0ZFWajZqQTN/5r+PpwXzBa6wbE+kxB9A/Nr7p8k3Pxo=;
 b=BytiIeZwgeVhny+gWLqsvpeBcmAViX5altMz4zOuUbAOSWLIbImXTEflMIxmC+9E4z
 whhYRWVaq//rRtH2YAH/si0fQQHt56FwLUr+6pTUDndlM6XcVF66TNPHAYWw9Rdo8HQi
 pmEtKhvd5cXGF8igag2Od1zoi4FBj2ngEUAJrszlm9utcaTM0XL2RbrfAwXtQ78+S6vi
 GyIRtLInUHhfaJm894Cu0i0vrCA1fOt5EweIOU3+0GmSkhCK/+ibDI0kd4zsZPgVmvb0
 rtoxzuHZAooatAQ8HL/0pC94jLOoGh1/gPHoCvS8zxxDNlyCJR77DHtjVBLx3nfDzV+k
 tifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=0ZFWajZqQTN/5r+PpwXzBa6wbE+kxB9A/Nr7p8k3Pxo=;
 b=iyNHy5mT0l61Hs1/Pu3QCpXw03b2yLOuBype3tV1bKVvrtJ5l8OLNfEoGVFX8nEImD
 pqqgwImAtK8vbUWIRmG15v17/o/vskjxsvYjK8A4OXd/0F07VUBwTUSiQn3e8i/Epg3v
 /+sF795PXJjtWcHyv6fOXGwF7Lsc5ca0OhoOyDB+aDTH6jHZdb6693i5ijA5RvuMHXlr
 kQrqRcZbxSXOFt3LFgNGhwkymI8SifmDf5BHm7a1vyMXLi+7sCvZBBILgzFkpjVgy9e8
 jvuEipIESbRv6kKQypWNBKNb0xnmdzz5vhdyrexfDpjX4A70DyE8f2cdO9/lc5aah27W
 /9Xw==
X-Gm-Message-State: APjAAAVMSux/CSKvD1U7Zt5rHIrwdFVaf4lU2uswa5EqdiaPdEHq/1Vi
 /pYDnqwIWid5zUMfqZfbh5Y=
X-Google-Smtp-Source: APXvYqxopIeRPege//K2F0VyRIX5BwXwz71H8r9AndrEhhkFl2+d3IZ1bR0rb1DR5MZSb/hdAkGJ6g==
X-Received: by 2002:a63:9548:: with SMTP id t8mr1535443pgn.256.1559892347081; 
 Fri, 07 Jun 2019 00:25:47 -0700 (PDT)
Received: from localhost ([202.125.30.143])
 by smtp.gmail.com with ESMTPSA id e9sm1288686pfn.154.2019.06.07.00.25.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 00:25:46 -0700 (PDT)
Date: Fri, 07 Jun 2019 17:24:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s/radix: ioremap use huge page mappings
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
References: <20190607061922.20542-1-npiggin@gmail.com>
 <20190607061922.20542-2-npiggin@gmail.com>
 <f842646a-c9a1-61a8-9c2b-befb4d6313fa@c-s.fr>
In-Reply-To: <f842646a-c9a1-61a8-9c2b-befb4d6313fa@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1559891631.qqgo059h90.astroid@bobo.none>
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

Christophe Leroy's on June 7, 2019 4:56 pm:
>=20
>=20
> Le 07/06/2019 =C3=A0 08:19, Nicholas Piggin a =C3=A9crit=C2=A0:
>> powerpc/64s does not use ioremap_page_range, so it does not get huge
>> vmap iomap mappings automatically. The radix kernel mapping function
>> already allows larger page mappings that work with huge vmap, so wire
>> that up to allow huge pages to be used for ioremap mappings.
>=20
> Argh ... I was on the way to merge pgtable_64.c and pgtable_32.c. This=20
> will complicate the task ... Anyway this looks a good improvment.

I can put the radix code into book3s64, at least then you have less
gunk in the common code.

> Any reason to limit that to Radix ?

Just that the others don't have a page size easily exposed for their
map_kernel_page.

It would be nice to make this a bit more generic so other sub archs
can enable the larger mappings just by implementing map_kernel_page.

>=20
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/include/asm/book3s/64/pgtable.h |  8 +++
>>   arch/powerpc/mm/pgtable_64.c                 | 58 ++++++++++++++++++--
>>   include/linux/io.h                           |  1 +
>>   lib/ioremap.c                                |  2 +-
>>   4 files changed, 62 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc=
/include/asm/book3s/64/pgtable.h
>> index ccf00a8b98c6..d7a4f2d80598 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -274,6 +274,14 @@ extern unsigned long __vmalloc_end;
>>   #define VMALLOC_START	__vmalloc_start
>>   #define VMALLOC_END	__vmalloc_end
>>  =20
>> +static inline unsigned int ioremap_max_order(void)
>> +{
>> +	if (radix_enabled())
>> +		return PUD_SHIFT;
>> +	return 7 + PAGE_SHIFT; /* default from linux/vmalloc.h */
>> +}
>> +#define IOREMAP_MAX_ORDER ({ ioremap_max_order();})
>=20
> Following form doesn't work ?
>=20
> #define IOREMAP_MAX_ORDER	ioremap_max_order()

I suppose it would. I'm not sure why I did that.

>> +
>>   extern unsigned long __kernel_virt_start;
>>   extern unsigned long __kernel_virt_size;
>>   extern unsigned long __kernel_io_start;
>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>> index d2d976ff8a0e..cf02b67eee55 100644
>> --- a/arch/powerpc/mm/pgtable_64.c
>> +++ b/arch/powerpc/mm/pgtable_64.c
>> @@ -112,7 +112,7 @@ unsigned long ioremap_bot =3D IOREMAP_BASE;
>>    * __ioremap_at - Low level function to establish the page tables
>>    *                for an IO mapping
>>    */
>> -void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size=
, pgprot_t prot)
>> +static void __iomem * hash__ioremap_at(phys_addr_t pa, void *ea, unsign=
ed long size, pgprot_t prot)
>=20
> Is this the correct name ?
>=20
> As far as I understand, this function will be used by nohash/64, looks=20
> strange to call hash__something() a function used by nohash platforms.

Yeah you're right, I'll fix that.

>>   {
>>   	unsigned long i;
>>  =20
>> @@ -120,6 +120,54 @@ void __iomem *__ioremap_at(phys_addr_t pa, void *ea=
, unsigned long size, pgprot_
>>   	if (pgprot_val(prot) & H_PAGE_4K_PFN)
>>   		return NULL;
>>  =20
>> +	for (i =3D 0; i < size; i +=3D PAGE_SIZE)
>> +		if (map_kernel_page((unsigned long)ea + i, pa + i, prot))
>> +			return NULL;
>> +
>> +	return (void __iomem *)ea;
>> +}
>> +
>> +static int radix__ioremap_page_range(unsigned long addr, unsigned long =
end,
>> +		       phys_addr_t phys_addr, pgprot_t prot)
>> +{
>> +	while (addr !=3D end) {
>> +		if (unlikely(ioremap_huge_disabled))
>> +			goto use_small_page;
>=20
> I don't like too much a goto in the middle of an if/else set inside a loo=
p.
>=20
> Couldn't we have two while() loops, one for the !ioremap_huge_disabled()=20
> and one for the ioremap_huge_disabled() case ? It would duplicate some=20
> code but that's only 3 small lines.
>=20
> Or, when ioremap_huge_disabled(), couldn't it just fallback to the=20
> hash__ioremap_at() function ?

Yeah okay. I'll see how the code looks after I move it into=20
radix_pgtable.c, it might be best to keep all radix code there together
even for the disabled case.

>> +		return radix__ioremap_at(pa, ea, size, prot);
>> +	return hash__ioremap_at(pa, ea, size, prot);
>=20
> Can't we just leave the no radix stuff here instead of making that=20
> hash__ioremap_at() function ?

Yeah that'll probably work better.

Thanks,
Nick

=
