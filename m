Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92DCECAAD5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Sep 2022 16:02:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MK2jt74Vqz3bcw
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Sep 2022 02:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MK2jS0ZhXz2yfq
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2022 02:02:03 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 282Fxtno015877;
	Fri, 2 Sep 2022 10:59:55 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 282FxsqO015876;
	Fri, 2 Sep 2022 10:59:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 2 Sep 2022 10:59:54 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 2/2] powerpc/math-emu: Remove -w build flag and fix warnings
Message-ID: <20220902155954.GP25951@gate.crashing.org>
References: <a7384eafc6a27aea15bdc9e8f9a12aac593fccb7.1662113301.git.christophe.leroy@csgroup.eu> <35c86b7ca823954c6cd593acc3690dc3748da9b1.1662113301.git.christophe.leroy@csgroup.eu> <YxIjM/jdLajq4dFk@dev-arch.thelio-3990X>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxIjM/jdLajq4dFk@dev-arch.thelio-3990X>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 02, 2022 at 08:37:23AM -0700, Nathan Chancellor wrote:
> On Fri, Sep 02, 2022 at 12:08:55PM +0200, Christophe Leroy wrote:
> > This should have been detected by gcc at build time, but due to
> > '-w' flag it went undetected.
> > 
> > Removing that flag leads to many warnings hence errors.

> Thanks for figuring out what was going on here! I took this patch for a
> spin with clang and it has a few more errors around
> -Wimplicit-fallthrough:

Maybe add -Wno-implicit-fallthrough?  This code is a copy from outside
the kernel, no one has ever wanted to maintain it, if nothing else (the
more politically correct formulation is "we cannot as easily pick up
improvements from upstream if we modify stuff").


Segher
