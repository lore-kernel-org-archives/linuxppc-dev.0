Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740AAC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 07:29:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9666103A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 07:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D9666103A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gldc63dQcz3cKk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 17:29:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JYQ/0kDX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JYQ/0kDX; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GldbM4WhLz2yXb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 17:28:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GldbJ4Kwmz9sRN;
 Thu, 12 Aug 2021 17:28:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1628753324;
 bh=HyJTfFqmFRObjIiJEFAn1BWI6SCwcu41W5r59B0/DhY=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=JYQ/0kDXr1OrQQHl4zGNJ2KdDj15nvgUU8gsWNmcJD0//gboLZX+CUOEVFXBhVdzZ
 3P3uAKvDWGd6atTxLhFDDpsE8Q8CzLTYekDnHIBMXYOsAi2whH0nFYX2SvaFJSmaaT
 Gf5C6SmbpHWiodgE2JYuj01sDxu4uSgE2uHaOYIk3ny0AGAi1+5WvfuTY7KLTVyWS7
 HyW/mLrVce2dWp6bsrB2SUuEoRSCxhznrHWAXsELwG+3PsqYjfUXs1NvdyYAYVIuCo
 DzrH3SPElVKvkLu8e8Svzex//1pRQfqaihjx3a7K4oxL2Mcu7pYovHUyJtCVNisln8
 hhGCSrrIeqtZA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/book3s64/radix: make
 tlb_single_page_flush_ceiling a debugfs entry
In-Reply-To: <22c7c194-d75d-bf90-c8e5-83c995c7130c@csgroup.eu>
References: <20210810045307.11892-1-aneesh.kumar@linux.ibm.com>
 <22c7c194-d75d-bf90-c8e5-83c995c7130c@csgroup.eu>
Date: Thu, 12 Aug 2021 17:28:41 +1000
Message-ID: <87o8a3m89i.fsf@mpe.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 10/08/2021 =C3=A0 06:53, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>> Similar to x86/s390 add a debugfs file to tune tlb_single_page_flush_cei=
ling.
>>=20
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/mm/book3s64/radix_tlb.c | 48 ++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>=20
>> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book=
3s64/radix_tlb.c
>> index aefc100d79a7..5cca0fe130e7 100644
>> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
>> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
>> @@ -17,6 +17,7 @@
...
>> +
>> +static int __init create_tlb_single_page_flush_ceiling(void)
>> +{
>> +	debugfs_create_file("tlb_single_page_flush_ceiling", S_IRUSR | S_IWUSR,
>> +			    powerpc_debugfs_root, NULL, &fops_tlbflush);
>
> Could you just use debugfs_create_u32() instead of re-implementing simple=
 read and write ?

Yeah AFAICS that should work fine.

It could probably even be a u16?

cheers
