Return-Path: <linuxppc-dev+bounces-29022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2ACCA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 05:33:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0dvd4Y34z308H;
	Thu, 08 Oct 2026 16:33:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791437629;
	cv=none; b=lmM7uaT6a2fqope82EWwUS7JMtRSIXCFERNM1kPG8OYhTqk+0NuJwDB3MOHVMsHiVnjk1oktuBFtTwfEPQu7hdoMPOPGhFnI4vRmf2UcQje7P6Onb97xWRe7+MFcpmL7lmauEh6owxSoTqpiZt+MdFWZo8eh2CXXNAGI+/JX7LLKPgWf5L9md/BvCEdUYqoYo1HA1wcOadC8skLUU2eZwDt5RpAEjqkMsrZgeNaSePVCUJq80c/lMie1uyaS/rM9/ldV0niaH6y4PMmzC9bhZVn54uCPU9xoYWBcU0XuCGv5j3UwTnafBNBdeEHRQnrDXUWGsI/mSk3ZvO4+gMIXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791437629; c=relaxed/relaxed;
	bh=DiCB3zTU35Q/So7+8YpTI1O1VNazQCwPsoCqXsbVCxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1fRShwoK5L+oL8QHhR5v3GHTW+Jr01fkjHnDEkeHnku1RLH6pCLl3GkQffx881MMeUuAfG6AvwYHWC3s0h4sX6vLlPvDK8nvctOgA8A6Br+UwzMSNt06bNHbhSpHz9gSDZjn188jjVPCCbW8gD4zl9kMdxtzyA2jLXrNOBUXHfBSShYV6WLMaCvyvHY+x3jHWEo/vhgNPohh/kYiHtodPXdVQnpIW0h3ZEioeBEyXRjmsbz0f+RZd2fQcTUuONbDcHJOi3NvLZGnAx8dJV453osBLqSqxgxoQQBBqg2SLPl8Pmw4NNptM1YWrdmQ2oiURA7uT9aqxJON15bjnmKDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlFvX1x1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlFvX1x1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0dvc2kPRz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 16:33:48 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C069A60252;
	Thu,  8 Oct 2026 05:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBD61F000FF;
	Thu,  8 Oct 2026 05:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437624;
	bh=DiCB3zTU35Q/So7+8YpTI1O1VNazQCwPsoCqXsbVCxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MlFvX1x1UhWZRY1blp5vdgZEPOMCBXQinqSZI84kOfHvYoEphDSM4c94C8k0YCneZ
	 +CvWpN13IHO40ySHjg36SGLM6p3x45bPMR627QwPtHEOxGz1S8+sT5TicHHAqfnwbg
	 bqFKdwKME2OoCRwQAo2p4meLpit9e42WrSXDC9nPxddpD1ycCgJPlJjEd5pDoDOqWs
	 ennUOXzrVpLk3Kqhf1z0mNeMc81DduJcnqdwFkPFglVDZ80bS0a6JisTfrcpB+qHEQ
	 B2B7dFO8dNiI2LLj/G2xvndmsNBdA4U85+1Ksxk77R/C0BzNaKttWJhMVtqisJgUfF
	 7H/HlTSl2Xjzw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <yq5awlrt3dwo.fsf@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
Date: Thu, 08 Oct 2026 11:03:27 +0530
Message-ID: <yq5av77c92oo.fsf@kernel.org>
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

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Will Deacon <will@kernel.org> writes:
>
>> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>>> > >  	if (swiotlb_force_disable)
>>> > >  		return SWIOTLB_POOL_NONE;
>>> > >  
>>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>> > > +	    !restricted_dma_pool_present)
>>> > >  		return SWIOTLB_POOL_CC_GUEST;
>>> > 
>>> > I think this check on the restricted DMA pool is too general -- the pool
>>> > could be tied to a specific DMA-capable peripheral and so treating its
>>> > presence as a global property isn't right.
>>> 
>>> I agree it's a hack but that was the simplest way to avoid the pVMs
>>> getting a bounce buffer after this patch. More than happy to leave it
>>> out and reduce the buffer on cmdline or we come up with some better
>>> heuristics.
>>
>> Hrm, that does mean that reverting just this part will regress pVMs
>> because they'll suddenly be allocating a tonne more memory for an
>> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>> series until this has been worked out properly.
>>
>>> Another option could be the arch code passing another flag that it
>>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>>> don't particularly this either. The arch code doesn't know whether
>>> there's an alternative pool.
>>
>> At that point, the default size may as well be driven by the
>> drivers/virt/coco driver.
>>
>>> That said, such heuristics should have been a separate patch to make it
>>> easier to review/drop.
>>
>> I think the only right way to get a semi-accurate heuristic is to take
>> into account the set of dma-capable devices that will use the swiotlb
>> pool, but that's fiddly and should probably be tackled as a separate
>> series. Maybe a simpler hack in that direction would be to take the
>> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
>> run into the usual problem of not being able to tell if a device is
>> DMA-capable or not, but you could probably look for a global restricted
>> DMA pool and, if that doesn't exist, check for per-device restricted pools
>> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
>> a reasonable approximation.
>
> So, something like this?
>
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> 	    swiotlb_cc_guest_needs_default_pool())
> 		return SWIOTLB_POOL_CC_GUEST;
>

Detecting a DMA-capable device is not straightforward, and if we get it
wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
code below be a reasonable approximation of what you suggested?

Another option would be to make swiotlb_cc_guest_needs_default_pool() a
weak function that architectures can override. arm64 pKVM could then use
a different scheme (for this patch series default to false). Would that
be preferable?

#ifdef CONFIG_DMA_RESTRICTED_POOL
static bool __init swiotlb_of_dma_candidate(struct device_node *np)
{
	struct device_node *node __free(device_node) = of_node_get(np);

	/*
	 * Ignore nodes that don't have compatible and reg property
	 * So we don't wrongly consider a node as device node.
	 */
	if (!of_property_present(np, "compatible") ||
	    !of_property_present(np, "reg"))
		return false;

	while (node) {
		if (!of_device_is_available(node))
			return false;
		/*
		 * Ignore reserved-memory nodes because that have compatible
		 * and reg property
		 */
		if (node->parent == of_root &&
		    of_node_name_eq(node, "reserved-memory"))
			return false;
		node = of_get_next_parent(node);
	}
	return of_dma_is_coherent(np);
}

static bool __init swiotlb_of_dma_needs_default_pool(struct device_node *np)
{
	if (!of_dma_get_restricted_pool(np))
		return true;

	return false;
}
#endif

static bool __init swiotlb_cc_guest_needs_default_pool(void)
{
#ifdef CONFIG_DMA_RESTRICTED_POOL
	struct device_node *np;
	bool found = false;

	if (!of_root)
		return true;
	/*
	 * DMA capability is not explicitly described for every DT device.
	 * Use coherent, addressed device nodes as an approximation, and keep
	 * guest sizing unless every candidate has an initialized restricted
	 * pool.
	 */
	for_each_of_allnodes(np) {
		if (!swiotlb_of_dma_candidate(np))
			continue;
		found = true;
		if (swiotlb_of_dma_needs_default_pool(np))
			return true;
	}

	return !found;
#else
	return true;
#endif
}

