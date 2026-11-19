Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC815606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkngT6hu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVgyD3P9Gz2xL4;
	Fri, 20 Nov 2026 01:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795098980;
	cv=none; b=OgjitZJszaeP6logFDwCH/ExSmLqBSFMl3QdDJuDFPAc4PHRWS+v6tf7iTGSVH/MtY3cYpkMOrXa6C+gFjLfqBCDTcdMdc8YLh4uAaBjqEyORw2JPKd2a3ovX3SZ9pghjSVo+wlvMS2BgRBsz6YlKDbhYYNqko4KfjIKzzraK5zLsxlE5aclYKvdWD2PYX6JPI3L26q/Jv85wz1jwZLU3pr39axbJqF02DcXsCXQYdxSGaxYbNttU02rMzP+EVJY+SvvQsau2TtJFB+WgPjFIN3/AmfSAJlc27/PB6jc7PvrnVaInPotH3EUVOjnznvq3aFc8V3mm6Y6j1DJOtUvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795098980; c=relaxed/relaxed;
	bh=VnF6ja6VhKpFTfNVvE3jU57UL6Hk22nBfY4kDDWDjbs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=eA0xRagWNsDxS806zCz06Tfq8ly4GYu1QjUSmfzXXqNEyAWmDFFIiYc8dssh9rKkfM1XjzzxziFo2k/brnuSQZUuUd+Ka9RQOaGk/5cIwN7TcsiMzJ7VMcbMawacQm4Z02By+NfMJ9O+rw1dZkkrrs5JviiwP1BwhOW7+dZS9vFkElFpQuWtqQxrog/GeUH/TUAB/RIAFHpKyXBH81a5Ot2klmmuqUA78nry58yL98ddODwcNKpPWzIbC03uyOI0lAm8ceCL2tf6zhTZcnVGiqf9QK6npIgsKX/aHGjq9SmyAGSain3ZamdieIQCle31tS15rClKIYuyYfrRfUWkzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkngT6hu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkngT6hu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVgyC0z7lz2xL1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 01:36:18 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1204000a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795098976; x=1795703776; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnF6ja6VhKpFTfNVvE3jU57UL6Hk22nBfY4kDDWDjbs=;
        b=tkngT6hu7PR5bhbGovG3FMF+ZhHwGMA8MqBOjflH8AF698CqOc6okSw93eg9jk3NOR
         Rb57gKdZDMoQ+BP88idU5w0jYkKQKMU0TG0rGV+jhLn3iYh9ruzlHsS6VsBZ0/Nei+2y
         e3O7Qxlm36bmAxRpgl+iFsalQsLPrxloEhX3VKccHaD1rKiEGNR9gpxLoOQMxPANDcOG
         jK7kdcrmr0/n0shsXAWRsbyCX4xaHm0MueN5dqhds8iP5pcQt+ivCa7EnnTtlof8WWw3
         ve09iOKs23IWRLTuBxwdo8eGOQ8oLIYtTSLhEg6QIZAlgj3bk/DAC+k5m4ypZQQivSel
         w03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098976; x=1795703776;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnF6ja6VhKpFTfNVvE3jU57UL6Hk22nBfY4kDDWDjbs=;
        b=JlE1PrTwOzaYTEfcnKi/wsgke1rtYq0rwWbP3ceCOmIpAkBphI+3naZ8SZKEpLAY+8
         SBrOj20gw5DEF1rppYo79dP86/NoNCE7c+H4fz7aH1Bi04NOq4dAanWjepnLe0g+ikQF
         1i68SJ5oMhewPWKsvDbf8DLvbAZvlq3vCncQei5oqlifqJTXEY3PMjjmwjVg2pqew/Ej
         NfDLnj0gEu6MhOhVV6SUv++b2+OlMg08GM7yArJ8frswXi6C1Y329+D5NueT12zxrdlM
         RkDcpnDAU330rwKFJSNkdpnAH4AUxLY6LyfAcnK41OaMmc1fA45e+CeBFj0wR7k02y3n
         EuGA==
X-Forwarded-Encrypted: i=1; AL+hErEiCsxpS57EKncLtvKKkiT+cGUInpLHgQMcFwfNHuuT0Zo5X7Gwqt2erHT5bJiQ65xbNYMiYmwa61ZHQOs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8UGlWM9w7LBHBM0+dMkoyz11l/L2+BVOQ3VYw/KxXJbAk02JP9
	I1SurHv9oB2MBQtvdlBwpFIe2KrBrBoC4A1qpLXHTV/mIfJ6PQH7O5EE
X-Gm-Gg: AZFdTZfLDgd9K3m8fVn5XpdNXEDXyYDTabAP60nMw/1viOG8oUoFXaMvRVB0nVTuZMk
	vqP+lKFuqW0/xyRUEjaL5bUrnibQPXOPOsxLPWM1cwQTuUXl+r3l0ZIlIzV7NAsbKMrGYDybdEH
	liG22CPhtsMmcuHIZ/XrJ2d6/fPqm/pk3ct0HL/dFuWd9i5xw8deWAha/AuoNMwP+e7GJp+3q+b
	bAksVwoBaQJQUDDqM7nulL73WZZuarInQJ/1bBNyfo65x+1ZcElhaPRmX3yeJFSNzPTsiUC5PRU
	jYF4MAJvIoW1sLq7HSCO27NrB0pjY2hQ9vh7trMqZNAWB5kx5v9dWiCbQUEtI1vvkGVAC1CW1rU
	5mpwpBLJOlNgFGDZPfqsGWNUMtl8hNmwD8iG4nQB74n6ip2oEyA9A3IAyMOnexzTdMMCdXqyrVc
	gWwTFm94bmiR+uZmYfuZkYJxyBa8iPQ6nVotMFlRORXCRJQyn8cJB8TEy7u71b1TO+mXvXkOW5j
	ksvvrFBQ/OQrE8+3IZ09GR/cZ+xa/P7dZq15QGBGmDoAfMnO78PhrSddKS+SioN1NIiXEh7xyuW
	ecVElOg1hIx4fD8CU75LBXb2Rs/HHUNCbRoklwYAJmn06lUm
X-Received: by 2002:a05:7300:bc19:b0:36a:18e2:64c with SMTP id 5a478bee46e88-3827f98ff0cmr7469514eec.11.1795098976262;
        Thu, 19 Nov 2026 06:36:16 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm19156884eec.28.2026.11.19.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:36:15 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 4/7] powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
In-Reply-To: <2b64e853-89a7-4fa5-a4f8-2c6b0b62bf74@samsung.com>
Date: Thu, 19 Nov 2026 19:59:02 +0530
Message-ID: <5wxslwsx.ritesh.list@gmail.com>
References: <20261110094830.2081847-1-m.szyprowski@samsung.com> <CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com> <20261110094830.2081847-5-m.szyprowski@samsung.com> <jym96n4p.ritesh.list@gmail.com> <2b64e853-89a7-4fa5-a4f8-2c6b0b62bf74@samsung.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 19.11.2026 13:07, Ritesh Harjani (IBM) wrote:
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>
>>> arch_dma_prep_coherent() performs the cache maintenance on the address
>>> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
>>> is NULL for a highmem page which is not kmapped, so the flush would
>>> operate on the wrong virtual range and leave the dirty lines of the
>>> buffer in place.
>>>
>>> The generic DMA code may pass highmem pages to this hook:
>>> dma_direct_alloc() handles a highmem page returned by
>>> dma_alloc_contiguous() by forcing the remap path, which calls
>>> arch_dma_prep_coherent() on that page before creating the uncached
>>> mapping. This cannot happen on powerpc today only because it does not
>>> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
>>> there, but nothing in the hook's contract rules it out.
>>>
>>> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
>>> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
>>> one at a time. Without CONFIG_HIGHMEM it does the same
>>> flush_dcache_range() on the linear mapping as before.
>>>
>> Does that mean, this change can add additional overhead for
>> CONFIG_HIGHMEM=y kernels, where the buffer received still belongs to
>> lowmem? (Because of extra per-page book keeping like
>> local_irq_save/restore, kmap_xxx). Thoughts?
>>
>> Although functionally the change looks correct to me. But maybe
>> __dma_sync_page() on powerpc side could use some cleanups (outside of
>> this patch series perhaps).
> Indeed, __dma_sync_page() could be improved by calling __dma_sync_page_highmem()
> only for highmem pages. Something like:
>
>
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index e646256365d5..199ce0467b58 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -97,11 +97,12 @@ static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
>         unsigned offset = paddr & ~PAGE_MASK;
>

Should we return early if size=0 is passed. Although I couldn't find any
caller where this could happen, but since we are doing "paddr + size - 1",
hence wanted to flag it.


>  #ifdef CONFIG_HIGHMEM
> -       __dma_sync_page_highmem(page, offset, size, dir);
> -#else
> -       unsigned long start = (unsigned long)page_address(page) + offset;
> -       __dma_sync((void *)start, size, dir);
> +       if (PageHighMem(pfn_to_page(PHYS_PFN(paddr + size - 1)))) {
> +               __dma_sync_page_highmem(page, offset, size, dir);
> +               return;
> +       }
>  #endif
> +       __dma_sync(page_address(page) + offset, size, dir);
>  }
>
>  void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>
>
> Do You want me to add it as another patch for this series?

I think this should work. I guess we should add this patch first and
then patch-4 on top of it.

Thanks for taking care of it. This at least will avoid the extra work
which we would have done otherwise for highmem kernels, where the buffer
passed to this still comes from lowmem.

-ritesh

