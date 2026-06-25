Return-Path: <linuxppc-dev+bounces-22981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E25ECDE000
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:05:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmLCt6HlRz2ySW;
	Fri, 26 Jun 2026 00:04:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782396298;
	cv=none; b=SsrIzvqtFwXCrBuNza5huJVJNMSbPOX1HNz56Ddic11GgDfO44LvJIEAYAF+ZSKZ0L1OftfDts7ha9yCcpREL9//lsp1eo3FmotSszwH4IWpqFG97gHdNp94otQZRlzj1DdA4cQvhzsWPSrNW5PHodlcf/+6ommhMsSb8cBEUlsWy9NeKGDJfi8t0p3HIp36PeW/NqQjbVhGi24+p3S8ISBPtGsLn8rtycQxLGgd3c7oeMuMXAHlrXJ0fZ6jxPoW5mOGbWLt87bLq4H0T0a7pk4C5veQ71igTGOzsbSze6NEHZ7a9VJ+E4oWcZoQTuHkDRHO9p6IDiX4LbJZvVAVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782396298; c=relaxed/relaxed;
	bh=wdT6rQDcVONIEoFXNeng4/FokBuEy+7WhKmADDSqROo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DS/FRe1zrGiHnrFB+sOLD7YMrP03t+bHRIEEgx2+ybBhvInPqrVKBsyBHOlJ8CzLn2eI9Y8OCittqid8iJ4ILFTn3ibQ8+WpGroCOACT6PUxTIecPRg0KdKK2qsatJ8s0dXhFVJwfvT3GJD+6St87GrpOdGttFLEKd+0Mc6iGws2i+8d0LizyljxuYqeOdtvqmZa/x82h5KYhhD8CiIQI4QS0tlJnfC5SCGnrLt9hCDYAhC3sxn4rRraUbXJ0jS0aaZHvc+2g+QtMnyimAQvRNBPbtpTbQjUAcK4PaZNHtgvUBTo4Js4OHw5BoDwKesgaj52OIvAhBBgBoCI1GHAqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+Z4/X3Z; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+Z4/X3Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmLCr3Qrxz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 00:04:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F122E41658;
	Thu, 25 Jun 2026 14:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C671F000E9;
	Thu, 25 Jun 2026 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396292;
	bh=wdT6rQDcVONIEoFXNeng4/FokBuEy+7WhKmADDSqROo=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=A+Z4/X3ZkTXwHL2KPfDvTlJUbufQkmMwThCEDCLKrzc3my9+ilEo+HFAP9h5NDNF0
	 0S3Nh2wp79xolvwCYaOpzujaRryGSzaNISLyfWmgdZPDS8Woyq3fpTNlisSvI0A5c3
	 rKfOqcEqVnOPUoLKeDv3gaMHpErRWUCcotvofJamT2y1GK1wHcT6SB2lch8K6jJnAk
	 nlN6/PFRgTpFMhzrdrQ2edIZ017BzsILGckn/iK6KkwcMbn5vzUsNLHLWdWQBunfaB
	 CMx7snobTTvmHzETssL5ZexLzKMy3ASVay/8yT99jTb7sAcNjImmOcDnIymTZqimXM
	 KfU3lQ2jaRQOw==
Message-ID: <db3168f1-91a4-4871-a68a-cdd42b1c6ea4@kernel.org>
Date: Thu, 25 Jun 2026 16:04:48 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
 <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
 <20260616115521.79ad9699-39-amachhiw@linux.ibm.com>
 <20260625184146.6de49c63-67-amachhiw@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260625184146.6de49c63-67-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/06/2026 à 15:14, Amit Machhiwal a écrit :
> Hi Christophe,
> 
> <snip>
> 
>>>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>> index 3af6c06af02f..e5853daa6a48 100644
>>>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>> @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
>>>>    	if (isa >= ISA_V3_1) {
>>>>    		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
>>>>    		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
>>>> +
>>>> +		/*
>>>> +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
>>>> +		 * Power11 and later processors. While ISA v3.1 is supported
>>>> +		 * by Power10+, this flag specifically indicates Power11+
>>>> +		 * for code that needs to distinguish between P10 and P11.
>>>> +		 */
>>>> +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
>>>
>>> Are we sure this test will always be correct ?
>>>
>>> For instance PVR_PA6T is higher than PVR_POWER11 allthough it is not ISA 3.1
>>>
>>> Wouldn't is be cleaner and safer to just do:
>>>
>>> 	PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER11
>>
>> You're absolutely right to point out the PVR ordering concern. But PA6T
>> cannot actually reach this path because we're already gated by:
>>
>>    if (isa >= ISA_V3_1)
>>
>> and PA6T does not implement ISA v3.1.
>>
>> My rationale for using `>= PVR_POWER11` is that `CPU_FTR_P11_PVR` is
>> intended to be included for Power11 and later processors, not just
>> Power11 itself, as it identifies a CPU feature. Using `== PVR_POWER11`
>> would mean we'd need to revisit this code for every future generation.
>>
>> This approach is consistent with existing kernel code. For example, in
>> arch/powerpc/perf/hv-gpci.c:
>>
>>    /* sysinfo interface files are only available for power10 and above platforms */
>>    if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER10)
>>        add_sysinfo_interface_files();
>>
>> Also, I couldn't find any current users of `PVR_PA6T` or `PVR_BE` in the
>> kernel tree, so there doesn't appear to be a present-day ISA v3.1+
>> example where the comparison would misidentify a processor.
>>
>> Please let me know your further thoughts on this.
> 
> Just checking in — did my previous response address your concern, or do
> you have further comments?

That ok, no more comments.


Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



