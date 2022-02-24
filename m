Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13305C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Feb 2022 17:33:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K4KkT4R1Xz3bcW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Feb 2022 04:33:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4K4Kk11B3pz2yLP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Feb 2022 04:32:56 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21OHTnZm019553;
 Thu, 24 Feb 2022 11:29:49 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 21OHTmdO019552;
 Thu, 24 Feb 2022 11:29:48 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 24 Feb 2022 11:29:48 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] powerpc: fix build errors
Message-ID: <20220224172948.GN614@gate.crashing.org>
References: <20220223135820.2252470-1-anders.roxell@linaro.org>
 <20220223135820.2252470-2-anders.roxell@linaro.org>
 <1645670923.t0z533n7uu.astroid@bobo.none>
 <1645678884.dsm10mudmp.astroid@bobo.none>
 <CAK8P3a28XEN7aH-WdR=doBQKGskiTAeNsjbfvaD5YqEZNM=v0g@mail.gmail.com>
 <1645694174.z03tip9set.astroid@bobo.none>
 <CAK8P3a1LgZkAV2wX03hAgx527MuiFt5ABWFp1bGdsTGc=8OmMg@mail.gmail.com>
 <1645700767.qxyu8a9wl9.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645700767.qxyu8a9wl9.astroid@bobo.none>
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
Cc: Anders Roxell <anders.roxell@linaro.org>,
 "# 3.4.x" <stable@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 24, 2022 at 09:13:25PM +1000, Nicholas Piggin wrote:
> Excerpts from Arnd Bergmann's message of February 24, 2022 8:20 pm:
> > Again, there should be a minimum number of those .machine directives
> > in inline asm as well, which tends to work out fine as long as the
> > entire kernel is built with the correct -march= option for the minimum
> > supported CPU, and stays away from inline asm that requires a higher
> > CPU level.
> 
> There's really no advantage to them, and they're ugly and annoying
> and if we applied the concept consistently for all asm they would grow 
> to a very large number.

The advantage is that you get machine code that *works*.  There are
quite a few mnemonics that translate to different instructions with
different machine options!  We like to get the intended instructions
instead of something that depends on what assembler options the user
has passed behind our backs.

> The idea they'll give you good static checking just doesn't really
> pan out.

That never was a goal of this at all.

-many was very problematical for GCC itself.  We no longer use it.


Segher
