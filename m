Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46991C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 21:03:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C5A22BED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 21:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C5A22BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BL9Mr156GzDqWQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 07:03:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BL9Jr1TNKzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2020 07:00:43 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 073L0W3B017027;
 Mon, 3 Aug 2020 16:00:32 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 073L0Vo5017020;
 Mon, 3 Aug 2020 16:00:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 3 Aug 2020 16:00:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 15/16] powerpc/powernv/sriov: Make single PE mode a
 per-BAR setting
Message-ID: <20200803210031.GD6753@gate.crashing.org>
References: <20200722065715.1432738-1-oohall@gmail.com>
 <20200722065715.1432738-15-oohall@gmail.com>
 <20200801061823.GA1203340@ubuntu-n2-xlarge-x86>
 <87r1sp19ag.fsf@mpe.ellerman.id.au>
 <20200803044609.GB195@Ryzen-9-3900X.localdomain>
 <87k0yg1dc8.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0yg1dc8.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nathan Chancellor <natechancellor@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>, clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 03, 2020 at 03:57:11PM +1000, Michael Ellerman wrote:
> > I would assume the function should still be generated since those checks
> > are relevant, just the return value is bogus.
> 
> Yeah, just sometimes missing warnings boil down to the compiler eliding
> whole sections of code, if it can convince itself they're unreachable.

Including when the compiler considers they must be unreachable because
they would perform undefined behaviour, like, act on uninitialised
values.  Such code is removed by cddce ("control dependence dead code
elimination", enabled by -ftree-dce at -O2 or above).

> AFAICS there's nothing weird going on here that should confuse GCC, it's
> about as straight forward as it gets.

Yes.  Please open a bug?

> Actually I can reproduce it with:
> 
> $ cat > test.c <<EOF
> int foo(void *p)
> {
>         unsigned align;
> 
>         if (!p)
>                 return align;
> 
>         return 0;
> }
> EOF
> 
> $ gcc -Wall -Wno-maybe-uninitialized -c test.c
> $
> 
> No warning.

The whole if() is deleted pretty early.

===
static int foo(void *p)
{
        unsigned align;

        if (!p)
                return align;

        return 42;
}
int bork(void) { return foo(0); }
===

doesn't warn either, although that always uses the uninitialised var
(actually, that code is *removed*, and it always does that "return 42").

> But I guess that's behaving as documented. The compiler can't prove that
> foo() will be called with p == NULL, so it doesn't warn.

-Wmaybe-uninitialized doesn't warn for this either, btw.


Segher
