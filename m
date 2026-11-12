Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA8606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBTA1Nam
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQGTB4S63z2yLY;
	Thu, 12 Nov 2026 21:14:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794478462;
	cv=none; b=P22NVX892Ckleu9x+LdQoLKiY9sja3dENWzlZPVBbqcNJQ4xSOjgA0joGyb9p9nHaGjUqe6zlhsXlVRLYoVs26/ffGYpatOg6dcOFdhRUME+Nxl1Eo2mlQz1N7O3qUCP8KXoDFvQ1F2RzXlElsTv9cVUjm6kSuhoROQoRQ0koR+6LxsASP11ke/Jp8cSDgkv675R39oEMfjIABbkbOhJF1x0DONOfYftpvrPkPa/ZD/AemQwNUjLf/qjlTmrhTNQZ9iclSbKpqO+fhMg12Xi1zpwiheFBDe1/zi0lVoSZOWYOd/DljMAywaY13PoENkZOW56kTJ7ejDSBwDmrGmiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794478462; c=relaxed/relaxed;
	bh=Y6qGWFGnpPL1ZkxmjT2jfKkaXhHx34ppHOpZ4kDJJ7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fl39kV4ON8Y+9O+LqJLhnnnhyjrfd4Z0FYzYyfvJqGT9mTdzzOhHASv1YleeBRNGoSVsMUbbr0i9wJPIm1W2Y2lOWod6m2XANBotct3JIKGkn8SQWzzb8HuFlfM4cEIBcP7N7Txu6OKo2FMUCuHmE4Vc47yOPmbEfqnVYUCyxPLoeqny3ZxPNoVWt+FiBE60MwfOrX0F5Y0TnVY4J95DgB8ml+5BvBPZ5m7RMArPmysa9GjvH+Lt3dipUfJeyFNPmlH5EMa4r1aFgS4qDILhzyEreAw4UchmpH81zXRLMgoYE7FNLsRuZd4HDTZ4/1zD6Mku4nGMH7rsJK+fropZTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBTA1Nam; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBTA1Nam;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQGT92wgrz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:14:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 574F36348B;
	Thu, 12 Nov 2026 10:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF6C1F00A05;
	Thu, 12 Nov 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478458;
	bh=Y6qGWFGnpPL1ZkxmjT2jfKkaXhHx34ppHOpZ4kDJJ7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MBTA1NamdzwTkZFr1duA2LSuyBzBxb6sNOwn0iO8KEGEo5pBXxgtCA30N+7GE/2Pw
	 GLLvMwMZMI+da7JzcTnuS0bMCdJanR2u9J/lPT9ckfrvKZNg8LhcDu8V7C+TbIeSjw
	 8yAMG4KCQ37LswDNHi5a/WIuQLaVB3XmEBALQQYzAaV+Q8iEdtJJ3Dxcj6qOxTLYnK
	 jVkJEIC1HFd3EBLbKlThHyGFKsjs0LGuM/niOEOMAHspsHAU9Gpim1bszdlXVU+ehU
	 fummkjIScD+yhHq9nloKuZ6lIpGJGM30bseMr702s+Ru+2cT98q/Bl763g0e0qb8DX
	 66KW6Lsjq8WcA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
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
In-Reply-To: <avRKiCBs81XSYMqW@FCCLS0092175.localdomain>
References: <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org> <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org> <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
 <yq5a8q3d9oe6.fsf@kernel.org> <avRKiCBs81XSYMqW@FCCLS0092175.localdomain>
Date: Thu, 12 Nov 2026 15:43:59 +0530
Message-ID: <yq5a33t6qrvc.fsf@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kohei Enju <enju.kohei@fujitsu.com> writes:

> Hi Aneesh,
>
> On 11/01 09:47, Aneesh Kumar K.V wrote:
> [...]
>> >
>> > Hi Aneesh,
>> >

 [ ... 35 lines skipped ... ] 

> Overall, I would prefer the dynamic sizing approach. However, I believe
> the initial pool size still matters.
>
> Also, as Catalin pointed out earlier in the following message:
>
>     https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/
>
> the arm64 adjustment also reduces the target size used for dynamic
> pool allocation, since both the initial pool and dynamic allocation
> currently use default_nslabs.
>
> I am testing the patch below to decouple the initial pool size from the
> dynamic allocation target. It adds swiotlb_adjust_initial_size() for
> callers that only want to reduce the initial allocation, while keeping
> the existing swiotlb_adjust_size() semantics for callers that want to
> adjust both sizes.
>

Should we instead update the logic so that reducing the swiotlb size
leaves the dynamic allocation size unchanged, while increasing it also
bumps the dynamic allocation size?

-aneesh

