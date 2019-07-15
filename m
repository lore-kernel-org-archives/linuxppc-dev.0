Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B8C76191
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 07:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC7220644
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 07:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC7220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nF3H33H0zDqVW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 17:07:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nF0w5z0tzDqSg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 17:05:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45nF0t693bz9sPK;
 Mon, 15 Jul 2019 17:05:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
In-Reply-To: <20190713235430.GZ14074@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org>
 <20190713131642.GU14074@gate.crashing.org>
 <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org>
Date: Mon, 15 Jul 2019 17:05:34 +1000
Message-ID: <87v9w393r5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Sun, Jul 14, 2019 at 07:45:15AM +0900, Masahiro Yamada wrote:
>> On Sat, Jul 13, 2019 at 10:17 PM Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> > On Sat, Jul 13, 2019 at 07:47:44AM -0500, Segher Boessenkool wrote:
>> > > On Sat, Jul 13, 2019 at 12:21:06PM +0900, Masahiro Yamada wrote:
>> > > > The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
>> > > > in a useful way because it is always overridden by the following code
>> > > > in the top Makefile:
>> > > >
>> > > >   # use the deterministic mode of AR if available
>> > > >   KBUILD_ARFLAGS := $(call ar-option,D)
>> > > >
>> > > > The code in the top Makefile was added in 2011, by commit 40df759e2b9e
>> > > > ("kbuild: Fix build with binutils <= 2.19").
>> > > >
>> > > > The KBUILD_ARFLAGS addition for ppc has always been dead code from the
>> > > > beginning.
>> > >
>> > > That was added in 43c9127d94d6 to replace my 8995ac870273 from 2007.
>> > >
>> > > Is it no longer supported to build a 64-bit kernel with a toolchain
>> > > that defaults to 32-bit, or the other way around?  And with non-native
>> > > toolchains (this one didn't run on Linux, even).
>> >
>> > It was an --enable-targets=all toolchain, somewhat common for crosses,
>> > if that matters.
>> 
>> I always use the same toolchain
>> for compile-testing PPC32/64.
>> 
>> I have never been hit by the issue you mention.
>> Somebody would have reported it if it were still a problem.
>
> But did you use --enable-targets=all?

I do. And I don't see any errors with this patch applied.

> The problem was empty archives IIRC.  Not a problem anymore with thin
> archives, maybe?

Maybe? Though I can't get it to break even before we switched to them.

>> Moreover, commit 43c9127d94d6
>> translated the environment variable "GNUTARGET"
>> into the command option "--target="
>> 
>> My powerpc-linux-ar does not know it:
>> 
>> powerpc-linux-ar: -t: No such file or directory
>
> Yes, that is why I used the environment variable, all binutils work
> with that.  There was no --target option in GNU ar before 2.22.

Yeah, we're not very good at testing with really old binutils, so I
guess we broke that.

I'm inclined to merge this, it doesn't seem to break anything, and it
fixes using --target on old binutils that don't have it.

cheers
