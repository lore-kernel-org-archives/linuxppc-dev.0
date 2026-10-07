Return-Path: <linuxppc-dev+bounces-28994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D92CA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 12:18:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0Bws47Y8z2yS4;
	Wed, 07 Oct 2026 23:18:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791375501;
	cv=none; b=Lek6UxrRycwam5BUC1rHAwLd63oOu/LBS4bXbZE9lsk6G5391oO6N3KEz6K0TWd1WvjsuXSh8sqg6UMR9aV8VM4Kqr0W003ims/qCfJD467CsYnjyaKJ1uJS8epbNWLpKxE+kpw2MUaZ/C0H9tlh3hwYe9lb0twxY7ErsSMRhZlHRRdKvn1iVH5IW4Ae9e4iegFrGXxan76208iZlMXp1Ol0ykUMbb6CNhz9WqxzIsnHzO2Mjn2+HY/JpyJ/t5ACSWC+OmRKMtQBQ4n8+vbMY9hjOJsDkOf8pZ8uXd7+y2j2eD42Sf/1YFP0wtMjLdpW+KlMVF9gQ6GGeamg+RXdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791375501; c=relaxed/relaxed;
	bh=2WgWLAiPotutYayQG3trpdPvMIi0zMN+OiIn2PqYtBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LpfuIU/WgYfrhe847KxcDR575uP1XoOsWiRKqgE5TztJmLVjDON09zD12luajRaqCwc0JVHTcIE+ChX8r2I4xvffzyGIHG7G4gz546aze9pYnYDjOeIthh5lr9s+qUh3VWVOQlVnzyh+ef7Fx+BEQRc5dUPu8jQ/ks7rMKXBmwC5N5Xh7/5XLpXvfJ5bnsb82yVnhBdaxBdfx0WNEV3bw6zm433YojXcvxt6nBjSxMFNe+0tMj+Rj0fglWLMAzNqzfDyskXYn50J3ey/iHrc3M9oToj50r1y2aq3ty73Of/Sqbs6i6NyqKkbZkYnw5Uv/cgElQiKr2B42YM6B70y+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euozqhSF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euozqhSF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0Bwr6s0Cz2y8f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 23:18:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 014BF40AB8;
	Wed,  7 Oct 2026 12:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABFE1F0089B;
	Wed,  7 Oct 2026 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791375498;
	bh=2WgWLAiPotutYayQG3trpdPvMIi0zMN+OiIn2PqYtBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=euozqhSFQzcWnwMmFjHgWU9CQ0mRmnQ/1D4I+KBxZigk9xnWjARxsK7JZVR2odRko
	 M7uAKQ+ZnGHyc5Bw3SYbVoM2TV8SA+mrf+7JM0mxUjBwSrHe30dT8j60lFGuKvhbgH
	 jr+z075r7gGsj1avvxBkbsgCasm59loy0lYr47kiXLPk1EMD2xU2/2psHUTcLA80Y6
	 tLAdrspaLYKQXCPufkliH2EcXJL45rIGwPAuPpbZne93fbmu3Ez4WwG7bx0fhw5d/X
	 sO23nTup+cY08SZFL/7Cdf5XhChJ7GZHQSpaluQjJR/rdhlksim5K2/hznwDcX7xu1
	 O6S7FIGvrY0Jw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
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
In-Reply-To: <asYZFXGyafRjjBS0@arm.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
Date: Wed, 07 Oct 2026 17:47:58 +0530
Message-ID: <yq5atsmx3ds9.fsf@kernel.org>
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

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>> On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:

 [ ... 22 lines skipped ... ] 

>
> That said, such heuristics should have been a separate patch to make it
> easier to review/drop.
>

I kept them in a single patch to avoid breaking bisection. Otherwise, an
intermediate commit would allocate a swiotlb bounce buffer for pKVM.

-aneesh

