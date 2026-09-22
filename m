Return-Path: <linuxppc-dev+bounces-27888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E132C982FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 05:42:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpprs3slYz2ygK;
	Tue, 22 Sep 2026 15:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790055741;
	cv=none; b=ddA+100CqnEQabqyH5MBk+X4AI0ypD254ShGTfpPgDyXGLSgiFU6ecVlDn064aYID1CLUkUCdcnmhlZxEyxnZUD9s2JSBzjnea/CjqauIg5mW0y33T/visFPylagnZzJLmIzZhnQaCksl9dIXyyTvure71o57x4QZWfUMxlybNI2tv1NsJikiRgGEvIFoNPvTT7vTOdrLhsI6BHUzWA4ptGZqPIWiLD/zE21P+MW1ivvPXuBw5XwocWW4XfkvTqjLuFtXfZlyD1kY7MKH/8MzxLBaxZ7EbnHWh+Xes0CICxojG/VKoAFmrBflO7Kl50/C0bVslT/1I82/NyUf9PNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790055741; c=relaxed/relaxed;
	bh=3epzgFAGTIrwRdhpNfOPzvquVJOf1jbVVt83Gylxrw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReXHp76OHBeA5MxrlPfm24Gh7fJuMQ7e4LGiNk4GsIaJ8Mjn4aSXg1oRaR4+jk7yJZAXJEU7TDwm17vTXwdMbT2YQts6uAIgdin/3Lah8Rz/RPbVjXh1JLycmmPMvfH+Gw3QFan8BO5XI6dv9bW7FWLztIrKWbbt212TB0HCLRr1saIulY6Qgehi9TQaha2ptYpFme2tnUHX/OyH+9VOoalBAIvQi/oSyAJiRvztlSUhOtolAyaRBVPW/kg6byciDAwbrcRN3Dt80dza3zC9pTbVdjXGcwMzXCOAkkjVZ8pYYJorKv2FdATRB3rgsGq7GIQtCnsqWYleij6WZMxbrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3cAyn/R; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3cAyn/R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpprr5D1sz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 15:42:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DD7F8437C2;
	Tue, 22 Sep 2026 05:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943B51F000FF;
	Tue, 22 Sep 2026 05:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790055737;
	bh=3epzgFAGTIrwRdhpNfOPzvquVJOf1jbVVt83Gylxrw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n3cAyn/RCRCO8X+Uau1YjXbZxv8R3e4DCS+Xrx4rxCRgSj1hcmaLfTbRORYJw1hgq
	 Cdw8d9qTesIZG96UD++KmUGKR0DtVp8Km9oejn5XjuarV7G50P0Egv95jNovWg5nHx
	 9biemEsqA2QDkJEW6YxDns/Fcj6SeGFmgfINJQBFXMauH1rC7qKLOGGgJDa1ksYZVv
	 F4bBFg9Uu6vXcF5kxVU5L5bwk4e2hX2UdCkTsGD76gFExoimfyeuDNQ9fxDXt/f2f3
	 LrIkgC9XUMg3K6ZpKCyfWYLJRw6k5gX7a/F2+K9SqAsZpSXf2NYCDRauBSvMK89oLc
	 6F8UvRtFunsPg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was
 explicitly set
In-Reply-To: <94630348-d295-4424-9f6c-0dc3b8704077@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-3-aneesh.kumar@kernel.org>
 <94630348-d295-4424-9f6c-0dc3b8704077@arm.com>
Date: Tue, 22 Sep 2026 11:12:01 +0530
Message-ID: <yq5ase313kra.fsf@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
>> swiotlb_adjust_size() must not override a pool size supplied through the
>> swiotlb= command-line parameter.
>> 
>> Currently, it determines whether a size was supplied by comparing
>> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
>> explicitly requests the compiled-in default size, allowing the request
>> to be overwritten by automatic pool sizing.
>> 
>> Record whether swiotlb= supplied a numeric size and add
>> swiotlb_default_size_changed() to query that state.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   kernel/dma/swiotlb.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index aa19e81ae544..8f86deb25be2 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -107,6 +107,7 @@ static struct io_tlb_mem io_tlb_default_mem;
>>   
>>   static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
>>   static unsigned long default_nareas;
>> +static bool swiotlb_size_set __initdata;
>
> Nit: there are various ways and reasons that the size is set in general; 
> could this please be named something clearer, e.g. 
> "swiotlb_cmdline_size_set"?
>
>>   /**
>>    * struct io_tlb_area - IO TLB memory area descriptor
>> @@ -269,6 +270,7 @@ setup_io_tlb_npages(char *str)
>>   		/* avoid tail segment of size < IO_TLB_SEGSIZE */
>>   		default_nslabs =
>>   			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
>> +		swiotlb_size_set = true;
>>   	}
>>   	if (*str == ',')
>>   		++str;
>> @@ -304,6 +306,11 @@ unsigned long swiotlb_size_or_default(void)
>>   	return default_nslabs << IO_TLB_SHIFT;
>>   }
>>   
>> +static bool __init swiotlb_default_size_changed(void)
>
> ...and then do we really need a trivial wrapper function with the exact 
> same scope as the variable itself? (Plus the name is similarly confusing 
> as the places this is used are themselves potentially changing the 
> default size, if you consider "default" to mean "not explicitly 
> specified"...)
>
> With the naming improved,
>

Updated and dropped the helper.

>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>


-aneesh

