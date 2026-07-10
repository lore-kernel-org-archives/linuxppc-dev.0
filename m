Return-Path: <linuxppc-dev+bounces-23983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274E3C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 02:51:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxGYs49jrz2xSb;
	Fri, 10 Jul 2026 12:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783651889;
	cv=none; b=OrEr996la7d1butQOU1LffPxCwRHSFe2Ljk9uo8WN7oxU6ubM1hpW1W3hn+uDbaOvw/qftGnjYyG9eaXS1vGDm2Ul/0yLV9As5iqb0FD6f1LtM/IRyrb6YiSOBm72M/nUWPv0zRWz6PvtT53evtOcBf0KBTVi4qIPTUpW/qqniMb5p4lkP4TF49EWn+XhCx4qSv3iDhl67kgaVUWnVfdlX8jrgnvwt5XnoOdr+hzXZJoJeZGgsuXIerMPs1RRLOzN+sO8dTjWeyLz6kNJigsNvQcZvm048MD9mZheQTVGXVfGJknSVqnEZqvorH2Qz2P1p0jIxgkA3UZ6IJoDHgJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783651889; c=relaxed/relaxed;
	bh=lUrJGNdkgOLm/MDj00ePOaZ/7kLX0+V9Jpn17brXOZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar4EKhkUE9R4LTRKIWBcCkzr1rKoEwsiQhYhpsxwSQaJg1vbA0lJStJdT+aj9hd6BXlDh1tUF71N01TkHhe3EAF/ShWm+4iCGZtbHrab9HPG1+WTScr1rnU+M4S0UhdHyXqPmC2C2EhS/lmE0O0IU/cm+R7hnhu0R/vwvop/6AiJ7FFeqfBRtSZpc7dPlXxYIGV0VlLYbJ7O9mbQT6yNumlIZQLsSD9k0LdT1WMh7rJqJdxGqtTAHEiSMgWFLrf8cyiBIKBXIEJ4zNJDF82cshdEEU6fNDWWTQpszg4VMaZLuwld2JxKgKQvbajAvPi7mhpyksJRYHcJ0Rk7ywcHRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A75GOVQo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A75GOVQo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxGYp44FQz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 12:51:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783651880; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=lUrJGNdkgOLm/MDj00ePOaZ/7kLX0+V9Jpn17brXOZc=;
	b=A75GOVQosJfXyS3dC6qtuCujURYJO8863iVeWvr6/VRhDD+nGfzaArUbZn4ufkjhXqOoI8PaGACJa8rdQb00G5haiE7EP4TwXzzW9Ui55Hu9zq8onwYXFx6eX3Nu5Lq5EgRsCZ+CX05vEimH1JLbGpAZcz911ANeR9WhpCIrM7g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X6mEdSu_1783651878;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X6mEdSu_1783651878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jul 2026 10:51:18 +0800
Date: Fri, 10 Jul 2026 10:51:17 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against
 symbol 'init_task'; recompile with -fPIC
Message-ID: <alBeJUafPKhx8RMS@U-2FWC9VHC-2323.local>
References: <202607100652.WPUlEAfx-lkp@intel.com>
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
In-Reply-To: <202607100652.WPUlEAfx-lkp@intel.com>

Thanks for the report!

Add Powerpc list.

On Fri, Jul 10, 2026 at 06:18:50AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> commit: d5cae2261b86913e602452ce4a07e6aefc0f603b dma-contiguous: simplify numa cma area handling
> date:   6 weeks ago
> config: powerpc-randconfig-r133-20260709 (https://download.01.org/0day-ci/archive/20260710/202607100652.WPUlEAfx-lkp@intel.com/config)
> compiler: clang version 21.1.8 (https://github.com/llvm/llvm-project 2078da43e25a4623cab2d0d60decddf709aaea28)
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260710/202607100652.WPUlEAfx-lkp@intel.com/reproduce)


> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
>    >>> defined in vmlinux.a(init/init_task.o)
>    >>> referenced by head_44x.S:101 (arch/powerpc/kernel/head_44x.S:101)
>    >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x42) in archive vmlinux.a
> --
> >> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
>    >>> defined in ./arch/powerpc/kernel/vmlinux.lds:133
>    >>> referenced by head_44x.S:108 (arch/powerpc/kernel/head_44x.S:108)
>    >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x4e) in archive vmlinux.a

I checked the patch and couldn't find obvious clue between the patch and
the error.

commit d5cae2261b8691 only changes kernel/dma/contiguous.c, which is under
CONFIG_DMA_CMA per kernel/dma/Makefile. In your config above, CONFIG_DMA_CMA
is not even set, so the contigous.c should not be compiled. Could you help
to double check? thanks!

- Feng

> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>    Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>    Selected by [y]:
>    - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

