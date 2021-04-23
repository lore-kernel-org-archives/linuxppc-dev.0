Return-Path: <SRS0=+E7l=JU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503DDC433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 17:02:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405616134F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 17:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405616134F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FRgZR2l8Tz30QX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Apr 2021 03:02:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FRgZ453Wsz2xb3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Apr 2021 03:02:02 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13NGviDx012674;
 Fri, 23 Apr 2021 11:57:44 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 13NGvgAY012668;
 Fri, 23 Apr 2021 11:57:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 23 Apr 2021 11:57:42 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 1/2] powerpc/sstep: =?utf-8?Q?A?=
 =?utf-8?Q?dd_emulation_support_for_=E2=80=98setb=E2=80=99?= instruction
Message-ID: <20210423165742.GO27473@gate.crashing.org>
References: <cover.1618469454.git.sathvika@linux.vnet.ibm.com>
 <767e53c4c27da024ca277e21ffcd0cff131f5c73.1618469454.git.sathvika@linux.vnet.ibm.com>
 <875z0mfzbf.fsf@linkitivity.dja.id.au>
 <20210422191334.GE27473@gate.crashing.org>
 <20210422221618.GA30594@lt-gp.iram.es>
 <20210422232616.GI27473@gate.crashing.org>
 <20210423102657.GA22427@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423102657.GA22427@lt-gp.iram.es>
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
Cc: Sathvika Vasireddy <sathvika@linux.vnet.ibm.com>,
 naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 23, 2021 at 12:26:57PM +0200, Gabriel Paubert wrote:
> On Thu, Apr 22, 2021 at 06:26:16PM -0500, Segher Boessenkool wrote:
> > > But this can be made jump free :-):
> > > 
> > > 	int tmp = regs->ccr << ra;
> > > 	op->val = (tmp >> 31) | ((tmp >> 30) & 1);
> > 
> > The compiler will do so automatically (or think of some better way to
> > get the same result); in source code, what matters most is readability,
> > or clarity in general (also clarity to the compiler).
> 
> I just did a test (trivial code attached) and the original code always
> produces one conditional branch at -O2, at least with the cross-compiler
> I have on Debian (gcc 8.3). I have tested both -m32 and -m64. The 64 bit
> version produces an unnecessary "extsw", so I wrote the second version
> splitting the setting of the return value which gets rid of it.

That is an older compiler, and it will be out-of-service any day now.

It depends on what compiler flags you use, and what version of the ISA
you are targetting.

> The second "if" is fairly simple to optimize and the compiler does it
> properly.

Yeah.

> Of course with my suggestion the compiler does not produce any branch. 
> But it needs a really good comment.

Or you could try and help improve the compiler ;-)  You can do this
without writing compiler code yourself, by writing up some good
enhancement request in bugzilla.

The wider and more OoO the processors become, the more important it
becomes to have branch-free code, in situations where the branches would
not be well-predictable.

> > (Right shifts of negative numbers are implementation-defined in C,
> > fwiw -- but work like you expect in GCC).
> 
> Well, I'm not worried about it, since I'd expect a compiler that does
> logical right shifts on signed valued to break so much code that it
> would be easily noticed (also in the kernel).

Yup.  And it *is* defined for signed values, as long as they are
non-negative (the common case).

> > > > Also, even people who write LE have the bigger end on the left normally
> > > > (they just write some things right-to-left, and other things
> > > > left-to-right).
> > > 
> > > Around 1985, I had a documentation for the the National's 32032
> > > (little-endian) processor family, and all the instruction encodings were
> > > presented with the LSB on the left and MSB on the right.
> > 
> > Ouch!  Did they write "regular" numbers with the least significant digit
> > on the left as well?
> 
> No, they were not that sadistic!

But more inconsistent :-)


Segher
