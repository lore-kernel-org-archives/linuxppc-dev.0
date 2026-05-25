Return-Path: <linuxppc-dev+bounces-21469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B326CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 11:37:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPDPz2SPRz2xbN;
	Mon, 25 May 2026 21:37:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779709047;
	cv=none; b=AkjKfSgghmvCrSTKJHawNWqWFg7xsyiS58grdnfqDxwQI2VIe7FSTOs1xTf2Kd86jQU0knVTN5TvqFhui6lwoGR0ovIdoj40+RkcVcbVlrFal++uzf9F8/MZf9+sDwpIQdGo3K33+MTd5x2Jxq55eo2CDwEiseE0ZsonLut0RieUnOz1Ah3lws6X4nPn18YlJ86PMMhb7SGBkM9o41ZokLUMSc31FAI1t9iff9/K4+xvMKl9rxNlb18JJAEtmbw2585YKRrf1id3dh8mBvD6EDIcvx+E1bZAPoi9QDYY4Zo0DeqidpJ/lcq1j022q37LvwPzWUEh4ntjlrDLze3GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779709047; c=relaxed/relaxed;
	bh=kPbn/f1fuyb07lSfD/0s4GT4WdFio8z3401p2vvqFyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqvvkQMkmlaq78lbVZQG7JzDWSCryM6jGFEVmhY4hBzMX0nlsLwV7bbN59CjZ9MWF2Ij1GgnQnQ85XI5jO63frSKaroQO+taKUMYohZBh+tajbdpEaEOGUPlaLZAxIYL3fWxbCOp0jeRe9oHxL32JEJ6Vg9GKaFA13IvzR2aXRzstqkGVdhTZKE3z3Hl4ew574W/ruimeiBZyv1G8SUqlI9W8QWNcYr4q7n59doxz547kIGKkYRCpHu3jvyHdX1N2p8P4xqE/g3Fg5d3RV7ExEjrkxy/iK1OckLogdRsKY99AJ0Ot1maLqachlcmyRGi8rxjNlHVAZ2RUpUqcMmeVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9sT/QL/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9sT/QL/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPDPy2Vd7z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 21:37:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 41F3A600BB;
	Mon, 25 May 2026 11:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BBD1F000E9;
	Mon, 25 May 2026 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779709043;
	bh=kPbn/f1fuyb07lSfD/0s4GT4WdFio8z3401p2vvqFyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W9sT/QL/8R3LJxQuJnqULPdrM1nsn4daH1Hjg/KpYXguHjTqD086qv20sIL6mYl7R
	 XvOBmsbGn+aUBuuD7YmCOeIBLyz0kPBoaqx8/W3s5VRN8Uno0zD9eWzhOy98TVtqHK
	 uA5YsM6E1BhscTKFZqCHI7pnI0htTV0tK3UF7zLRCukCjMI3DNJkV8VmQGJ6ffOdN0
	 iYCyXUqWwY3mrHjVk0kX4Rj4QjgL5c4kWpv5gUyVC+8qN/Ciuck/k/UyX3sdsCSWpw
	 EdG7Pg1gWabsDFCJzyUMK6eYBu2NWAC8UFjZF4q/8uJvLDBi9zqnwL/M3hikizHgFZ
	 G0HKwZWWlmGyg==
Date: Mon, 25 May 2026 14:36:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, rdunlap@infradead.org, pmladek@suse.com,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, kuba@kernel.org,
	lirongqing@baidu.com, ebiggers@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, ardb@kernel.org, masahiroy@kernel.org,
	mark.rutland@arm.com, maz@kernel.org, james.morse@arm.com,
	leitao@debian.org, sourabhjain@linux.ibm.com, yeoreum.yun@arm.com,
	coxu@redhat.com, jbohac@suse.cz, ryan.roberts@arm.com,
	cfsworks@gmail.com, tangyouling@kylinos.cn, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, junhui.liu@pigmoral.tech,
	vishal.moola@gmail.com, kas@kernel.org, debug@rivosinc.com,
	namcao@linutronix.de, liaoyuanhong@vivo.com,
	fuqiang.wang@easystack.cn, seanjc@google.com, guoren@kernel.org,
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, bgwin@google.com,
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v14 00/17] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <ahQ0WRiMsB011tym@kernel.org>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
 <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>

Hi Huacai,

On Mon, May 25, 2026 at 06:14:52PM +0800, Huacai Chen wrote:
> On Mon, May 25, 2026 at 4:50 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >
> > Jinjie Ruan (16):
> >   riscv: kexec_file: Fix crashk_low_res not exclude bug
> >   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
> >   arm64: kexec: Fix image->elf_headers memory leak during retry loop
> >   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
> >   arm64: kexec_file: Fix potential buffer overflow in
> >     prepare_elf_headers()
> >   riscv: kexec_file: Fix potential buffer overflow in
> >     prepare_elf_headers()
> >   LoongArch: kexec: Fix potential buffer overflow in
> >     prepare_elf_headers()
> >   crash: Add crash_prepare_headers() to exclude crash kernel memory
> >   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
> >   x86/kexec: Use crash_prepare_headers() helper to simplify code
> >   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
> >   LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
> >   crash: Use crash_exclude_core_ranges() on powerpc
> >   arm64: kexec: Add support for crashkernel CMA reservation
> >   riscv: kexec: Add support for crashkernel CMA reservation
> >   arm64/crash: Add crash hotplug support
> I have some bikesheedings about the subjects. Can we unify the prefix formats?
> x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....

It might look weird in the series, but powerpc and x86 use '/' and arm64 and
riscv use ':' so in the logs in arch/ this would be actually fine.

With the only exception of arm64/crash that should have been arm64: crash:
 
> Huacai

-- 
Sincerely yours,
Mike.

