Return-Path: <SRS0=luaH=AT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA733C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 01:01:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D681206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 01:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D681206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1gx50M8fzDqxM
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 11:01:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B1gtt3RsjzDqwT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 10:59:34 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0680xMRN027976;
 Tue, 7 Jul 2020 19:59:22 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0680xMwM027975;
 Tue, 7 Jul 2020 19:59:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 7 Jul 2020 19:59:22 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Failure to build librseq on ppc
Message-ID: <20200708005922.GW3598@gate.crashing.org>
References: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
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
Cc: Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Jeanson <mjeanson@efficios.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Tue, Jul 07, 2020 at 03:17:10PM -0400, Mathieu Desnoyers wrote:
> I'm trying to build librseq at:
> 
> https://git.kernel.org/pub/scm/libs/librseq/librseq.git
> 
> on powerpc, and I get these errors when building the rseq basic
> test mirrored from the kernel selftests code:
> 
> /tmp/ccieEWxU.s: Assembler messages:
> /tmp/ccieEWxU.s:118: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:118: Error: junk at end of line: `,8'
> /tmp/ccieEWxU.s:121: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:121: Error: junk at end of line: `,8'
> /tmp/ccieEWxU.s:626: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:626: Error: junk at end of line: `,8'
> /tmp/ccieEWxU.s:629: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:629: Error: junk at end of line: `,8'
> /tmp/ccieEWxU.s:735: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:735: Error: junk at end of line: `,8'
> /tmp/ccieEWxU.s:738: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:738: Error: junk at end of line: `,8'
> /tmp/ccieEWxU.s:741: Error: syntax error; found `,', expected `('
> /tmp/ccieEWxU.s:741: Error: junk at end of line: `,8'
> Makefile:581: recipe for target 'basic_percpu_ops_test.o' failed

You'll have to show the actual failing machine code, and with enough
context that we can relate this to the source code.

-save-temps helps, or use -S instead of -c, etc.

> I am using this compiler:
> 
> gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)
> Target: powerpc-linux-gnu
> 
> So far, I got things to build by changing "m" operands to "Q" operands.
> Based on https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
> it seems that "Q" means "A memory operand addressed by just a base register."

Yup.

> I suspect that lwz and stw don't expect some kind of immediate offset which
> can be kept with "m", and "Q" fixes this. Is that the right fix ?
> 
> And should we change all operands passed to lwz and stw to a "Q" operand ?

No, lwz and stw exactly *do* take an immediate offset.

It sounds like the compiler passed memory addressed by indexed
addressing, instead.  Which is fine for "m", and also fine for those
insns... well, you need lwzx and stwx.

So perhaps you have code like

  int *p;
  int x;
  ...
  asm ("lwz %0,%1" : "=r"(x) : "m"(*p));

where that last line should actually read

  asm ("lwz%X1 %0,%1" : "=r"(x) : "m"(*p));

?


Segher
