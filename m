Return-Path: <linuxppc-dev+bounces-24042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE275C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 07:40:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gy0xJ1PL2z2y8F;
	Sat, 11 Jul 2026 17:40:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783755652;
	cv=none; b=L6iMp9VX1/afr6W9NtIp+A9XTMHnsfnN/3NPAmjU56avWgAR1dW+318mxD/yJlFA3hAX9I8DtMHCVNASRsvprFW07aV9QhCPq/Gct3v3/R8gkO8oUUIl/meaua+M3KNpA+MhsLdjTPZSooHhbT+R93WXIQ3u6d89miYTezN/d+vYAHeJlK6Sf+cgyfwpNp4L0iaA5RlSVHEie5aSfluSaBcVLF0QM7dhnP2AfRYvI+UR24FVXE8den/rccgSW+GBP4XkoL4i8omkBiACjzvna0JOg6Lq1RWxXWcqcbGfwOjH0/UiyDj1IwxR3MWAIxSXhyRpXwJb3Kx4lEonY4elnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783755652; c=relaxed/relaxed;
	bh=2/7VqtZM9eXOWcQYQomZRp6vg3C7ps+yJ24JkWv1U8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehY9+DmLTwo+Dwo1mM08VK7rayD1XgIlMBqphHT5GLzvCdSF5NxXhBvqavPHQ42PLrbyYyp2E5nmIzF3/BzpnCm1CjJDI5JSliCAKHqEujsKydldQdP3X1AKz8CTC81xuo2dqGoR0Bmb3ZgyIVwcXJ5PQW3kn7NeLamap2vcqzMlHZV3HacOW/zBO3E7tkYo2x8gHw9J/IdEGFXCvBeN8DrJgYUbV0N3hdTwBBr8u4bx33c3CsmRGcKbYkj94pvI3pyfWVPJnjT37kb5AEv21UXO+mtcYWInjbLDI1K3HXGSPf049MuPy9zJepgVh/iCETrW1HZMCTGfFW8TSDtD1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWyKi7ml; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWyKi7ml;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gy0xG3RNcz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 17:40:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EB8A7404CE;
	Sat, 11 Jul 2026 07:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4E11F00A3A;
	Sat, 11 Jul 2026 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783755647;
	bh=2/7VqtZM9eXOWcQYQomZRp6vg3C7ps+yJ24JkWv1U8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iWyKi7mlmzdH/fxBmzalDY+4IY7DH0rkpEbogtp+wUSLLsjqypUVPoT+cJcCtTTCG
	 G3L/bXhEjSKF7UC5II+hDmw42eHkdn9S3cU9hIh+6JOHQqDc3CP5qkdLHyDFU+bmiw
	 6pnsLhe9Qz07Xt5ADxS+l9XRSRzZhWwkG5CgP0077tuMu18rgiFwENjtA0RafQ5H3/
	 HVNlSmAv9C4apryPSEP82kB7WVbg3PIXqmjlO2as0hY4YO2Zus/pYr/YzMNBaoifo9
	 fa2IS+6pSsIdQEBgeztVglFGYcP/7ZCjCvagH/zWaKAys3lenLOyH/ex5MGOyEAMO/
	 A78D26wvAn4TA==
Message-ID: <621a46b3-74a3-4a1f-b81f-f50ea18a541e@kernel.org>
Date: Sat, 11 Jul 2026 09:40:42 +0200
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
Subject: Re: [powerpc:fixes-test 10/12] include/linux/static_call.h:223:9:
 warning: data definition has no type or storage class
To: kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>
References: <202607110847.u4TL0RJC-lkp@intel.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <202607110847.u4TL0RJC-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/07/2026 à 03:52, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
> head:   afc2830892a128a13a65f677271a0a48aeb61b5e
> commit: 4747e17fe063720a30b1c0075bae3e8f8acd26f4 [10/12] powerpc/32: Use HAVE_PREEMPT_DYNAMIC_CALL instead of HAVE_PREEMPT_DYNAMIC_KEY
> config: powerpc-randconfig-001-20260711 (https://download.01.org/0day-ci/archive/20260711/202607110847.u4TL0RJC-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607110847.u4TL0RJC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607110847.u4TL0RJC-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from include/linux/tracepoint.h:22,
>                      from include/trace/syscall.h:5,
>                      from include/linux/syscalls.h:95,
>                      from include/linux/syscalls_api.h:1,
>                      from kernel/sched/core.c:16:
>>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
>       223 |         ARCH_ADD_TRAMP_KEY(name)

Looks like powerpc is missing ARCH_ADD_TRAMP() macro, introduced by 
commit 73f44fe19d35 ("static_call: Allow module use without exposing 
static_call_key") for x86. I missed it when adding inline static calls 
with commit f50b45626e05 ("powerpc/static_call: Implement inline static 
calls").

I will have to fix that before we can activate HAVE_PREEMPT_DYNAMIC_CALL.

Christophe


>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>>> kernel/sched/core.c:7449:1: warning: parameter names (without types) in function declaration
>     In file included from include/linux/tracepoint.h:22,
>                      from include/trace/syscall.h:5,
>                      from include/linux/syscalls.h:95,
>                      from include/linux/syscalls_api.h:1,
>                      from kernel/sched/core.c:16:
>>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7522:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7522:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7522:1: warning: parameter names (without types) in function declaration
>     In file included from include/linux/tracepoint.h:22,
>                      from include/trace/syscall.h:5,
>                      from include/linux/syscalls.h:95,
>                      from include/linux/syscalls_api.h:1,
>                      from kernel/sched/core.c:16:
>>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7769:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7769:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7769:1: warning: parameter names (without types) in function declaration
>     In file included from include/linux/tracepoint.h:22,
>                      from include/trace/syscall.h:5,
>                      from include/linux/syscalls.h:95,
>                      from include/linux/syscalls_api.h:1,
>                      from kernel/sched/core.c:16:
>>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7774:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
>       223 |         ARCH_ADD_TRAMP_KEY(name)
>           |         ^~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7774:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
>      7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     kernel/sched/core.c:7774:1: warning: parameter names (without types) in function declaration
>     cc1: some warnings being treated as errors
> 
> 
> vim +223 include/linux/static_call.h
> 
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  212
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  213  #define EXPORT_STATIC_CALL(name)					\
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  214  	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  215  	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  216  #define EXPORT_STATIC_CALL_GPL(name)					\
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  217  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  218  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> 9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  219
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  220  /* Leave the key unexported, so modules can't change static call targets: */
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  221  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  222  	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27 @223  	ARCH_ADD_TRAMP_KEY(name)
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  224  #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  225  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  226  	ARCH_ADD_TRAMP_KEY(name)
> 73f44fe19d35963 Josh Poimboeuf 2021-01-27  227
> 
> :::::: The code at line 223 was first introduced by commit
> :::::: 73f44fe19d359635a607e8e8daa0da4001c1cfc2 static_call: Allow module use without exposing static_call_key
> 
> :::::: TO: Josh Poimboeuf <jpoimboe@redhat.com>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


