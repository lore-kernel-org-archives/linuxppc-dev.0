Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C909C07548
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 15:50:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CF32087C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 15:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CF32087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BnNck2dRgzDqhm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 01:49:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BnNYw5QTWzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 01:47:32 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 08AFiOpg001653;
 Thu, 10 Sep 2020 10:44:24 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 08AFiO8E001652;
 Thu, 10 Sep 2020 10:44:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 10 Sep 2020 10:44:24 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remove the last set_fs() in common code,
 and remove it for x86 and powerpc v3
Message-ID: <20200910154423.GK28786@gate.crashing.org>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com>
 <20200909184001.GB28786@gate.crashing.org>
 <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 09, 2020 at 02:33:36PM -0700, Linus Torvalds wrote:
> On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > It will not work like this in GCC, no.  The LLVM people know about that.
> > I do not know why they insist on pushing this, being incompatible and
> > everything.
> 
> Umm. Since they'd be the ones supporting this, *gcc* would be the
> incompatible one, not clang.

This breaks the basic requirements of asm goto.

> So I'd phrase it differently. If gcc is planning on doing some
> different model for asm goto with outputs, that would be the
> incompatible case.

If we will do asm goto with outputs, the asm will still be a jump
instruction!  (It is not in LLVM!)

We probably *can* make asm goto have outputs (jump instructions can have
outputs just fine!  Just output reloads on jump instructions are hard,
because not always they are *possible*; but for asm goto it should be
fine).

Doing as LLVM does, and making the asm a "trapping" instruction, makes
it not a jump insn, and opens up whole new cans of worms (including
inferior code quality).  Since it has very different semantics, and we
might want to keep the semantics of asm goto as well anyway, this should
be called something different ("asm break" or "asm __anything" for
example).

It would be nice if they talked to us about it, too.  LLVM claims it
implements the GCC inline asm extension.  It already only is compatible
for the simplest of cases, but this would be much worse still :-(

> and honestly, (b) is actually inferior for the error cases, even if to
> a compiler person it might feel like the "RightThing(tm)" to do.
> Because when an exception happens, the outputs simply won't be
> initialized.

Sure, that is fine, and quite possible useful, but it is not the same as
asm goto.  asm goto is not some exception handling construct: it is a
jump instruction.

> Anyway, for either of those cases, the kernel won't care either way.
> We'll have to support the non-goto case for many years even if
> everybody were to magically implement it today, so it's not like this
> is a "you have to do it" thing.

Yes.

I'm just annoyed because of all the extra work created by people not
communicating.


Segher
