Return-Path: <linuxppc-dev+bounces-29056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48118CA600E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 11:42:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0p5Y33DMz2xwd;
	Thu, 08 Oct 2026 22:42:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791459777;
	cv=none; b=kMkLADJzRjv56FpN1AtikKNOFiOmay5jeuFt1Y9TDMZe7RLte/pU7hVZs6o2U27ZbKIuV7i/fOUDgzZtzVfFkNLT+zAL6McZ8+vdl2bWWo3DE7+8aDwfBS2/0Cr9XBb5d5Q10V/HBaLlhNkrxgogXrsZPHSIx3WBMMcquZ5ZMmMkIGNAT96MCFZqKLZsnMC3Qg7kJS49qQ6/mdT8ieNKXw2S/0WdV9qNyHz8CQafUdcUOy6G52LjvY/JofrEuoVIMkW5rJB9i26Ja+bsnC64xBN5U+kBvtM/+EuJeQTqBD3kluoZI5BHBCu/wgUenmb2TuABiDRUj3wYfusvrjCStA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791459777; c=relaxed/relaxed;
	bh=4xI6sjx5O7jgHs+vd9dc55iUHxFgkYDVUp/hXBLdiUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HhFZHgK9HXaCbg5RhjLUBasnheLhnRBHL43rXH0TQDwzFrZ9MxSi5bXUT8Anz9BddrD+NYKE1ZouUgOqWCOAjhNoyPnCaW7SpGCso8UfDltV4xeyH0Q19sEuamRlHAEVf2/p4pgSNC2Cb0RyzxZORJwHNcA4A1kugfIJd5K/k69jSnIjRdZruhKt6W64FL3rKX4R/h/taKishrnEc17eK7GAGIYY4PzcaeszbM5+lFOaSzYRKTl41j8Hb3nqLAPk5IWHQa/nfXqTIn8v5nhHD9KraNcHVs/iwNQ2MudOUrkkmTJnuGeF/AhfFPYU8STRiSO+v90BZzOfsYLave+Hjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiFIMNPQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiFIMNPQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0p5X2y5Mz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 22:42:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 54FCA601F9;
	Thu,  8 Oct 2026 11:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B91F000FF;
	Thu,  8 Oct 2026 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791459772;
	bh=4xI6sjx5O7jgHs+vd9dc55iUHxFgkYDVUp/hXBLdiUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YiFIMNPQLdCE2zbWLTULNFqt7kb5t3ajFyu/BuSQuH9LkL3xA+iVywarHowzdzA+7
	 1sou/7jke+Vj+nbmlqBC7VTbQKzq6IDlT13spt+uePeZIZSDvImU4X8lzs7M9MWkgQ
	 ufVjTQQcUB+9Uhuptv8x1rTJ2ng7aURxLQAwDcN+KUP9pnq+WBBmHpWri6CQgA1FJo
	 gjdV83W7dro0R18RTq0UUSD0nA6cozVVgRHk/IvB8xAFneymfmMfAbHLzncbeqt7T5
	 QuvxlpKgQFLXt52Ywqwn3oQGPELoMic1DSF4KHV61Y6N7B50K7oD5nmWN42IdAkaMz
	 Pd2ocvIJj9mQw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
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
In-Reply-To: <bc0fdf46-eaf6-49b9-a015-1742c66829a6@samsung.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <CGME20261007104325eucas1p2277d74db794e285f33038204d52dc843@eucas1p2.samsung.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <bc0fdf46-eaf6-49b9-a015-1742c66829a6@samsung.com>
Date: Thu, 08 Oct 2026 17:12:28 +0530
Message-ID: <yq5ase2g8lln.fsf@kernel.org>
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

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 07.10.2026 12:43, Will Deacon wrote:
>> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>>>> On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>>> @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>>>>>  	if (swiotlb_force_disable)
>>>>>  		return SWIOTLB_POOL_NONE;
>>>>>  
>>>>> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>>>> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>>>> +	    !restricted_dma_pool_present)
>>>>>  		return SWIOTLB_POOL_CC_GUEST;
>>>> I think this check on the restricted DMA pool is too general -- the pool
>>>> could be tied to a specific DMA-capable peripheral and so treating its
>>>> presence as a global property isn't right.
>>> I agree it's a hack but that was the simplest way to avoid the pVMs
>>> getting a bounce buffer after this patch. More than happy to leave it
>>> out and reduce the buffer on cmdline or we come up with some better
>>> heuristics.
>> Hrm, that does mean that reverting just this part will regress pVMs
>> because they'll suddenly be allocating a tonne more memory for an
>> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>> series until this has been worked out properly.
> I've dropped the entire series from dma-mapping-for-next. Aneesh, please respin
> it again and move the pKVM/restricted_dma_pool related code into the separate
> patch.
>

Once we agree on the correct way to detect the pKVM use case, I will
resend the series.

-aneesh

