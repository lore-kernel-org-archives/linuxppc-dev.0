Return-Path: <linuxppc-dev+bounces-18783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A8109C036
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:30:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgspY4czkz2xSX;
	Thu, 26 Mar 2026 03:30:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774456245;
	cv=none; b=LNvvu7ESqD1TkzRwryaEKlbaoGphJ4t0aFBIHT0cLW33UpVctYC+E+sCgIm1MmXIuh7sLIKScp7DCcTzdsR1+Jrp3YJWRYNEA9DrArMTFXcLt3pdcyNewSTj+RF5wPbzzNMXX+Lrf//JkAWcJrG24ebxIg5JfULE2z1nQiRkvKnRrKqniOALTBHiTOohNnftGX5vYBhhY/SEwBzSPtevCmRi8MFRS5MDkpEo76y+gj28PxL6ifPKqdGgz//uGuxLZU7W3CpXymJqOxYpTU5SKf0eSq/mGls5pAj4K0tOeTVQOgsSUx9KI/Ehx3K0xpXSgqH2KUH+zZQJ8LLoJpWg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774456245; c=relaxed/relaxed;
	bh=v2u7ExN5eifBevZeC2xb3xyOceea1RmqMBZtOrcYzMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gODKAejAr6d9AhK8xX2QFnU9eACp8NuQheOQU0feJb6nfYdNLLmwo5toPk56KotNlXSSFNkEowK0heT4z12PlKl5RRVCaSVwXfJPhKDqtOp2TTbP7KlfsllfQ6xNMkI0fvRPAeferHCGvmxNBFw+V+fRzNp9zHDhR/t7xQqmW5XUgCSuLICAsmSk7THAn8mZeNUkfNGP1PU0OqwsJU17/lKkuZX+jPRNdkvqwZcS5t5bu7hOKfsFsnah+RltncD6ktIom7LDy+4qgqbQsgsRGAzQbqFfPTfO6fA6MmAEJj0XYnxULEbcKF04P+8zIsUZbDFNloytAMPVue9VovMgxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=J5ymzmT6; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=J5ymzmT6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgspX4TQrz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 03:30:44 +1100 (AEDT)
Received: from [IPV6:2601:646:8081:9481:619:3ffd:957c:6748] ([IPv6:2601:646:8081:9481:619:3ffd:957c:6748])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 62PGDMNL3153560
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 25 Mar 2026 09:13:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 62PGDMNL3153560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1774455208;
	bh=v2u7ExN5eifBevZeC2xb3xyOceea1RmqMBZtOrcYzMg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=J5ymzmT6BQR65DUAALhhSYjcHADheoqS/Y1TB20cnYBvtYJoCBoHEmdHJLu/Si20r
	 6rz3J3dMJE/DEAiYOO3Fx6vfsrD2MnYD1ixgvwprxcGhIEVWzMLmCHreu1sLIn5SNP
	 6VBBW2+SCSgr4uOYIIcCe+9jSspVTz7NsGduU1IHGnQyH3sgnggWaXIAuTY0sSScDJ
	 hy7fCQlaHvFN3juiyk0mVo/l0cAc4F3B4clshklYM45be69gwY6re6ju8/GDKmI3HX
	 ln5NoZUdBqzuxxOWGyGyQysV8OXGXSO4zB7ByDmwCtm51dOIhtQh0z8KO6LEy/vgUL
	 bF7T6QJ+oA0WA==
Message-ID: <fa11e4d3-1c70-4fa7-9f03-8772c002be6a@zytor.com>
Date: Wed, 25 Mar 2026 09:13:16 -0700
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
Subject: Re: [PATCH 02/17] raid6: remove __KERNEL__ ifdefs
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
References: <20260324064115.3217136-1-hch@lst.de>
 <20260324064115.3217136-3-hch@lst.de>
 <59d1d178-c141-4229-81e9-a6c23fa81f2f@zytor.com>
Content-Language: en-US, sv-SE
In-Reply-To: <59d1d178-c141-4229-81e9-a6c23fa81f2f@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-03-25 08:13, H. Peter Anvin wrote:
> On 2026-03-23 23:40, Christoph Hellwig wrote:
>> With the test code ported to kernel space, none of this is required.
> 
> I really *really* don't like this.
> 
> The ability of running in user space is really useful when it comes to
> developing new code for new platforms, which happens often enough for this code.
> 

That being said -- and I do say this as the original author of this code --
this should be reduced to the maximum extent possible to a (minimal) set of
#ifndef __KERNEL__, which should be localized as much as possible. The actual
user space components, even such a thing as a simple #include, should be moved
to a separate user space header.

But pretty please do leave the ability to debug the algorithms in user space.
This is hard code to write and debug; it is not just about regression testing.

	-hpa


