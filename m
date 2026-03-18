Return-Path: <linuxppc-dev+bounces-18355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E00103E16A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 12:13:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbSQV321jz2ygd;
	Wed, 18 Mar 2026 23:13:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773835986;
	cv=none; b=g1nmmCy62Mt0j0iCKkoG63SMKK4afJ48X+44/COr3/3E6+MZb7dA5ZiWtuCyZcrwoQBjCAI0ub5PGh4xaAx7xlDsWLUkfUnbd8bd5IF4V2vuLUqaK5MXoYdDeCP3CHnqO6iGytEWCpvxiXZAidGgb5cRFGGZy3HxQHj2rgW4dmUeL54RijuFs52nlhDImpo3x7XjekWkGAwbyDNfYvstx52R4QZw9iQbQZAv6KVN9IBr5Zc6+JLr1dMlOBCGw98/U3T7hZdrjqEkZXIlu5YkyeTmt1xRFjw96OwrYzs2C+MCED//u3J6lSCN58dNhYREEshYGqzXY0BicgQwC5wRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773835986; c=relaxed/relaxed;
	bh=8nvnayi9/aO39RmUhN8CYOuvMo2a8eME32bPOsZIYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3dlgnXcVTExrEIjBohTpRRXD/+WjcRk5U5w5V3O9t23Q1wpnsH0fqH2fAdZ6qe7jI0wr64yFsg5vAa8D411dDUa9E0UYEOTNITA/qiVHy6W/E6VK1Csjpc80FvJ04R44LmK3NHGpyCfHq8IT+mVSEk80k0W80iEVKrA5R4S6hOnbsbaWncrTOlJRKEIzXC4yriDHBl9iNt5IqW7YTyO2hVScaDabIPtZm/6560mtL8EgTYW2jBDZEviMNPbiwhDTjZQWgH13irz3L2MUvRlFe6BC8bbYlfo4rHMyx/FVKVrxS1zbGqtLKVLUFH8PokydowOa7M2Zz8blR+m+FcYRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbSQS5LZdz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 23:13:04 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 62ICCjZ6969638;
	Wed, 18 Mar 2026 07:12:45 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 62ICCi6v969637;
	Wed, 18 Mar 2026 07:12:44 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 18 Mar 2026 07:12:44 -0500
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
Message-ID: <abqWvBj5_t_Q-y6m@gate>
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <abqRvDiAI85w2bCe@gate>
 <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>
 <abqTSG-wg-9ahRTe@gate>
 <42b99f91-02bc-4062-93ad-02db3fe81b49@oss.qualcomm.com>
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
In-Reply-To: <42b99f91-02bc-4062-93ad-02db3fe81b49@oss.qualcomm.com>

On Wed, Mar 18, 2026 at 01:03:03PM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2026 12:58, Segher Boessenkool wrote:
> > On Wed, Mar 18, 2026 at 12:54:30PM +0100, Krzysztof Kozlowski wrote:
> >> On 18/03/2026 12:51, Segher Boessenkool wrote:
> >>> On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
> >>>> Return value of ps3_start_probe_thread() is not used, so code can be
> >>>> simplified to fix W=1 clang warnings:
> >>>>
> >>>>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
> >>>
> >>> And this is exactly why -Werror is harmful.  A boring harmless warning
> >>> turned into a build break :-(
> >>
> >> -Werror does not matter here. We do not want warnings either, assuming
> >> of course they are correct.
> >>
> >> So if this warning is correct, then patch should be applied and WERROR
> >> is irrelevant.
> > 
> > The build is broken.  -Werror is positively harmful.
> > 
> > Yes, you want the warnings fixed, but maybe something else has priority
> > right now?
> 
> What do you mean? This is waiting on the list for long time - note that
> it is a resend - so if warning is correct, for how long it should wait
> to get to the "priority" box?
> 
> And why anything needs even the priority here? Why priority has to be
> discussed, especially for some legacy (I think?) code? Why correct
> patches cannot be simply applied after some time/review?

It is totally simple: without -Werror, you can build a kernel.  With it,
you cannot.

The ***warning*** is correct, there is something in the code that can be
improved.  That is why such things are warnings: the compiler can
produce useful output, there is no reason to scream bloody murder.

The main reason some people like -Werror is because they are too lazy to
look at the warning messages they get from normal builds.  Such
developers need potty training, this is not a reason to punish all more
reasonable people!


Segher

