Return-Path: <SRS0=XY74=AY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E503C433E3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 12:49:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3022072D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 12:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iRC9Mn8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3022072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B53Q05SbNzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 22:49:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B53Mg5B88zDqPW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2020 22:47:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=iRC9Mn8r; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B53Mg1vRjz9sRN;
 Mon, 13 Jul 2020 22:47:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594644463;
 bh=4CKsWuiBPJBOzKqpukt4bEngtPWmeNtH4nNt+73KyKI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=iRC9Mn8rBEj7LitJg8V0gOl7UtgCNt5ZX+1y5zJIJxEmfkfTfEXVc1xs9cXT74hd+
 Dl2wV5Czp9UuWu1qGFVaem9RUOvqVF3mD/l/e//ivUq7Bac0eL6xUnMHmBVJt5Ltnp
 bNGLE/jMqOietC1Z406RH20XcVqHvy7gAzSbDb7gwdXQvWhU8KGUrSrV3n8ZA6/V2q
 72jNEVmcm3DtF2ph94yvIaxl0Rw6zyweW8lYgPNEoxdcaJwCnYPiUtrIQGDXskG//f
 l+k0XlQ7vur81zM7UbTQgtV0UUEzG0thknGrZr6o7TV5TqzgMVhgV+0xI133MC7sl7
 UBgoMkNiEB5gQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/10] powerpc/perf: Add support for ISA3.1 PMU SPRs
In-Reply-To: <DF000FF6-EF09-4299-A4AD-EF76277A6EF4@linux.vnet.ibm.com>
References: <1593595262-1433-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1593595262-1433-2-git-send-email-atrajeev@linux.vnet.ibm.com>
 <874kqi46cg.fsf@mpe.ellerman.id.au>
 <DF000FF6-EF09-4299-A4AD-EF76277A6EF4@linux.vnet.ibm.com>
Date: Mon, 13 Jul 2020 22:50:05 +1000
Message-ID: <87mu43vate.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Michael Neuling <mikey@neuling.org>, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
>> On 08-Jul-2020, at 4:32 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> 
>> Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
>> ...
>>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>>> index cd6a742..5c64bd3 100644
>>> --- a/arch/powerpc/perf/core-book3s.c
>>> +++ b/arch/powerpc/perf/core-book3s.c
>>> @@ -39,10 +39,10 @@ struct cpu_hw_events {
>>> 	unsigned int flags[MAX_HWEVENTS];
>>> 	/*
>>> 	 * The order of the MMCR array is:
>>> -	 *  - 64-bit, MMCR0, MMCR1, MMCRA, MMCR2
>>> +	 *  - 64-bit, MMCR0, MMCR1, MMCRA, MMCR2, MMCR3
>>> 	 *  - 32-bit, MMCR0, MMCR1, MMCR2
>>> 	 */
>>> -	unsigned long mmcr[4];
>>> +	unsigned long mmcr[5];
>>> 	struct perf_event *limited_counter[MAX_LIMITED_HWCOUNTERS];
>>> 	u8  limited_hwidx[MAX_LIMITED_HWCOUNTERS];
>>> 	u64 alternatives[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
>> ...
>>> @@ -1310,6 +1326,10 @@ static void power_pmu_enable(struct pmu *pmu)
>>> 	if (!cpuhw->n_added) {
>>> 		mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
>>> 		mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
>>> +#ifdef CONFIG_PPC64
>>> +		if (ppmu->flags & PPMU_ARCH_310S)
>>> +			mtspr(SPRN_MMCR3, cpuhw->mmcr[4]);
>>> +#endif /* CONFIG_PPC64 */
>>> 		goto out_enable;
>>> 	}
>>> 
>>> @@ -1353,6 +1373,11 @@ static void power_pmu_enable(struct pmu *pmu)
>>> 	if (ppmu->flags & PPMU_ARCH_207S)
>>> 		mtspr(SPRN_MMCR2, cpuhw->mmcr[3]);
>>> 
>>> +#ifdef CONFIG_PPC64
>>> +	if (ppmu->flags & PPMU_ARCH_310S)
>>> +		mtspr(SPRN_MMCR3, cpuhw->mmcr[4]);
>>> +#endif /* CONFIG_PPC64 */
>> 
>> I don't think you need the #ifdef CONFIG_PPC64?
>
> Hi Michael
>
> Thanks for reviewing this series.
>
> SPRN_MMCR3 is not defined for PPC32 and we hit build failure for pmac32_defconfig.
> The #ifdef CONFIG_PPC64 is to address this.

We like to avoid #ifdefs in the body of the code like that.

There's a bunch of existing #defines near the top of the file to make
32-bit work, I think you should just add another for this, so eg:

#ifdef CONFIG_PPC32
...
#define SPRN_MMCR3	0

cheers
