Return-Path: <SRS0=QKeg=YJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C65C4360C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 09:32:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC6020872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 09:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VbsrQGWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC6020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46tRsD1B8XzDqkX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 20:32:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46tRq15hdgzDqTl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2019 20:30:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="VbsrQGWv"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46tRq03m5Cz9sP3;
 Wed, 16 Oct 2019 20:30:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1571218220;
 bh=+66O9Li1izFp25w50cjCl67akjbo/x0+/meVdN1iHgE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VbsrQGWvpGUpJ/lgbFdfNLYqJocbNK5dm20Yco1jwSV5W+zbVqWF3gnd0aHewMMEg
 coXIJhTAZeS4Xrs863EB0zqhHDLO0Ogg9qLpaOmU8iyDXCotxnaaZLP92dPAGBiKoq
 cVZqvCL2FWCmfnXhSlXOc5K1OC5SN+h0/PeDq7lmF4xPmze9hwWWvgGyQKZ+6s4v00
 dkLg03U81kmZTXhsZBqeLPrR88zOSOS3O61HN2IfofSeTmy2UOXoylVbjP8B7eRMM+
 Anv+97HPVYNOuEUfUJpGogS/i/Yqew81T0rstE7Kcq7WSHRTEU8mx8FqVE38vq4a5C
 4AH4hSJ3vyFmw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@infradead.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm/book3s64/hash: Update 4k PAGE_SIZE kernel
 mapping
In-Reply-To: <20191016060556.GA7279@infradead.org>
References: <20191016055130.10533-1-aneesh.kumar@linux.ibm.com>
 <20191016060556.GA7279@infradead.org>
Date: Wed, 16 Oct 2019 20:30:15 +1100
Message-ID: <87ftjtt4uw.fsf@mpe.ellerman.id.au>
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
Cc: Cameron Berkenpas <cam@neo-zeon.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@infradead.org> writes:
> On Wed, Oct 16, 2019 at 11:21:30AM +0530, Aneesh Kumar K.V wrote:
>> With commit: 0034d395f89d ("powerpc/mm/hash64: Map all the kernel
>> regions in the same 0xc range"), kernel now split the 64TB address range
>> into 4 contexts each of 16TB. That implies we can do only 16TB linear
>> mapping. This results in boot failure on some P9 systems.
>> 
>> Fix this by redoing the hash 4k mapping as below.
>> 
>>  vmalloc start     = 0xd000000000000000
>>  IO start          = 0xd000380000000000
>>  vmemmap start     = 0xf000000000000000
>> 
>> Vmalloc area is now 56TB in size and IO remap 8TB.
>
> Btw, is there any good reason to keep the vmalloc and ioremap ranges
> separate on powerpc?  Most architectures just use the low-level vmap
> code to implement both and share a range.

I think the main reason is that in some configurations we can't use 64K
pages for MMIO, so the 64K vmalloc mappings and 4K MMIO mappings need to
be in different segments.

It's possible that's no longer true on modern configs. But annoyingly I
can't easily tell because the kernel doesn't know, it defers to firmware
telling it via the "ibm,pa-features" property and setting
MMU_FTR_CI_LARGE_PAGE.

The spec (PAPR) doesn't give us any hints either it just says the bit in
the device tree means:

  The value of 1 indicates support for I=1 (cache inhibited) large
  pages; else not supported.

Which at least suggests that firmware is allowed to support 64K MMIO
mappings or not at its whim.

Hopefully Ben or Paul remember more details than me.

cheers
