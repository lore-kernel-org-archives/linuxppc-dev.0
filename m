Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF51C46CD2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jan 2024 05:47:27 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SgqZYUET;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TKXzK5bn1z3cSn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jan 2024 16:47:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SgqZYUET;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TKXyS4yTWz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2024 16:46:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6F5B6CE29A9;
	Wed, 24 Jan 2024 05:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75644C433F1;
	Wed, 24 Jan 2024 05:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706075195;
	bh=LhesHwoZXRdX5jfbi0laKsTDlPHkqd2QNDhd5PA0n64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SgqZYUETYp0U/lExF64JKpfQ4QQzjrtotn/ONStmemo8UuEWx22RNGcCPysz/GGdH
	 wF4/0iVnvQm3wM0s4Ag4Pkguroe5zo7K7nKVaDa3YhK1ow6WyrrQ0jGg/jh0nlfdU+
	 f9jiSYnPlhA+oQTs1xwIrXNokUtNwZ94UcVY9oqXd8lQQbttaFJlpF0H4Hptl0pH0W
	 L6Si/Ez2ZPcSiKG/jTqZNA1RfHBeGdDrwVDOodIiOjh9BxNSAwCbUb8UnpBbsGqMmX
	 Fry6owvnHK5HB/4QPvBt/16sEl5jOidoL18vHxJm0dea3fi94NjlvWmuxijOXq/zBL
	 NkyRrt3sGxNQg==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
In-Reply-To: <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
 <6703b648-10ab-4fea-b7f1-75421319465b@arm.com>
 <ae3d826f-758f-4738-b72a-e99f098bb2b3@csgroup.eu>
 <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
Date: Wed, 24 Jan 2024 11:16:23 +0530
Message-ID: <87zfwvp9lc.fsf@kernel.org>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Will Deacon <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "linuxpp
 c-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

David Hildenbrand <david@redhat.com> writes:

>>>
>>>> If high bits are used for
>>>> something else, then we might produce a garbage PTE on overflow, but that
>>>> shouldn't really matter I concluded for folio_pte_batch() purposes, we'd not
>>>> detect "belongs to this folio batch" either way.
>>>
>>> Exactly.
>>>
>>>>
>>>> Maybe it's likely cleaner to also have a custom pte_next_pfn() on ppc, I just
>>>> hope that we don't lose any other arbitrary PTE bits by doing the pte_pgprot().
>>>
>>> I don't see the need for ppc to implement pte_next_pfn().
>> 
>> Agreed.
>
> So likely we should then do on top for powerpc (whitespace damage):
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index a04ae4449a025..549a440ed7f65 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -220,10 +220,7 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>                          break;
>                  ptep++;
>                  addr += PAGE_SIZE;
> -               /*
> -                * increment the pfn.
> -                */
> -               pte = pfn_pte(pte_pfn(pte) + 1, pte_pgprot((pte)));
> +               pte = pte_next_pfn(pte);
>          }
>   }

Agreed.

-aneesh
