Return-Path: <linuxppc-dev+bounces-17091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3A0EFB810
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:18:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKpwT4WgQz3cHC;
	Tue, 24 Feb 2026 18:18:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771917497;
	cv=none; b=BMlHnbCXyQIKXSh9h+JcN4blI1z/zqu+w3B5kBrZGmeYCxLYvi1cGLoWieojrKjupVz4VnFBbaiAO0hGa1e2iqFy1a+KBOC53/4sVGYYf7JQus8bvwNlxMucNcyCmS3dlQK42xR91DfCf7YpfETfwmN3xRUG74ph3Kt9BDs/0QUvRR3ix07H3SI0QCDjZJESkN0ytCxkj1kMRMUexbRBwwTCFpRFE+Q5nAt7prBRfOHmGkqDJbfAvGx3zFSvzktj+zGi4REntx4PGF+PpJyeAsFRba6wfqsL+5n+bBF/GBcsapmI1Hr5s1wn7WGEKqNKVetFjMANeyA5ZhKS7B2svA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771917497; c=relaxed/relaxed;
	bh=3zHVGAA+yyd3tSp5AUopl6dvpB3kziV17V+X5UhQ2MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIaobdl0wpxMdw7PX06EP9sOGivvN+l7eZKc9Hz0UdO+hvq42A/MYvggEqbZ4y4BNMV5Sh3Dg54mAdYy1JFA8QjUOcy2w9AyqODJM9Z518MgEeNs+DYsiz+JIj8IV8kIxDPdgvpfHYQ4pInOmGUooznbc0Wc0OTGpLP6icXQNqXDSjETUxAdG87YNm+TxHJtS5WesqPZz1doEAmXJ0fifXWn84tSdckVYLdG7p4/NkCTxap9zMuYPEbjit6iq7BFd+Z1bAN7wuLq8gxTcGQNydw5Wd/Enn+fpiglWjzVW90fQsnLh0bFXpZWkDKCrFHSr8HXrOgv5AL9qejjRcIGXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZERwORHW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZERwORHW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKpwS3kWyz3cH3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 18:18:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 664DB600C4;
	Tue, 24 Feb 2026 07:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0BFC116D0;
	Tue, 24 Feb 2026 07:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771917494;
	bh=lMm1oD5G7L5rP2M+Zc8Py4GZ6/EXDoOEdcunzvDRvMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZERwORHWDEksq3P1UASQwTIHjz3IedMxJ8rPZ7fa2RxQ1KfSH5ltypmV7EamU1uhx
	 4i/qbdzJ/uEu0aIO+g018YTz2+yUYCGZ/+mClXReUo2xgE83YsJxayhC1G45qZvDMt
	 EECOW4eY+ZMr0NHUBjMM+yYU1hZqcFfZ8cYDiHlaVRYQ4C8BfR0wOiYOYIM+zKgvcr
	 PWQ3R1+XBw2hHVdYEAUHiZCvaoHQQBolHxx+umIz5uWSNe9zSraDn+Xw1M/L//h+jz
	 w/aWSesIjggxUZrzqRhjeQtClxxwfqWPcARXxlEDI58M6h7JaG0GqWYWiZWPKrTasq
	 RFsTEJfeYaEyQ==
Message-ID: <4ca27c17-cbc5-464d-87d0-2cc02d629fcf@kernel.org>
Date: Tue, 24 Feb 2026 08:18:03 +0100
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
Subject: Re: [Linux PPC] 7.0-rc1: e500_mmu.c:923:26: error: assignment to
 'struct tlbe_priv *' from incompatible pointer type 'struct tlbe_ref *'
To: Kees Cook <kees@kernel.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "R.T.Dickinson"
 <rtd2@xtra.co.nz>, hypexed@yahoo.com.au, mad skateman
 <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <709b864f-9daa-4a48-b3d6-39baedce63b2@linux.ibm.com>
 <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <caeed62f-0e36-4868-e593-887d7f33ce50@xenosoft.de>
 <d0342f0e-633f-4299-966a-27e4c0050da3@linux.ibm.com>
 <2cbd1e19-ac99-29c3-ab89-3c58a9863e5a@xenosoft.de>
 <2d2d4735-04e0-46a0-93c6-654507fe2ae1@kernel.org>
 <2536c3e7-18d2-47cb-88c6-36f94c61c1c6@kernel.org>
 <202602231439.FFDA50B@keescook>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <202602231439.FFDA50B@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/02/2026 à 23:40, Kees Cook a écrit :
> On Mon, Feb 23, 2026 at 08:38:29PM +0100, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 23/02/2026 à 19:07, Christophe Leroy (CS GROUP) a écrit :
>>> +Kees
>>>
>>> Hello,
>>>
>>> Le 23/02/2026 à 17:48, Christian Zigotzky a écrit :
>>>> Hello,
>>>>
>>>> Compiling issue for e5500 machines for the RC1 of kernel 7.0:
>>>>
>>>> arch/powerpc/kvm/e500_mmu.c: In function 'kvmppc_e500_tlb_init':
>>>> arch/powerpc/kvm/e500_mmu.c:923:26: error: assignment to 'struct
>>>> tlbe_priv *' from incompatible pointer type 'struct tlbe_ref *' [-
>>>> Werror=incompatible-pointer-types]
>>>>     923 |  vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_ref,
>>>>         |                          ^
>>>> arch/powerpc/kvm/e500_mmu.c:928:26: error: assignment to 'struct
>>>> tlbe_priv *' from incompatible pointer type 'struct tlbe_ref *' [-
>>>> Werror=incompatible-pointer-types]
>>>>     928 |  vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_ref,
>>>>
>>>> Temporary solution: # CONFIG_VIRTUALIZATION is not set
>>>>
>>>> Please solve this issue.
>>>>
>>>
>>> Must be one of:
>>>
>>> 189f164e573e Convert remaining multi-line kmalloc_obj/flex GFP_KERNEL uses
>>> bf4afc53b77a Convert 'alloc_obj' family to use the new default
>>> GFP_KERNEL argument
>>> 69050f8d6d07 treewide: Replace kmalloc with kmalloc_obj for non-scalar
>>> types
>>>
>>
>> Can you try following change:
>>
>> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
>> index 48580c85f23b..75ed1496ead5 100644
>> --- a/arch/powerpc/kvm/e500_mmu.c
>> +++ b/arch/powerpc/kvm/e500_mmu.c
>> @@ -920,12 +920,12 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500
>> *vcpu_e500)
>>   	vcpu_e500->gtlb_offset[0] = 0;
>>   	vcpu_e500->gtlb_offset[1] = KVM_E500_TLB0_SIZE;
>>
>> -	vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_ref,
>> +	vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_priv,
>>   					       vcpu_e500->gtlb_params[0].entries);
>>   	if (!vcpu_e500->gtlb_priv[0])
>>   		goto free_vcpu;
>>
>> -	vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_ref,
>> +	vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_priv,
>>   					       vcpu_e500->gtlb_params[1].entries);
>>   	if (!vcpu_e500->gtlb_priv[1])
>>   		goto free_vcpu;
> 
> That looks like the correct fix to me. The old type was the correct size,
> but was just the wrong type. Sorry I missed it when doing my tree-wide
> multi-arch builds! What build target (or Kconfig) was needed to reach
> this code?

I used ppc64e_defconfig + CONFIG_VIRTUALIZATION=y
+ CONFIG_KVM_E500MC=y


> 
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Reviewed-by: Kees Cook <kees@kernel.org>
> 
> Thanks!
> 


