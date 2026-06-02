Return-Path: <linuxppc-dev+bounces-21829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF25CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 03:12:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTwql5R4rz2xdh;
	Tue, 02 Jun 2026 13:12:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780369618;
	cv=none; b=QKMzO+HyJl1B3hTp6O/M+MgAdSvHhqlspe4JewWkB9jW9GyV3LY52nqewKDgHUOf+3coE0/xvzzrAvLiNGJuBtc0re5OlgGDLcFva/lWzgiLkQ3dO8ANMeXqg0pztJ2MT2OPHYbjtBL6qqULutcJjIRSTC1VNGqh9wndOFFSfB4pVH/qcJW4lAv9dfqv786H4BdHAyWXNyYph/VT2kcrDelCZIQFfDtBPCgN2kMi7VwuwUSZVWjyhjp/k3fyEMeoogAZVmvwwF0O+M7icDYSHefauwMEjdg7ltz11fVgQbDs8YustPGBAvBSDMEt7ZxPE+BgpdTs8oKOBcjQozVJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780369618; c=relaxed/relaxed;
	bh=P70qjRmAyMymwJPTMfOq+4DYcvFmuGavpK8tS3QAMZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2j62xJX1VGknBhB/xmaXTHVMVV9zLTxzt/kNHiog7vpbyXtDjZxsgR7W75KAJ1LotPqNLid0XXwH27LTbgvUHLJqkVa+f+RQW4nA0wjlJ1u5Qhg5TCRfUmTZRiSBnqv96pjTdujNfnlM0oFFbp6OOZ41rNfpw0fS83Th3n0r73RbAhScMAwDRB4LrTrmHLxiuMViLS+3k1pxZo2Y118VIrOoaY4b8Q6oxrVB8jYZWvk8ten5n9MdKSLjK6PrReI4PHSp4gWhNINlO+xZK0CJINpDYlGL5DsHwfMJW6GD6cEo5Yu1S61TKw0Y07ApSWwFcaOpI3ecqr6MRUFhVsTKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FfbPNmSq; dkim-atps=neutral; spf=pass (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=baoquan.he@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FfbPNmSq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=baoquan.he@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 48339 seconds by postgrey-1.37 at boromir; Tue, 02 Jun 2026 13:06:55 AEST
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTwjC4gFZz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 13:06:54 +1000 (AEST)
Date: Tue, 2 Jun 2026 11:06:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780369591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P70qjRmAyMymwJPTMfOq+4DYcvFmuGavpK8tS3QAMZ8=;
	b=FfbPNmSqGFBVUXMW60W8WZklD/5OswTsE3vOOKJWBoPQkE+ieiKrsI/w+0/boUf1oyoQTr
	a6KYsX23L/elGm5bXPqfLcPYLugymhGemNGpdBX9bswHkYCZ207Y83Ojwb0HZ4Gy7cbZDl
	Ei0P5PYrgBGvOUgIoJMhYqqLwwkMndo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, rdunlap@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, kuba@kernel.org,
	lirongqing@baidu.com, ebiggers@kernel.org, paulmck@kernel.org,
	sourabhjain@linux.ibm.com, thuth@redhat.com, ardb@kernel.org,
	masahiroy@kernel.org, gshan@redhat.com, james.morse@arm.com,
	maz@kernel.org, leitao@debian.org, yeoreum.yun@arm.com,
	coxu@redhat.com, suzuki.poulose@arm.com, cfsworks@gmail.com,
	osandov@fb.com, jbohac@suse.cz, ryan.roberts@arm.com,
	tangyouling@kylinos.cn, ritesh.list@gmail.com,
	adityag@linux.ibm.com, hbathini@linux.ibm.com, bjorn@rivosinc.com,
	songshuaishuai@tinylab.org, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, djordje.todorovic@htecgroup.com,
	austin.kim@lge.com, namcao@linutronix.de, djbw@kernel.org,
	chao.gao@intel.com, seanjc@google.com, fuqiang.wang@easystack.cn,
	liaoyuanhong@vivo.com, makb@juniper.net, graf@amazon.com,
	piliu@redhat.com, rafael.j.wysocki@intel.com,
	mario.limonciello@amd.com, jbouron@amazon.com,
	chenjiahao16@huawei.com, guoren@kernel.org, bauerman@linux.ibm.com,
	bgwin@google.com, takahiro.akashi@linaro.org, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v15 00/23] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <ah5Ioxs9aLxKIKWg@MiWiFi-R3L-srv>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
 <ah2Lx7KHI60tzd0v@MiWiFi-R3L-srv>
 <1a459706-80db-43d8-b163-76fc09da338d@huawei.com>
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
In-Reply-To: <1a459706-80db-43d8-b163-76fc09da338d@huawei.com>
X-Migadu-Flow: FLOW_OUT

On 06/02/26 at 09:43am, Jinjie Ruan wrote:
> 
> 
> On 6/1/2026 9:40 PM, Baoquan He wrote:
> > Hi Jinjie,
> > 
> > On 06/01/26 at 05:47pm, Jinjie Ruan wrote:
> > ...snip... 
> >> Changes in v15:
> >> - Unify the subject prefix formats as Huacai suggested.
> >> - Fix powerpc pre-existing NULL pointer dereference [Sashiko [1]]
> >> - Fix powerpc pre-existing __merge_memory_ranges() memory range
> >>   truncation [Sashiko [1]].
> >> - Fix pre-existing arm64 CMA page leaks [Sashiko[2]].
> >> - Fix pre-existing crash_load_dm_crypt_keys() Use-After-Free and
> >>   Double Free issue [Sashiko[3]].
> >> - Fix vfree(headers) and uninitialized variables issue
> >>   and simplify the fix [Sashiko[2]].
> >> - As walk_system_ram_res() and for_each_mem_range() use different
> >>   lock, unify and simplify the fix of TOCTOU buffer overflow via memory
> >>   region padding [Sashiko[4]].
> >> - Fix the arm64 crash dump issues in Sashiko[5].
> >> - Link to v14: https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com/
> > 
> > Do these Fixes have anything with the main target of this patch series
> > you mentioned in cover-letter:"arm64/riscv: Add support for crashkernel CMA"?
> > The patches become more and more in each new version, I am wondering if
> > it relies on these Fixes patches to implement your adding support for
> > crashkernel CMA on arm64/risc-v.
> > 
> > If not relying on them, could you split them into different patchset
> > on different purpose? 
> 
> Hi Baoquan,
> 
> Thank you for your valuable guidance.
> 
> You are absolutely right. Most of these fix patches are indeed not
> strictly related to the core implementation of the crashkernel CMA
> support. They are pre-existing bugs in the surrounding kexec/crash code
> that were flagged during our review.
> 
> Previously, Andrew suggested taking a look at the code review comments
> from the Sashiko AI system, which is why these fixes kept expanding. I
> completely agree with your advice that there is no need to keep them
> together. I will split them into two completely different patchsets
> based on their purpose:
> 
> 1. A cleaner version of this series, strictly focused on adding the core
> crashkernel CMA support for arm64/riscv.
> 
> 2. One standalone bugfix patchset dedicated entirely to fixing these
> pre-existing issues.
> 
> By the way, I would also appreciate some advice on how to handle further
> AI reviews. It seems that the more code we touch or refactor to fix
> these pre-existing issues, the more tangential bugs the AI flags in the
> newly exposed areas, making the series extremely difficult to converge.
> 
> Should I continue to address all AI-reported bugs associated with the
> surrounding code in this series, or should we draw a strict line
> and only focus on the core CMA logic moving forward?

Then please post patches to focus on the core implementation of the
crashkernel CMA support. If any AI reported bugs are raised but not
relatd to it, you can add note in cover-letter or explain somewhere
to tell whehter it's caused by the core code and how you want
to deal with it. Otherwise, you could go round and round of new posting
and still can't see when it ends up.


