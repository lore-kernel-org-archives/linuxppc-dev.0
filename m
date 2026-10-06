Return-Path: <linuxppc-dev+bounces-28981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24B7CA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:52:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqk62TmHz2yVd;
	Wed, 07 Oct 2026 08:52:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791323566;
	cv=none; b=i31CzU448gQNgSl8XkRoNs7SRRKEXUDh767AGl545QcDA/PoeRfu6M/A8Fxg5nXSTq9qeMzEJw+DGWm133d8OrjS4QWct+pKitppiTIbjBBfJcEmTXJ/CtM0uXHJnLemxrNot3DLKEQtSoDZpGrkC3/JZ+d0oATUxQCRIAdCvbkSntVTvxIBHJ5dusPn5MJTFiALoQwy4Rw+woCXJlLUgg+K1sZzizGhMxVgUIeodsWAFbgypvw3rdazt0XeEPzvOjZlCRjBwN3ZnLqrtnvCOVhAOUkljaTybLzeK4pIKBEzVhYqjcEnyJIydzKAxZeD2u7CPPGjd1IFaefmYZ5dog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791323566; c=relaxed/relaxed;
	bh=aLltj2KeDqF9OosT0AEoWFskj5jYY5VnqnzaqsV3VgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkWPOqSsLKABWVgY2JysGiP7WXWOS2jUTxRqH8mAWYcNpSNrf49GA/Xe4eZpKEaB9bBps/IwSkvIWO/deBBNIzYqLzfqGknALWMXNa21m6PPUQ1iGIhjFQqbls1gBwLtmllfSSNVUPxoay4AuD1GMnjkWFBlgSE1+SJt6UNfsFQyqVzgdxqqtRMNsnquTyJT5iYXfOhapDebFz9RAKK7+gCWxPu1DAqOSBrPpdJWY84rcbIDy0btM4AMEybiI0OY8E2JPQGcl43qZHxLsc4TcA9uQvQ+ALiqjZTTnOinrpjP5XVIsDKI+V1E9eK+eCLz7wB7P/D7aPsjpy3eJ9iz5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ftqi5JxY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ftqi5JxY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzqk537wtz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 08:52:45 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B2F643AE3;
	Tue,  6 Oct 2026 21:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5A61F0089B;
	Tue,  6 Oct 2026 21:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323562;
	bh=aLltj2KeDqF9OosT0AEoWFskj5jYY5VnqnzaqsV3VgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ftqi5JxYQ7+lOH0e3/qLZoDI1z82JKInnQfYcKqixAXYDv4KmRLetT2yf6MF8YU1u
	 kUk9ToRlzIe8Nl1vp2TYck54k5ulwPMNvsOqte7ISHa1gh1TIEKVm+Z5mbwpXSF1AD
	 crVr7MkSiyiM2du+fk37Zp93ECnO4ni6RGEVcicG7VzMtvaS8p6SOzT+i9R5N0nIz1
	 /esNqVbVK14/jTVs7oNE7q6G/lw1RUNITEX+RT16CVY0u83mLVBpntBf5Str+DsaJe
	 LT4RGmc1J/WMANFyagqs0E7dcbEUuVDQE0vhXKYthrpnZNsogcBHN1Y8oBt35CXUDx
	 Enb5fk2CRE8Ww==
Date: Tue, 6 Oct 2026 22:52:29 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 0/8] dma: swiotlb: Centralize default pool policy and
 sizing
Message-ID: <asVtnRSeHRJr5mp3@willie-the-truck>
References: <CGME20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3@eucas1p1.samsung.com>
 <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <ff4f59ea-6c51-41d6-a92d-d1dd205b1e78@samsung.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff4f59ea-6c51-41d6-a92d-d1dd205b1e78@samsung.com>

On Tue, Oct 06, 2026 at 11:42:54PM +0200, Marek Szyprowski wrote:
> On 24.09.2026 08:07, Aneesh Kumar K.V (Arm) wrote:
> > This series centralizes swiotlb default-pool selection and sizing, and
> > simplifies the initialization flags used to describe pool placement.
> >
> > The first patch replaces the addressing-limit argument with initialization
> > flags and introduces explicit policies for the different reasons a default
> > pool may be needed. Architectures now report DMA addressing constraints with
> > SWIOTLB_INIT_ADDRESSING_LIMIT, while the core selects the corresponding pool
> > policy.
> >
> > The second patch moves the reduced sizing used when the pool is needed only
> > for unaligned kmalloc bouncing from arm64 and RISC-V into the swiotlb core.
> >
> > The third patch centralizes swiotlb sizing for memory-encrypted systems. It
> > moves the existing x86 guest-sizing policy into the core. Host memory
> > encryption retains the normal pool size, and a shared default pool is not
> > selected solely for guest memory encryption when a restricted DMA pool is
> > present.
> >
> > The fourth patch removes SWIOTLB_ANY. Pool placement is derived directly from
> > SWIOTLB_INIT_ADDRESSING_LIMIT: pools required for limited DMA addressing are
> > allocated below the architecture's low address limit, while other pools may
> > be allocated anywhere in directly mapped memory. Xen continues to request a
> > pool explicitly with SWIOTLB_INIT_REMAP without imposing a low-address
> > constraint.
> 
> 
> I will give this patchset a chance in linux-next. If one feels that it still needs
> to be improved or sees any other reason why it shouldn't be merged, let me know
> asap.

I think the restricted-dma pool heuristic is horribly naive, so please drop
that part for now.

Will

