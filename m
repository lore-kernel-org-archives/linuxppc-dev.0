Return-Path: <linuxppc-dev+bounces-23989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E55C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 04:34:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxJrB4ZWfz2xlw;
	Fri, 10 Jul 2026 14:34:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783658042;
	cv=none; b=Po/GsDWwOCJOz/MlSHlmEwZplx2uPr3YFqMj4McCq4K24lT2ABa7D+r1+P1vTe2/HzfUCYnmhV7Djbopbt0UAaRpM9H99qMStThJmMleQNNu9P9CteumNQzVZSXrpIxmjdpAqV3IYfpu8Xl7T/3G753pn3Lol9rHhO9urYQ7l/aMvZxxNC5TNYoG85VsLtwdmtox0HwE2Wu69O+RgaE+mrvjH0BsHF51buNrUFQQ1DQLgF8heMt5CEOTW/Qah0p0+y9PW483qNtq95N1BLjr2J63IMQvjcr0d/W5Tg1lPHDpne/KqQIXDop+NNHLOslZcZOVCtuEcTwmShDua7x81w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783658042; c=relaxed/relaxed;
	bh=oDBx1prP1r+KyhbLRp9EDnb+CE6bU/Pm9048fM8t044=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhQX5Mfb9rBE2O2OE3gNtA57SGlp8F9IyfJFMCPIX2Wd79WuRobeE54KV3O/dUqGQ8PXBAWg0et74EqEbyseNQqjQRiiaAntIFTYvR/Alor1Cw2PhFPECaay4hQbgnw9y/1I81Fumrvl4zwN4hNmWiK63c55PZFm2TaewpYEgB/279lGC+8jxWK3Sfmgx5b3ikNxY8bcL6ubbLOowTHElDI+nGINNC2FentTHQi17RI+ZBu8ptWA7Xu+DOhfKFsP3kT0yMKzHUCQErFZio5+tTOnUHgFpGfl/Fkq8W3QsXbu4Fq92u4Wxis246XJ+OBr1pnbmJh2HYiubZ8OgfVoOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSECNj3N; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSECNj3N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxJr54BLYz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 14:33:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4ED3F6001A;
	Fri, 10 Jul 2026 04:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F761F000E9;
	Fri, 10 Jul 2026 04:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783658035;
	bh=oDBx1prP1r+KyhbLRp9EDnb+CE6bU/Pm9048fM8t044=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZSECNj3N7sw5xo9g2AfAczpoYZHGudwGo0EajEzi6iiU4qMUjUfC8SbntfAsJB+PC
	 GikhM8tMttqZcti9cIIaZxpNamhDvlzYi2KTS6yPIzBX26rPlrkwmXSI7ZByVu6Y0f
	 x9D2IXxMn6+xZEUJiQF4bcYWOS+ZIQjtMgMLr5h3i/70O9GRhNEqljpiGGTX38wVij
	 WQd22JxetHQSwE5ipxCx0riINXkyrt0N7urCD6f/3x8FMMTVaHM+/aQK8vxYQr8GAq
	 ggie6p3vpmsrRK1YBhjWEZ5tiCq9GmaxYqeTpz3h+u1J9YCmAeQNpz84kFT0eHVQLI
	 kEtLHqn67pWnw==
Message-ID: <37fe4a15-e51b-411e-9667-a1c670f413e1@kernel.org>
Date: Fri, 10 Jul 2026 06:33:49 +0200
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
Subject: Re: ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against
 symbol 'init_task'; recompile with -fPIC
To: Feng Tang <feng.tang@linux.alibaba.com>, kernel test robot
 <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <202607100652.WPUlEAfx-lkp@intel.com>
 <alBeJUafPKhx8RMS@U-2FWC9VHC-2323.local>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <alBeJUafPKhx8RMS@U-2FWC9VHC-2323.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ Clang

Le 10/07/2026 à 04:51, Feng Tang a écrit :
> Thanks for the report!
> 
> Add Powerpc list.

This is a Clang build with Clang linker, did you reproduce the problem 
with a normal GCC build ?

Thanks
Christophe

> 
> On Fri, Jul 10, 2026 at 06:18:50AM +0800, kernel test robot wrote:
>> tree:   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094863506%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=fQm6QfsJ2ggaKoRJWCz4dsaquz7Wo3uhRnOexVUrTnQ%3D&reserved=0 master
>> head:   0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
>> commit: d5cae2261b86913e602452ce4a07e6aefc0f603b dma-contiguous: simplify numa cma area handling
>> date:   6 weeks ago
>> config: powerpc-randconfig-r133-20260709 (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260710%2F202607100652.WPUlEAfx-lkp%40intel.com%2Fconfig&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094899182%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=BkT0BYyJtniz6YPzGpYbO0jn2T7vBDBLaK2Tsh1LcnE%3D&reserved=0)
>> compiler: clang version 21.1.8 (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094917538%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=5%2BLVtRoojuNbhEMr3BhM2xF50PV%2FIYh%2FWw3ipDIWG%2FY%3D&reserved=0 2078da43e25a4623cab2d0d60decddf709aaea28)
>> sparse: v0.6.5-rc1
>> reproduce (this is a W=1 build): (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260710%2F202607100652.WPUlEAfx-lkp%40intel.com%2Freproduce&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094935016%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BrpcCLuNecZIfyF6N5X%2FFcHhdG9YzLBAErvBGHyjjak%3D&reserved=0)
> 
> 
>> All errors (new ones prefixed by >>):
>>
>>>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
>>     >>> defined in vmlinux.a(init/init_task.o)
>>     >>> referenced by head_44x.S:101 (arch/powerpc/kernel/head_44x.S:101)
>>     >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x42) in archive vmlinux.a
>> --
>>>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
>>     >>> defined in ./arch/powerpc/kernel/vmlinux.lds:133
>>     >>> referenced by head_44x.S:108 (arch/powerpc/kernel/head_44x.S:108)
>>     >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x4e) in archive vmlinux.a
> 
> I checked the patch and couldn't find obvious clue between the patch and
> the error.
> 
> commit d5cae2261b8691 only changes kernel/dma/contiguous.c, which is under
> CONFIG_DMA_CMA per kernel/dma/Makefile. In your config above, CONFIG_DMA_CMA
> is not even set, so the contigous.c should not be compiled. Could you help
> to double check? thanks!
> 
> - Feng
> 
>> Kconfig warnings: (for reference only)
>>     WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>>     Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>>     Selected by [y]:
>>     - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel%2Flkp-tests%2Fwiki&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C016c05b801ba48f2593f08dede2e29c2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192487094952205%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=sqz%2BJ2dpT3ZZjlQyyvAhgPdP9jS0kJLpbRKTcV4rM50%3D&reserved=0
> 


