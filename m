Return-Path: <linuxppc-dev+bounces-24071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025B1C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 20:42:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyyDC0B10z2y7W;
	Mon, 13 Jul 2026 06:42:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783888922;
	cv=none; b=BAfhvghPQ2hmDnz31YuN8ZkjwLgRM/ziUyO74afQOGkxI3Xbc814Wot10KHdvZUe77OwqmK23SSF5aaIpUu1a9lZr8D1ZMAamaFgdaRJo81Uh/DpDu0Xamy/2zI/lHNFOSt/Hj/8gURavcy4TX6ixEJprtBUoDQJ880zjWOIf/0XwC9l0aJq/UhRVFOISRvaf3bFapVFqHq5+YmB3Bf3DUEPox1xk42/ttLmWO50oOwpTE0MGBmevX5qg8WzDtJCP8zfJVT7Rwp6m97iujiMPrny3DoovTNFW0BYOKgsQdWKkSzE0BohhUC9lUEKl5xP7YRetxSwiVzf9R4yicrnig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783888922; c=relaxed/relaxed;
	bh=dLSOU1pu1ktkGkfXBrA/niWmFzF/2hu1aOV2pcJShT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNfK9NNCyLjZVTuah4aTa7zTt1tMcvw0WhPRtZIB6A5NjRqi3L7ZZimAyNUwA3FYAufEOoTQJ6fz6X3j2W97GXa1n9ZnVOPr/URBwipcgf8uVCkHqlqdXE/kXgXRu1/ymVY6OX988Daj6b+dOnyWYs9+cnE2nS3uExvmHayk2NW8elRR/8D3+emKsxwxA9vVZI2WRs9E/VNQXrhECrcMXsj5BXB66u3ErzGb8SKmJxkDG1AkCHNcXYP5/E/DamcBXreANisQa7sDJAXOSI4pJkgvMkHyUeTgpOzP/dudzOikLUVXP9otshfWXqCCAA1rI7opY08w1xUoItTpf8/0Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEOM0U3F; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEOM0U3F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyyDB3Yb8z2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 06:42:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B4C9840A4E;
	Sun, 12 Jul 2026 20:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5361F000E9;
	Sun, 12 Jul 2026 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888919;
	bh=dLSOU1pu1ktkGkfXBrA/niWmFzF/2hu1aOV2pcJShT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cEOM0U3FTXpjGbKvwi2BsxSK3Adb/46B8+sOF4GTAu9znEAWAcy7jtUjkl+qABedI
	 zKTYYvkIk8AezlUq1AXW2h2gWyW7Cx1dqHSJIrkyareOI5dmHZREAXhjRdbwJ8bfkG
	 pMfuhJRyGhd+zjb/rM+tTcqnvXhfJXObtqAm0EKo8op+jBBoNDCHirVwMJ+gFjUBSK
	 4WAnVpHe6n7JpTjygZsz66snFSNi79CT/rE84DhSEUs7m+vgkhlXhJA55N4QYQ5GXa
	 vkY18dSaOvyGhgaYr+qPFOTxqxX3LZYa2ZWm7NjCDi9apz/jrf7oW6wAIwlfK0IbwG
	 etBry/xh8LUog==
Date: Sun, 12 Jul 2026 16:41:54 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	clang-built-linux@googlegroups.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against
 symbol 'init_task'; recompile with -fPIC
Message-ID: <20260712204154.GB1697833@ax162>
References: <202607100652.WPUlEAfx-lkp@intel.com>
 <alBeJUafPKhx8RMS@U-2FWC9VHC-2323.local>
 <37fe4a15-e51b-411e-9667-a1c670f413e1@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37fe4a15-e51b-411e-9667-a1c670f413e1@kernel.org>

On Fri, Jul 10, 2026 at 06:33:49AM +0200, Christophe Leroy (CS GROUP) wrote:
> + Clang
> 
> Le 10/07/2026 à 04:51, Feng Tang a écrit :
> > Thanks for the report!
> > 
> > Add Powerpc list.
> 
> This is a Clang build with Clang linker, did you reproduce the problem with
> a normal GCC build ?

This does not reproduce with either the GNU toolchain or LLVM + the GNU
assembler. It only reproduces with clang's integrated assembler. I am
pretty sure I have seen this error before so I suspect that this
bisection is bogus like mentioned below.

> > 
> > On Fri, Jul 10, 2026 at 06:18:50AM +0800, kernel test robot wrote:
> > > tree:   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094863506%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=fQm6QfsJ2ggaKoRJWCz4dsaquz7Wo3uhRnOexVUrTnQ%3D&reserved=0 master
> > > head:   0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> > > commit: d5cae2261b86913e602452ce4a07e6aefc0f603b dma-contiguous: simplify numa cma area handling
> > > date:   6 weeks ago
> > > config: powerpc-randconfig-r133-20260709 (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260710%2F202607100652.WPUlEAfx-lkp%40intel.com%2Fconfig&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094899182%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=BkT0BYyJtniz6YPzGpYbO0jn2T7vBDBLaK2Tsh1LcnE%3D&reserved=0)
> > > compiler: clang version 21.1.8 (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094917538%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=5%2BLVtRoojuNbhEMr3BhM2xF50PV%2FIYh%2FWw3ipDIWG%2FY%3D&reserved=0 2078da43e25a4623cab2d0d60decddf709aaea28)
> > > sparse: v0.6.5-rc1
> > > reproduce (this is a W=1 build): (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260710%2F202607100652.WPUlEAfx-lkp%40intel.com%2Freproduce&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094935016%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BrpcCLuNecZIfyF6N5X%2FFcHhdG9YzLBAErvBGHyjjak%3D&reserved=0)
> > 
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
> > >     >>> defined in vmlinux.a(init/init_task.o)
> > >     >>> referenced by head_44x.S:101 (arch/powerpc/kernel/head_44x.S:101)
> > >     >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x42) in archive vmlinux.a
> > > --
> > > > > ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
> > >     >>> defined in ./arch/powerpc/kernel/vmlinux.lds:133
> > >     >>> referenced by head_44x.S:108 (arch/powerpc/kernel/head_44x.S:108)
> > >     >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x4e) in archive vmlinux.a
> > 
> > I checked the patch and couldn't find obvious clue between the patch and
> > the error.
> > 
> > commit d5cae2261b8691 only changes kernel/dma/contiguous.c, which is under
> > CONFIG_DMA_CMA per kernel/dma/Makefile. In your config above, CONFIG_DMA_CMA
> > is not even set, so the contigous.c should not be compiled. Could you help
> > to double check? thanks!
> > 
> > - Feng
> > 
> > > Kconfig warnings: (for reference only)
> > >     WARNING: unmet direct dependencies detected for HOTPLUG_CPU
> > >     Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
> > >     Selected by [y]:
> > >     - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
> > > 
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel%2Flkp-tests%2Fwiki&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094952205%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=sqz%2BJ2dpT3ZZjlQyyvAhgPdP9jS0kJLpbRKTcV4rM50%3D&reserved=0
> > 
> 

-- 
Cheers,
Nathan

