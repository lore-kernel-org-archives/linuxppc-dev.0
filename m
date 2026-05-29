Return-Path: <linuxppc-dev+bounces-21699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92872CD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:49:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRcVs17bnz2xnZ;
	Fri, 29 May 2026 18:49:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780044597;
	cv=none; b=AvqBPLcU0VLd7DcyvaAilCsajUnnnc/HodCP2IPPxSEI7BBsencTfZKJUbX204/S/ShDRO1fi4ZW13bi8uENHpifV7niTGmVbugZWcZJXBFVTln0H1dBCgrFZWur4L/Q//y8gtr5FBkeS13nnhnmc5ukjQFdtZZI4ddRq6R0bYb/kNreAtVKEv/RyZ5YxeEayCM/5ASwdAqImnbFhS2p0j1T+6LEJ2TeCYqVoHHhWFNEm22Ng6By3cFUvG2oZmLdYam0n+5sAs9rlysiYeyCJqE4gTCNGNUpK99SPdz393N2rAfGoKTdOQDDVLXvWBx/jc5M5VUu91VYvDw3GliEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780044597; c=relaxed/relaxed;
	bh=0Yr74bm5b1I6er6TsjOHvM8O63leqKbgA8DFDU1A6jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3eW7y/hhISmfmnEqAjfaj4iVWQMASxlN/NLIaY3MtuCS7mkudzCjOdAZ+5RngyaDu6dowJRy3E9nl/PJWAi8ODuSAia9U7aJX8HpTOT/G+0Bk9sr5pHQXv5Q6ijMX+fANCmTHifznK7WH6fqq8kGWfEjiXwgOzPdQbq0FNg+1w37AItbreK0251Uy/rCj32viFzN8cPFRbUhK8LTJP66btKVVefxJFG6IqJNektDV0qY4sWanu8rHLEwgRDaOl8gJve7XOjPnUwPq2OMsnmHmZjoptEtmylwVD4h8SHwhDsAq5BAe45cOdZiAnKxd+LJ6CTpJQ89RdZ1dxJO8F+QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ivprReKs; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ivprReKs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRcVr1j1Hz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:49:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20A2E204C;
	Fri, 29 May 2026 01:49:19 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430AC3F632;
	Fri, 29 May 2026 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780044564; bh=0Yr74bm5b1I6er6TsjOHvM8O63leqKbgA8DFDU1A6jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ivprReKsUadaCcTb8g0Y6fux7oLRv4zPPNFSi1TEM201qLpgF3A20EQN4tJDBDtM3
	 S0nbog1ouGDatXNHMgkBAd+V9ATrxI5QR8icYHXBy454uuQh3yuqWKsVaGy/XI47P3
	 ZKILKdQnLDYLJUH2p/YTF/kixb3dzjPrfQvx+zsA=
Message-ID: <32458c49-0e3c-4d27-b1cf-0e2d7ee0273d@arm.com>
Date: Fri, 29 May 2026 10:49:17 +0200
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
Subject: Re: [PATCH v6 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-32-ardb+git@google.com>
 <22042b98-cfcc-428e-bb08-ebcfe785eb69@arm.com>
 <8082b77d-6522-472a-9030-317087ecd7e9@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <8082b77d-6522-472a-9030-317087ecd7e9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 10:34, Ard Biesheuvel wrote:
> On Fri, 29 May 2026, at 10:29, Kevin Brodsky wrote:
>> On 26/05/2026 19:59, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are mapped read-only in
>>> the linear map as well. Given that the contents of these regions are
>>> mostly identical to the version in the loadable image, mapping them
>>> read-only and leaving their contents visible is a reasonable hardening
>>> measure.
>>>
>>> Data and bss, however, are now also mapped read-only but the contents of
>>> these regions are more likely to contain data that we'd rather not leak.
>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed. (While the hibernation snapshot logic
>>> seems able to map inaccessible pages as needed, it currently disregards
>>> non-present pages entirely.)
>> I'm not sure I understand this, is there something wrong with the
>> kernel_page_present() check in safe_copy_page()?
>>
> No. If the hibernate code decides to snapshot a page and it is not mapped,
> safe_copy_page() will do the right thing and map it on demand.
>
> The problem is that pages belonging to the kernel image are marked as
> PageReserved, and so the hibernation logic will not even consider the
> pages for snapshotting if they are not mapped.

Right I see the check in saveable_page() now. Maybe it would be worth
spelling it out in the commit message (hibernation logic ignores
non-present Reserved pages).

- Kevin

