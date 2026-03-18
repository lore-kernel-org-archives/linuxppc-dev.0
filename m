Return-Path: <linuxppc-dev+bounces-18353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C9103E168
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 11:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbS5V2QyBz2ygd;
	Wed, 18 Mar 2026 22:58:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773835102;
	cv=none; b=l8zSYW6FuEc9/t6WjhJ/9yrnXFaF+4MhOskn2SDMwksuvKtCH3LYLIC/Bhv1vLZv8g/BzC4X2eg6tA99sh/YTnda4Hr5YfPTfIhdcOkv7bKVQfPMNemWSgrc3LyD+6dd0Gdr8TQ3SqbN7qk8MpXV/LurtEoPTR7FtGxA8Z1ki/IE1piwE6MjO3ttvqKiMqNWIpgubKafXcG6zVS0pgSh/ge+fxXQrVZWck5DPxoFMA2ZlzNWiWPI74uXIb+BaWqNaJ4eyudS9UY1eB3lbnytIHyJQndLAnFyacnyuNX60nizUScbv8zVvEW6kt6xIOiE42ECTB+ITFEZy23oLLTMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773835102; c=relaxed/relaxed;
	bh=rT+FbgzyEaxBZ+I4umAbAGevmZ1NRmsQ/xuQW/nAsUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkr0JHqpQcb8o1t9WzqUP7CescUcIABTAXzAgh2YfNsAS6pWxPVmaH/4SSr72qQ6ys32tFyym2PMcYYhvliYB68rZ8lOUo+4i3ccxGaS6MDDIs6O8kZOzet3ykeoDE4WvnLvSz1AbTiPxECEhUA5YVMSyaG9B+x5Q9RVxHrK300mhmg/3eFrIwINbGwsfFgvroPbETBJjNm/h0Rys6Vnqpx22dOQJ6+CQIPbkYNjHyBmzUCbrm6w+fJVP1CZHZV5MeVngTFBJHFWGgReGKAVptCUhEQN4jbXXbEIc/HZLVeVkRSM/en1X8U7GR96IqsDnVZiNLHxM+Ltghg3gtRkrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbS5T1DPFz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 22:58:20 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 62IBw0VZ966706;
	Wed, 18 Mar 2026 06:58:00 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 62IBw0G0966705;
	Wed, 18 Mar 2026 06:58:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 18 Mar 2026 06:58:00 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
Message-ID: <abqTSG-wg-9ahRTe@gate>
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <abqRvDiAI85w2bCe@gate>
 <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>
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
In-Reply-To: <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>

On Wed, Mar 18, 2026 at 12:54:30PM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2026 12:51, Segher Boessenkool wrote:
> > On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
> >> Return value of ps3_start_probe_thread() is not used, so code can be
> >> simplified to fix W=1 clang warnings:
> >>
> >>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
> > 
> > And this is exactly why -Werror is harmful.  A boring harmless warning
> > turned into a build break :-(
> 
> -Werror does not matter here. We do not want warnings either, assuming
> of course they are correct.
> 
> So if this warning is correct, then patch should be applied and WERROR
> is irrelevant.

The build is broken.  -Werror is positively harmful.

Yes, you want the warnings fixed, but maybe something else has priority
right now?


Segher

