Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FCFC4332F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Dec 2022 18:14:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NYcgn0sCQz3cj9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Dec 2022 05:14:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NYcgB0hbnz2yfq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2022 05:13:57 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2BGIAnf3023871;
	Fri, 16 Dec 2022 12:10:49 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 2BGIAmSn023870;
	Fri, 16 Dec 2022 12:10:48 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 16 Dec 2022 12:10:48 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: Pass correct CPU reference to assembler
Message-ID: <20221216181048.GC25951@gate.crashing.org>
References: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu> <20221216171821.GA25951@gate.crashing.org> <73fc1107-b540-bec3-7625-c6e6d0641bbb@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73fc1107-b540-bec3-7625-c6e6d0641bbb@csgroup.eu>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Jan-Benedict Glaw <jbglaw@lug-owl.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 16, 2022 at 05:57:46PM +0000, Christophe Leroy wrote:
> Le 16/12/2022 à 18:18, Segher Boessenkool a écrit :
> > On Fri, Dec 16, 2022 at 09:35:50AM +0100, Christophe Leroy wrote:
> >> Today we have CONFIG_TARGET_CPU which provides the identification of the
> >> expected CPU, it is used for GCC. Use it as well for the assembler.
> > 
> > Why do you use -Wa, at all for this?  The compiler should already pass
> > proper options always!
> 
> That's historical I guess. Comes from commit 14cf11af6cf6 ("powerpc: 
> Merge enough to start building in arch/powerpc.")

Ah.  The patch moves stuff around, I thought more of it is new than it
really is.  Sorry.

It would be good to get rid of all such things that do no good and can
easily cause problems, of course, but that does not belong to this patch
of course.

> >> +cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)
> > 
> > What is this for?  Using -many is a huge step back, it hides many
> > problems :-(
> 
> The only thing I did is removed the -Wa,-mpower4 from the line, leaving 
> the remaining part. Initialy it was:
> 
> cpu-as-$(CONFIG_PPC_BOOK3S_64) += $(call as-option,-Wa$(comma)-mpower4) 
> $(call as-option,-Wa$(comma)-many)
> 
> It was added in 2018 by commit 960e30029863 ("powerpc/Makefile: Fix 
> PPC_BOOK3S_64 ASFLAGS"). There is a long explanation it the commit.
> 
> Should we remove it ?

The commit says it is a workaround for clang problems, so it needs
testing there.  It also needs testing everywhere else, because as I said
it hides a lot of problems, so removing it will make a lot of sloppy
code that has crept in since 2018 scream bloody murder :-(


Segher
