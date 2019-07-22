Return-Path: <SRS0=Gm8F=VT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA1C76188
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 06:21:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3A221BE6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 06:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3A221BE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sWjH1WrXzDqTl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 16:21:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sWg13Pl9zDqS8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 16:19:57 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6M6JgeY030771;
 Mon, 22 Jul 2019 01:19:42 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x6M6JeD4030770;
 Mon, 22 Jul 2019 01:19:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 22 Jul 2019 01:19:40 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190722061940.GZ20882@gate.crashing.org>
References: <45hnfp6SlLz9sP0@ozlabs.org>
 <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
 <20190709064952.GA40851@archlinux-threadripper>
 <20190719032456.GA14108@archlinux-threadripper>
 <20190719152303.GA20882@gate.crashing.org>
 <20190719160455.GA12420@archlinux-threadripper>
 <20190721075846.GA97701@archlinux-threadripper>
 <20190721180150.GN20882@gate.crashing.org>
 <20190722024140.GA55142@archlinux-threadripper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722024140.GA55142@archlinux-threadripper>
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
Cc: linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jul 21, 2019 at 07:41:40PM -0700, Nathan Chancellor wrote:
> Hi Segher,
> 
> On Sun, Jul 21, 2019 at 01:01:50PM -0500, Segher Boessenkool wrote:
> > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
> > > 0000017c clear_user_page:
> > >      17c: 94 21 ff f0                  	stwu 1, -16(1)
> > >      180: 38 80 00 80                  	li 4, 128
> > >      184: 38 63 ff e0                  	addi 3, 3, -32
> > >      188: 7c 89 03 a6                  	mtctr 4
> > >      18c: 38 81 00 0f                  	addi 4, 1, 15
> > >      190: 8c c3 00 20                  	lbzu 6, 32(3)
> > >      194: 98 c1 00 0f                  	stb 6, 15(1)
> > >      198: 7c 00 27 ec                  	dcbz 0, 4
> > >      19c: 42 00 ff f4                  	bdnz .+65524
> > 
> > Uh, yeah, well, I have no idea what clang tried here, but that won't
> > work.  It's copying a byte from each target cache line to the stack,
> > and then does clears the cache line containing that byte on the stack.
> > 
> > I *guess* this is about "Z" and not about "%y", but you'll have to ask
> > the clang people.
> > 
> > Or it may be that they do not treat inline asm operands as lvalues
> > properly?  That rings some bells.  Yeah that looks like it.

The code is
  __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");

so yeah it looks like clang took that  *(u8 *)addr  as rvalue, and
stored that in stack, and then used *that* as memory.

Maybe clang simply does not not to treat "Z" the same as "m"?  (And "Y"
and "Q" and "es" and a whole bunch of "w*", what about those?)


Segher
