Return-Path: <linuxppc-dev+bounces-24035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C94EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:37:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxmth6t85z2xSb;
	Sat, 11 Jul 2026 08:37:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783723068;
	cv=none; b=Ox96REfNrDFivavfo4VbC8S83K7RMSoDrBoDbbYifxf2VA40bvWWBUGY92eCjoJCLXCWr4LVbPkeZLc0H0BFJY+2ZMbJfJkgTq1VjVHCc64bN8oMwtkcjNNv/WCd33SRHePxY1T5+IWsXC2P8N47NgB2Os/3UhYUetgQRjUsE5QQKDiBq/uPpBRugyrVfuFyQXYegaom47qfOTXmNoJQJclykMOBxoPNzkL38rmDy/PjgqGRqS3OGgMnXPLbR+986cLO/9pYrNrncvTbotsjcExtjOTpUyFBpFM9IN6BNx+jzBGL3HQ58iuAS3IGhkFEhTz+7aaver/QMJ5n7aq8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783723068; c=relaxed/relaxed;
	bh=TsLZqe25Bg2E8d7AhewrbCTsf0pH4EyObAN5qi7E++w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWl7y8d4YP6G3m/TV6epP6In0wkdwZgxMKeepjDxZHl65ojkuVxA77Fv9pKu6B2VVAT9dl3/9Y+iMPMFHQ2nX4jG+O73gjLUuCWOdQvwu9DeKMVQVvX52UT8YAGpXv8oZI3pt3u6Y8QZFe1KB4Qz7iPWsS7WFb4wSMmr7CJHkL7/VaHNZEutpPnavpulJXJa22x8xnoe8MDHbVWNSiygmBJUd50hZ+pGD3wdHxzyKod9/+R9KK1XBVMmk3wZDj4UZ96cO3KNgm4UG9jj+dhLlebwgx/Hl4+Z4goZS0Vd+mxlAJYGmucfMMt3nmsLticOPpmyapeF2HwJrt8c9a/G1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTXOJZXU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTXOJZXU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxmtg34mHz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 08:37:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3EC943967;
	Fri, 10 Jul 2026 22:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416F61F000E9;
	Fri, 10 Jul 2026 22:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783723064;
	bh=TsLZqe25Bg2E8d7AhewrbCTsf0pH4EyObAN5qi7E++w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gTXOJZXUnLGGVUjnQYmIkMR9gThXna/fpTvYP72WoDQTrVsjo1jali1uZ2SJu5Y66
	 PwVLjQBpcSYXNzn0sRlynxfCnIhOmjD9KuzUFZZWdvLqcY4n2pC0qCurV8g+bFo/B6
	 xmGjG2iDagp47PUNDkeN8fwZmUu0Xgd4x1rLk5xxrlDgWrMDDC/qHnIp+e5JPX3Ox9
	 kjxyX/ohopezNHnc3AMM+mRW9Hiqns3RjzjAA422103rwTjvAI1NaUn4E6hg+eeVN4
	 Xa4iHqpoWCyTIyI6RH1cT6XbQ8MxIxkUU1AMfH+0CwkDJoG8JjpxL0R5yyePlDm7V/
	 6b9I2Xyv1IpmQ==
Date: Fri, 10 Jul 2026 18:37:40 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [powerpc:fixes-test 10/12] kernel/sched/core.c:7449:1: error:
 type specifier missing, defaults to 'int'; ISO C99 and later do not support
 implicit int
Message-ID: <20260710223740.GA2667378@ax162>
References: <202607110422.frjmJOf8-lkp@intel.com>
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
In-Reply-To: <202607110422.frjmJOf8-lkp@intel.com>

On Sat, Jul 11, 2026 at 04:54:17AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
> head:   afc2830892a128a13a65f677271a0a48aeb61b5e
> commit: 4747e17fe063720a30b1c0075bae3e8f8acd26f4 [10/12] powerpc/32: Use HAVE_PREEMPT_DYNAMIC_CALL instead of HAVE_PREEMPT_DYNAMIC_KEY
> config: powerpc-randconfig-002-20260711 (https://download.01.org/0day-ci/archive/20260711/202607110422.frjmJOf8-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607110422.frjmJOf8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607110422.frjmJOf8-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/sched/core.c:7449:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>     7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
>          | ^
>    include/linux/static_call.h:223:2: note: expanded from macro 'EXPORT_STATIC_CALL_TRAMP'
>      223 |         ARCH_ADD_TRAMP_KEY(name)
>          |         ^
> >> kernel/sched/core.c:7449:26: error: a parameter list without types is only allowed in a function definition
>     7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
>          |                          ^

This happens with GCC as well.

  In file included from include/linux/tracepoint.h:22,
                   from include/trace/syscall.h:5,
                   from include/linux/syscalls.h:95,
                   from include/linux/syscalls_api.h:1,
                   from kernel/sched/core.c:16:
  include/linux/static_call.h:223:9: warning: data definition has no type or storage class
    223 |         ARCH_ADD_TRAMP_KEY(name)
        |         ^~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
   7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
        | ^~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Wimplicit-int]
  kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
   7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
        | ^~~~~~~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:7449:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
        | ^~~~~~~~~~~~~~~~~~~~~~~~

-- 
Cheers,
Nathan

