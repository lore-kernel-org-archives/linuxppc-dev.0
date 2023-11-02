Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66764C4332F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Nov 2023 11:40:49 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kucSTeG8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SLhlM5lFNz3cTH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Nov 2023 22:40:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kucSTeG8;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SLhkM5gDFz3bwL
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2023 22:39:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1698925190;
	bh=Vq2GA6u/XgRhWEr1k6183ZkYg/ien3a/69DWx6lKpHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kucSTeG8ueIubumW3MkQ0SszDkgfg1rUDdKG28OrGzR1/IoggTuSNUjJkj2M6zIQ3
	 abySSJplMQNY3MEXuIPR2D87brFF4xbz9x9YCFnl84FBxpP3N6NuNzR3wD+vhSMaHT
	 71LhgSA+lGJm2YY6hB7zIzEtMrvcZqg2G3VbV81kXu1KtGfU1RoWnOAKnqwiKpHhZU
	 qhjId1L/GpjpjimAcBJWNTCLkZXE3OyVXzHGVfqtAme9aIw6e4valEpqfbFO4h3Zee
	 UG5xPy1RV2pUDAvlBDDv4bych338ZL8uULHj4p9memo+R4tLAdggRxskjmxQeej+Fp
	 0Q1cBWFBDa30w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLhkF5f4lz4xNH;
	Thu,  2 Nov 2023 22:39:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/mm: Avoid calling
 arch_enter/leave_lazy_mmu() in set_ptes
In-Reply-To: <ZTuV5GJ52IZE7mxu@casper.infradead.org>
References: <20231024143604.16749-1-aneesh.kumar@linux.ibm.com>
 <ZTuV5GJ52IZE7mxu@casper.infradead.org>
Date: Thu, 02 Nov 2023 22:39:44 +1100
Message-ID: <87bkccgz9b.fsf@mail.lhotse>
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Matthew Wilcox <willy@infradead.org> writes:
> On Tue, Oct 24, 2023 at 08:06:04PM +0530, Aneesh Kumar K.V wrote:
>>  		ptep++;
>> -		pte = __pte(pte_val(pte) + (1UL << PTE_RPN_SHIFT));
>>  		addr += PAGE_SIZE;
>> +		/*
>> +		 * increment the pfn.
>> +		 */
>> +		pte = pfn_pte(pte_pfn(pte) + 1, pte_pgprot((pte)));
>
> when i looked at this, it generated shit code.  did you check?

I didn't look ...

<goes and looks>

It's not super clear cut. There's some difference because pfn_pte()
contains two extra VM_BUG_ONs.

But with DEBUG_VM *off* the version using pfn_pte() generates *better*
code, or at least less code, ~160 instructions vs ~200.

For some reason the version using PTE_RPN_SHIFT seems to be byte
swapping the pte an extra two times, each of which generates ~8
instructions. But I can't see why.

I tried a few other things and couldn't come up with anything that
generated better code. But I'll keep poking at it tomorrow.

cheers
