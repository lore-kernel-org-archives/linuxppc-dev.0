Return-Path: <linuxppc-dev+bounces-17688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD14EB7EB2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 08:56:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQmjZ5Hnfz30hq;
	Wed, 04 Mar 2026 19:56:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772614562;
	cv=none; b=MJ5umKVUZSth2MSaT1HTQmBgrOMPi5QWzg+qcXxOxcyM4C+jQ3x/mn+bm04QbRHRpPq2lSeyCqHz2O4aSbf2WHZUVCvryOUs4SnXiHI2bwI+3GWv8ICwrHJALArcUbTI9VK1FJ9ItTmmfkiZKJsORn2YStr7SAm2eC56Jd5uX+/rAjtCGu5b/bOyp8lLjD0E36lqAXzxJVneUD4QkrSoUBvmcR+obr/1ygvtz252bg+QVQEmi6EHkF6yD+9lnTebS4Xtv20HcsTI7Fb+9rIM9ElrN397hZlYNSjTOAPDpInb9GuAWdKEcvsHjZmWAUGQryyQy4uIVS3+WEGer8e0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772614562; c=relaxed/relaxed;
	bh=k+QXxKchr9LYeZChUjeSNxKu29zjd0jIURMpqmqBzLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1N0lTMDyuWXalIbLuvzbGnk/qP/UI6w3gwbNwh4BPW/su1rzRfW0xuXxNbZ3cmu/kp5CtolYnhDL9yPMqJKwUWg7nQMvhBDOQQbxvJwahdyMkqccFDuC5/VKdtrAaXjeH1BHM/cXt7rxYg7o4ByubHPUjzhiaPpkmUwHpuQFsoXRxZRTB7chDtYPTjTgYE5nhXcj37ojTXJToz473kZ3SyGjMjYW6JBc5quuz81AyFqb4dZUQeCZklNBqPC6uusmXsDbcOw/iRWTZUmXc/vF5mpdUTFsmEHGEmI1reFqUCm2f3mwDcn5+8IFrnfIwjHqHM8yZKnzr0jdx98OfRdUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mde5z9it; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mde5z9it;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQmjY6k5Yz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 19:56:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F1C8660097;
	Wed,  4 Mar 2026 08:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB666C19423;
	Wed,  4 Mar 2026 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772614559;
	bh=kFiPfWO1NT8w3v/5flLCwXiQ7b1wqjZeClR10RJf5cU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mde5z9ityG6/gNVDbimVo9o99JOfqaDn/OjU7AyTF3GTRDphbmwKslQ+QbBqErz3A
	 KEq5GnxhjhoFCuLf2GTL48uBEsU8MEoq9u23fNeCGXxedsRjrJi7dYj77CHKob4Lo0
	 T8eGRmDI7cfAbJnZTHQf18ETvQuNkX4NYONhMtqHFSh2XhXkXWs0UcPWu7hi8qJRat
	 YZHmJWnbqtoN5CQ43fBwIPQ9auISIlajP+4rzsFiW+6LxGWUmmcwowou7O2wrseSxX
	 6y9IJwnirSwFmERWCwnTJn6D4a1oH6a/VZGkfniCfz26JJupmKaUaBw51V1v1ITbY8
	 CaWMxGDFw7/lw==
Message-ID: <b60846c0-bbeb-409f-ac3b-cac7f61469d5@kernel.org>
Date: Wed, 4 Mar 2026 09:55:56 +0100
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
Subject: Re: [RFC v1 04/10] powerpc/64s/tlbflush-radix: Remove unused
 radix__flush_tlb_pwc()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1772013273.git.ritesh.list@gmail.com>
 <efb8f299f33659fe07697a038138eb5760c78707.1772013273.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <efb8f299f33659fe07697a038138eb5760c78707.1772013273.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/02/2026 à 12:04, Ritesh Harjani (IBM) a écrit :
> Commit 52162ec784fa
> ("powerpc/mm/book3s64/radix: Use freed_tables instead of need_flush_all")
> removed radix__flush_tlb_pwc() definition, but missed to remove the extern
> declaration. This patch removes it.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/book3s/64/tlbflush-radix.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index a38542259fab..de9b96660582 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -92,7 +92,6 @@ extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmad
>   #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
>   #define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
>   #endif
> -extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
>   extern void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr);
>   extern void radix__flush_tlb_all(void);
>   


